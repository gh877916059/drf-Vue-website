<template>
    <form id="pictureCropperForm">
        <div class="form-group">
            <h3><span class="label label-success">裁剪前：</span></h3>
        </div>

        <div class="form-group">
            <img id="beforeCroppingimg" v-bind:src="beforeCroppingImageData" alt="beforeCroppingPicture">
        </div>

        <div class="form-group">
            <button class="btn btn-primary btn-block" v-on:click="cropThePicture">裁剪</button>
        </div>

        <template v-if="afterCroppingImageData.length > 0">
            <div class="form-group">
                <h3><span class="label label-success">裁剪后：</span></h3>
            </div>

            <div class="form-group">
                <img id="afterCroppingimg" v-bind:src="afterCroppingImageData" alt="afterCroppingPicture">
            </div>

            <div class="form-group">
                <button class="btn btn-primary btn-block" v-on:click='uploadCoverPicture'>上传</button>
            </div>
        </template>
    </form>
</template>

<script>
    import $ from 'jquery';
    export default {
        data() {
            return {
                beforeCroppingImageData: '',
                imageType: '',
                imageName: '',
                croppable: false,
                afterCroppingImageData: '',
                minAspectRatio: 0.4,
                maxAspectRatio: 0.8
            };
        },
        mounted: function () {
            this.$nextTick(function () {
                // 阻止表单的默认提交操作
                $('#pictureCropperForm').submit(function (e) {
                    e.preventDefault();
                });
            });
        },
        methods: {
            // 异步上传封面图片
            uploadCoverPicture (event) {
                this.coverPictureURL = '';
                let bits = this.$root.convertBase64UrlToBlob(this.afterCroppingImageData);
                var file = new File([bits], this.imageName, {type: this.imageType});
                this.$emit('updatePictureFiles', file, this.afterCroppingImageData);
                this.$emit('closePictureCropperModal');
                if (file) {
                    const formData = new FormData();
                    formData.append('file', file);
                    this.$axios.post('uploadfile/case_cover_picture/', formData).then((res) => {
                        this.coverPictureURL = res.data['location'];
                        this.$emit('setCoverPictureURL', this.coverPictureURL);
                        this.$emit('closePictureCropperModal');
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
                }
            },
            cropThePicture: function () {
                if (!this.croppable) {
                    console.log('---当前不可裁剪，退出---');
                    return;
                }
                var croppedCanvas = $('#beforeCroppingimg').cropper('getCroppedCanvas');
                this.afterCroppingImageData = croppedCanvas.toDataURL();
                var image = new Image();
                image.src = this.afterCroppingImageData;
                var _vue = this;
                image.onload = function() {
                    var width = this.width;
                    var height = this.height;
                    _vue.$nextTick(function () {
                        var afterImg = $('#afterCroppingimg');
                        $(afterImg).width(width / 2);
                        $(afterImg).height(height / 2);
                    });
                };
            },
            destroyCropper: function () {
                // 销毁cropper组件
                $('#beforeCroppingimg').cropper('destroy');
            },
            initCropper: function(imageInfoDict) {
                this.beforeCroppingImageData = imageInfoDict['data'];
                var image = new Image();
                image.src = this.beforeCroppingImageData;
                this.imageType = imageInfoDict['type'];
                this.imageName = imageInfoDict['name'];
                this.afterCroppingImageData = '';
                var _vue = this;
                image.onload = function() {
                    var width = this.width;
                    var height = this.height;
                    _vue.$nextTick(function () {
                        this.croppable = false;
                        // 初始化cropper组件
                        $('#beforeCroppingimg').cropper({
                            viewMode: 0,
                            minContainerHeight: height * 0.5,
                            minContainerWidth: width * 0.5,
                            minCanvasHeight: height * 0.5,
                            minCanvasWidth: width * 0.5,
                            aspectRatio: ((this.minAspectRatio + this.maxAspectRatio) / 2),
                            ready: function () {
                                var $image = $('#beforeCroppingimg');
                                var containerData = $image.cropper('getContainerData');
                                var cropBoxData = $image.cropper('getCropBoxData');
                                var aspectRatio = cropBoxData.width / cropBoxData.height;
                                var newCropBoxWidth;
                                // 如果宽高比不在规定范围内，则要对剪裁框进行强制放缩
                                if (aspectRatio < this.minAspectRatio || aspectRatio > this.maxAspectRatio) {
                                    newCropBoxWidth = cropBoxData.height * ((this.minAspectRatio + this.maxAspectRatio) / 2);
                                    $image.cropper('setCropBoxData', {
                                        left: (containerData.width - newCropBoxWidth) / 2,
                                        width: newCropBoxWidth
                                    });
                                }
                                this.croppable = true;
                            }.bind(this),
                            cropmove: function () {
                                var $image = $('#beforeCroppingimg');
                                var cropBoxData = $image.cropper('getCropBoxData');
                                var aspectRatio = cropBoxData.width / cropBoxData.height;
                                if (aspectRatio < this.minAspectRatio) {
                                    $image.cropper('setCropBoxData', {
                                        width: cropBoxData.height * this.minAspectRatio
                                    });
                                } else if (aspectRatio > this.maxAspectRatio) {
                                    $image.cropper('setCropBoxData', {
                                        width: cropBoxData.height * this.maxAspectRatio
                                    });
                                }
                            }.bind(this)
                        });
                    }.bind(_vue));
                };
            }
        }
    };
</script>
