<template>
    <div>
        <form id="richTextEditorForm" enctype="multipart/form-data">

            <div class="form-group">
                <label>案例名称：</label>
                <input type="text" class="form-control" v-model="name" name="name" placeholder="请输入案例名称" data-required-error="案例名称不可以为空" required>
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label>案例简短描述：</label>
                <input type="text" class="form-control" v-model="cases_brief" name="cases_brief" placeholder="请输入案例简短描述" data-required-error="案例简短描述不可以为空" required>
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label>案例类别：</label>
                <select name="category_name" v-model="category_name">
                    <optgroup v-for="parentCategory in categoryList" v-bind:label="parentCategory.name">
                        <option v-for="subCategory in parentCategory.sub_cat">{{subCategory.name}}</option>
                    </optgroup>
                </select>
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <textarea id="MyTextArea">请在这里编辑案例介绍</textarea>
            </div>

            <div class="form-group">
                <input type="file" accept="image/*" id="coverPictureImg"/>
            </div>

            <div class="form-group">
                <input type="hidden" name="cases_front_image" v-bind:value="coverPictureURL"/>
            </div>

            <input type="submit" class="btn btn-primary btn-block" v-on:click='postFormData' value="提交"></input>
        </form>
        <div class="modal fade" id="pictureCropperModal" tabindex="-1" role="dialog" aria-labelledby="pictureCropperModal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title text-center">剪裁图片</h4>
                    </div>
                    <picture-cropper v-on:setCoverPictureURL="setCoverPictureURL" ref="pictureCropperModal" v-on:closePictureCropperModal="closePictureCropperModal"></picture-cropper>
                </div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
    import $ from 'jquery';
    import JQuery from 'jquery/dist/jquery.slim';
    import pictureCropper from './pictureCropper.vue';
    import Constants from '../constants';
    import Utils from '../utils';
    import axios from 'axios';
    import {Component, Vue, Prop} from 'vue-property-decorator';
    import {CaseCategory, KeyValueDict, Dict} from '../commonType';
    import {jumpToThisPage} from '../router';
    @Component({
        components: {
            pictureCropper
        }
    })
    export default class caseEditorForm extends Vue{
        @Prop({type: String, default: ''})
        caseId: string;
        name: string = '';
        cases_brief: string ='';
        category_name: string = '';
        categoryList: CaseCategory[] = [];
        coverPictureURL: string = Constants.REQUEST_HOST + '/static/image/fail.jpg';
        categoryNameToId: Dict = {};
        imageData: string = '';
        coverPictureType: string = '';
        coverPictureName: string = '';
        $pictureInput: JQuery<HTMLElement>|null = null;
        get coverPictureFileName(): string{
            return Utils.convertURLtoRawFileName(this.coverPictureURL);
        }
        get completePictureFileName(): string{
            return Utils.convertURLtoCompleteFileName(this.coverPictureURL);
        }
        // 加载强大的富文本编辑器TinyMCE
        initTinyMCE(successCallback: (() => void)|undefined): void{
            // Remove all editors
            (<any>window).tinymce.remove();
            // 初始化富文本编辑器TinyMCE
            (<any>window).tinymce.init({
                selector: '#MyTextArea',
                branding: false,
                language_url: Constants.REQUEST_HOST + '/static/js/zh_CN.js',  // site absolute URL
                height: 500,
                menubar: false,
                paste_data_images: true,
                plugins: [
                    'advlist autolink lists link image charmap print preview anchor textcolor colorpicker',
                    'searchreplace visualblocks code fullscreen',
                    'insertdatetime media table contextmenu paste code help'
                ],
                toolbar: 'insert | undo redo |  formatselect image | bold italic strikethrough forecolor backcolor  | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help',
                // 配置了该选项后，才能进行上传文件
                images_upload_url: Constants.REQUEST_HOST + '/uploadfile/rich_text_picture/',
                images_upload_handler: function (blobInfo, success, failure) {
                    var formData = new FormData();
                    formData.append('file', blobInfo.blob(), blobInfo.filename());
                    axios.post('uploadfile/rich_text_picture/', formData).then((res) => {
                        success(Constants.REQUEST_HOST + res.data['location']);
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                        failure(errorReasonDict['detail']);
                    });
                }.bind(this),
                content_css: [
                    '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
                    '//www.tinymce.com/css/codepen.min.css'],
                init_instance_callback: successCallback
            });
        }
        getBootstrapInputConfig(): Dict{
            let config = {
                showUpload: true,  // 显示上传文件按钮
                uploadUrl: Constants.REQUEST_HOST + '/uploadfile/case_cover_picture/',    // 为了显示文件拖拽功能，必须开启
                language: 'zh', // 简体中文
                ajaxSettings: {headers: {Authorization: axios.defaults.headers.common['Authorization']}}, // 添加HTTP验证头信息
                ajaxDeleteSettings: {headers: {Authorization: axios.defaults.headers.common['Authorization']}}, // 添加HTTP验证头信息
                deleteExtraData: {case_id: this.caseId},    // 对应于filebeforedelete事件的data参数
                initialCaption: '请上传案例封面图片',
                browseClass: 'btn btn-success',
                browseLabel: '选择图片',
                browseIcon: '<i class=\"glyphicon glyphicon-picture\"></i> '
            };
            if (this.coverPictureFileName.lastIndexOf('.') > 0) {
                config['initialPreview'] = [
                    '<img src="' + this.coverPictureURL + '" class="kv-preview-data file-preview-image">'
                ];
                // 由于initialPreview是HTML原生标签，所以previewAsData应该为false
                // key对应于filebeforedelete事件的key参数
                config['initialPreviewConfig'] = [
                    {previewAsData: false, type: 'image', caption: this.coverPictureFileName, url: Constants.REQUEST_HOST + '/deletefile/case_cover_picture/', key: this.completePictureFileName, downloadUrl: false}
                ];
                config['initialCaption'] = this.coverPictureFileName + '（已上传）';
            }
            return config;
        }
        // 提交案例相关信息和富文本框内容
        postFormData(): void{
            (<any>window).tinymce.activeEditor.uploadImages(function(this: caseEditorForm, success) {
                let postData = Utils.getFormInput('richTextEditorForm');
                let casesDesc: string = (<any>window).tinymce.activeEditor.getContent();
                casesDesc = Utils.deleteAllHostInImgLabel(casesDesc);
                postData['cases_desc'] = casesDesc;
                postData['category_id'] = this.categoryNameToId[postData['category_name']];
                postData['cases_front_image'] = Utils.deleteHost(postData['cases_front_image']);
                delete postData['category_name'];
                if (this.caseId.length > 0) {
                    axios.put('cases/' + this.caseId + '/', postData).then(function (this: caseEditorForm, res) {
                        jumpToThisPage('/viewCase/' + this.caseId);
                    }.bind(this), (err) => {
                        console.log('---err.body---');
                        console.log(err.body);
                    });
                } else {
                    axios.post('cases/', postData).then(function (res) {
                        console.log('---res.data---');
                        console.log(res.data);
                        jumpToThisPage('/viewCase/' + res.data['id']);
                    }, (err) => {
                        console.log('---err.body---');
                        console.log(err.body);
                    });
                }
            }.bind(this));
        }
        // 读取封面图片，准备进行裁剪并上传
        readPictureData(): void {
            if(this.$pictureInput) {
                let file: File = (<any>this.$pictureInput).fileinput('getFileStack')[0];
                let imageInfoDict: KeyValueDict = {};
                imageInfoDict['type'] = file.type;
                imageInfoDict['name'] = file.name;
                let reader: FileReader = new FileReader();
                reader.onload = function (this: caseEditorForm, evt) {
                    imageInfoDict['data'] = evt.target.result;
                    // 强制触发子组件initCropper()函数
                    // this.$refs.pictureCropperModal.initCropper(imageInfoDict);
                    (<pictureCropper>this.$refs.pictureCropperModal).loadPicture(imageInfoDict);
                    this.openPictureCropperModal();
                }.bind(this);
                reader.readAsDataURL(file);
            }
        }
        // 请求案例分类信息
        getCategoryInfo(): void{
            axios.get('categorys/')
                .then((res) => {
                    this.categoryList = res.data;
                    for (let index1 in this.categoryList) {
                        let subCategoryList = <CaseCategory[]>this.categoryList[index1].sub_cat;
                        for (let subCategory of subCategoryList) {
                            this.categoryNameToId[subCategory.name] = subCategory.id;
                        }
                    }
                }, (err) => {
                    let errorReasonDict: Dict = err.body;
                    console.log('---errorReasonDict---');
                    console.log(errorReasonDict);
                });
        }
        getCaseInfoById(): void{
            axios.get('cases/' + this.caseId + '/')
                .then((res) => {
                    this.category_name = res.data['category']['name'];
                    this.name = res.data['name'];
                    this.cases_brief = res.data['cases_brief'];
                    this.setCoverPictureURL(res.data['cases_front_image']);
                    let casesDesc = res.data['cases_desc'];
                    casesDesc = Utils.completeAllHostInImgLabel(casesDesc);
                    (<any>window).tinymce.activeEditor.setContent(casesDesc);
                    this.refreshBootstrapInput();
                }, (err) => {
                    var errorReasonDict = err.body;
                    console.log('---errorReasonDict---');
                    console.log(errorReasonDict);
                });
        }
        closePictureCropperModal(): void{
            $('#pictureCropperModal').modal('hide');
        }
        openPictureCropperModal(): void{
            // backdrop 为 static 时，点击模态对话框的外部区域不会将其关闭
            // keyboard 为 false 时，按下 Esc 键不会关闭 Modal
            $('#pictureCropperModal').modal({backdrop: 'static', keyboard: false});
        }
        setCoverPictureURL(coverPictureURL): void{
            this.coverPictureURL = Constants.REQUEST_HOST + coverPictureURL;
        }
        confirmDeletion(): boolean{
            var aborted = !window.confirm('你确定要删除该封面图片吗?');
            if (aborted) {
                window.alert('删除操作被中止!');
                return true;
            }
            return false;
        }
        initBootstrapInput(): void{
            if(this.$pictureInput) {
                (<any>this.$pictureInput).fileinput(this.getBootstrapInputConfig());
                this.$nextTick(function () {
                    $('button.close.fileinput-remove').css('display', 'none');
                });
            }
        }
        refreshBootstrapInput(): void{
            if(this.$pictureInput) {
                (<any>this.$pictureInput).fileinput('destroy');
                this.initBootstrapInput();
            }
        }
        mounted(): void{
            this.$nextTick(function () {
                // 阻止表单的默认提交操作
                $('#richTextEditorForm').submit(function (e) {
                    e.preventDefault();
                });
                this.getCategoryInfo();
                // 如果caseId不为空，则为修改已经存在的案例，而不是新建
                if (this.caseId.length > 0) {
                    this.initTinyMCE(this.getCaseInfoById);
                } else {
                    this.initTinyMCE(undefined);
                }
                $('#pictureCropperModal').on('hidden.bs.modal', function (this: caseEditorForm, e) {
                    // 强制触发子组件destroyCropper()函数
                    (<pictureCropper>this.$refs.pictureCropperModal).destroyCropper();
                    this.refreshBootstrapInput();
                }.bind(this));
                this.$pictureInput = $('#coverPictureImg');
                // 利用bootstrap-input插件初始化封面图片文件选择器
                this.initBootstrapInput();
                this.$pictureInput.on('filebeforedelete',
                    function(this: caseEditorForm, event, key, data) {
                        return this.confirmDeletion();
                    }.bind(this)
                );
                this.$pictureInput.on('fileselect', function(this:caseEditorForm) {
                    this.readPictureData();
                }.bind(this));
            });
        }
    };
</script>

<style>
    body {
        padding: 5px
    }
</style>
