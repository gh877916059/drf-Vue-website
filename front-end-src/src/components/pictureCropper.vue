<template>
    <form id="avatarForm">
        <div class="avatar-body">
            <div class="row">
                <div class="col-md-9">
                    <div class="avatar-wrapper"></div>
                </div>
                <div class="col-md-3">
                    <div class="avatar-preview preview-lg"></div>
                    <div class="avatar-preview preview-md"></div>
                    <div class="avatar-preview preview-sm"></div>
                </div>
            </div>
            <div class="row avatar-btns" v-on:click="rotate">
                <div class="col-md-9">
                    <div class="btn-group">
                        <button class="btn" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"><i class="fa fa-undo"></i> 向左旋转</button>
                    </div>
                    <div class="btn-group">
                        <button class="btn" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"><i class="fa fa-repeat"></i> 向右旋转</button>
                    </div>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-success btn-block" v-on:click="uploadCoverPicture"><i class="fa fa-save"></i> 上传</button>
                </div>
            </div>
        </div>
    </form>
</template>

<script lang="ts">
    import $ from 'jquery';
    import JQuery from 'jquery/dist/jquery.slim';
    import Utils from '../utils';
    import {Component, Vue} from 'vue-property-decorator';
    import axios from 'axios';

    @Component
    export default class pictureCropper extends Vue{
        active: boolean = false;
        pictureDataUri: string = '';
        imageName: string ='';
        imageType: string = '';
        avatarPreviewSelector: string = '.avatar-preview';
        $avatarForm: JQuery<HTMLElement>|null = null;
        $avatarWrapper: JQuery<HTMLElement>|null = null;
        $avatarPreview: JQuery<HTMLElement>|null = null;
        $img: JQuery<HTMLElement>|null = null;
        mounted() {
            this.$nextTick(function(this: pictureCropper) {
                this.$avatarForm = $('#avatarForm');
                // 阻止表单的默认提交操作
                this.$avatarForm.submit(function (e) {
                    e.preventDefault();
                });
                this.$avatarWrapper = this.$avatarForm.find('.avatar-wrapper');
                this.$avatarPreview = this.$avatarForm.find('.avatar-preview');
            });
        }
        rotate(e) {
            let data;
            if (this.active) {
                data = $(e.target).data();
                if (data.method && this.$img) {
                    (<any>this.$img).cropper(data.method, data.option);
                }
            }
        }
        // 异步上传封面图片
        uploadCoverPicture() {
            var afterCroppingImageData = this.cropThePicture();
            let bits = Utils.convertBase64UrlToBlob(afterCroppingImageData);
            var file = new File([bits], this.imageName, {type: this.imageType});
            if (file) {
                const formData = new FormData();
                formData.append('file', file);
                axios.post('uploadfile/case_cover_picture/', formData).then((res) => {
                    this.$emit('setCoverPictureURL', res.data['location']);
                    this.$emit('closePictureCropperModal');
                }, (err) => {
                    let errorReasonDict = err.body;
                    console.log('---errorReasonDict---');
                    console.log(errorReasonDict);
                });
            }
        }
        cropThePicture() {
            if(this.$img) {
                let croppedCanvas = (<any>this.$img).cropper('getCroppedCanvas');
                return croppedCanvas.toDataURL();
            }
        }
        destroyCropper() {
            if (this.active && this.$img) {
                (<any>this.$img).cropper('destroy');
                this.$img.remove();
                this.active = false;
            }
        }
        loadPicture(imageInfoDict) {
            this.pictureDataUri = imageInfoDict['data'];
            this.imageType = imageInfoDict['type'];
            this.imageName = imageInfoDict['name'];
            if(this.$avatarPreview) {
                this.$avatarPreview.empty().html('<img src="' + this.pictureDataUri + '">');
            }
            if (this.active && this.$img) {
                (<any>this.$img).cropper('replace', this.pictureDataUri);
            } else if(this.$avatarWrapper) {
                this.$img = $('<img src="' + this.pictureDataUri + '">');
                this.$avatarWrapper.empty().html(<any>this.$img);
                (<any>this.$img).cropper({
                    aspectRatio: 1.78,
                    preview: this.avatarPreviewSelector,
                    strict: false
                });
                this.active = true;
            }
        }
    };
</script>

<style lang="scss">
    .avatar-body {
        padding-right: 15px;
        padding-left: 15px;
    }
    .avatar-wrapper {
        height: 364px;
        width: 100%;
        margin-top: 15px;
        box-shadow: inset 0 0 5px rgba(0,0,0,.25);
        background-color: #fcfcfc;
        overflow: hidden;
    }
    .avatar-wrapper img {
        display: block;
        height: auto;
        max-width: 100%;
    }
    .avatar-preview {
        float: left;
        margin-top: 15px;
        margin-right: 15px;
        border: 1px solid #eee;
        border-radius: 4px;
        background-color: #fff;
        overflow: hidden;
    }
    .avatar-preview:hover {
        border-color: #ccf;
        box-shadow: 0 0 5px rgba(0,0,0,.15);
    }
    .avatar-preview img {
        width: 100%;
    }
    .preview-lg {
        height: 184px;
        width: 184px;
        margin-top: 15px;
    }
    .preview-md {
        height: 100px;
        width: 100px;
    }
    .preview-sm {
        height: 50px;
        width: 50px;
    }
    @media (min-width: 992px) {
        .avatar-preview {
            float: none;
        }
    }
    .avatar-btns {
        margin-top: 30px;
        margin-bottom: 15px;
    }
    .avatar-btns .btn-group {
        margin-right: 5px;
    }
    .loading {
        display: none;
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        opacity: .75;
        filter: alpha(opacity=75);
        z-index: 20140628;
    }
</style>
