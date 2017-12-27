<template>
    <div>
        <form id="richTextEditorForm" enctype="multipart/form-data">
            <div class="form-group">
                <label>问题名称：</label>
                <input type="text" class="form-control" v-model="name" name="name" placeholder="请输入问题名称" data-required-error="问题名称不可以为空" required>
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label>问题标签1：</label>
                <input type="text" class="form-control" v-model="label_1" name="label_1" placeholder="问题标签1">
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label>问题标签2：</label>
                <input type="text" class="form-control" v-model="label_2" name="label_2" placeholder="问题标签2">
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label>问题标签3：</label>
                <input type="text" class="form-control" v-model="label_3" name="label_3" placeholder="问题标签3">
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label>问题标签4：</label>
                <input type="text" class="form-control" v-model="label_4" name="label_4" placeholder="问题标签4">
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <label>问题标签5：</label>
                <input type="text" class="form-control" v-model="label_5" name="label_5" placeholder="问题标签5">
                <div class="help-block with-errors"></div>
            </div>

            <div class="form-group">
                <textarea id="MyTextArea">请在这里编辑案例介绍</textarea>
            </div>

            <input type="submit" class="btn btn-primary btn-block" v-on:click='postFormData' value="提交"></input>
        </form>
    </div>
</template>

<script lang="ts">
    import $ from 'jquery';
    import Constants from '../constants';
    import Utils from '../utils';
    import axios from 'axios';
    import {jumpToThisPage} from '../router';
    import {Component, Vue, Prop} from 'vue-property-decorator';
    import {Mutation} from 'vuex-class';
    @Component
    export default class questionEditorForm extends Vue{
        name: string = '';
        label_1: string = '';
        label_2: string = '';
        label_3: string = '';
        label_4: string = '';
        label_5: string = '';
        $pictureInput: JQuery<HTMLElement>|null = null;
        @Prop({type: String, default: ''})
        questionId: string;
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
        // 提交案例相关信息和富文本框内容
        postFormData() {
            (<any>window).tinymce.activeEditor.uploadImages(function(this: questionEditorForm, success) {
                var postData = Utils.getFormInput('richTextEditorForm');
                var questionsDesc = (<any>window).tinymce.activeEditor.getContent();
                postData['question_desc'] = questionsDesc;
                if (this.questionId.length > 0) {
                    axios.put('questions/' + this.questionId + '/', postData).then(function (this: questionEditorForm, res) {
                        console.log('---res.data---');
                        console.log(res.data);
                        jumpToThisPage('/viewQuestion/' + this.questionId);
                    }.bind(this), (err) => {
                        console.log('---err.body---');
                        console.log(err.body);
                    });
                } else {
                    axios.post('questions/', postData).then(function (res) {
                        console.log('---res.data---');
                        console.log(res.data);
                        jumpToThisPage('/viewQuestion/' + res.data['id']);
                    }, (err) => {
                        console.log('---err.body---');
                        console.log(err.body);
                    });
                }
            }.bind(this));
        }
        getQuestionInfoById(): void{
            axios.get('questions/' + this.questionId + '/')
                .then((res) => {
                    this.name = res.data['name'];
                    this.label_1 = res.data['label_1'];
                    this.label_2 = res.data['label_2'];
                    this.label_3 = res.data['label_3'];
                    this.label_4 = res.data['label_4'];
                    this.label_5 = res.data['label_5'];
                    let questionDesc = res.data['question_desc'];
                    $('#richTextEditorDiv').html(questionDesc);
                }, (err) => {
                    let errorReasonDict = err.body;
                    console.log('---errorReasonDict---');
                    console.log(errorReasonDict);
                });
        }
        mounted(): void{
            this.$nextTick(function (this: questionEditorForm) {
                // 阻止表单的默认提交操作
                $('#richTextEditorForm').submit(function (e) {
                    e.preventDefault();
                });
                // 如果questionId不为空，则为修改已经存在的案例，而不是新建
                if (this.questionId.length > 0) {
                    this.getQuestionInfoById();
                }
                this.initTinyMCE(undefined);
            });
        }
    };
</script>

<style>
    body {
        padding: 5px
    }
    .cover-picture-tip {
        color:red;
    }
</style>
