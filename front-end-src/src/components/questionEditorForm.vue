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

<script>
    import $ from 'jquery';
    export default {
        props: {
            questionId: {
                type: String,
                default: ''
            }
        },
        data() {
            return {
                name: '',
                label_1: '',
                label_2: '',
                label_3: '',
                label_4: '',
                label_5: '',
                $pictureInput: null
            };
        },
        methods: {
            // 加载强大的富文本编辑器TinyMCE
            initTinyMCE () {
                // Remove all editors
                window.tinymce.remove();
                // 初始化富文本编辑器TinyMCE
                window.tinymce.init({
                    selector: '#MyTextArea',
                    branding: false,
                    language_url: this.$root.$data.requestHost + '/static/js/zh_CN.js',  // site absolute URL
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
                    images_upload_url: this.$root.$data.requestHost + '/uploadfile/rich_text_picture/',
                    images_upload_handler: function (blobInfo, success, failure) {
                        var formData = new FormData();
                        formData.append('file', blobInfo.blob(), blobInfo.filename());
                        this.$axios.post('uploadfile/rich_text_picture/', formData).then((res) => {
                            success(res.data['location']);
                        }, (err) => {
                            var errorReasonDict = err.body;
                            console.log('---errorReasonDict---');
                            console.log(errorReasonDict);
                            failure(errorReasonDict['detail']);
                        });
                    }.bind(this),
                    content_css: [
                        '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
                        '//www.tinymce.com/css/codepen.min.css']
                });
            },
            // 提交案例相关信息和富文本框内容
            postFormData: function () {
                window.tinymce.activeEditor.uploadImages(function(success) {
                    var postData = this.$root.getFormInput('richTextEditorForm');
                    var questionsDesc = window.tinymce.activeEditor.getContent();
                    postData['question_desc'] = questionsDesc;
                    if (this.questionId.length > 0) {
                        this.$axios.put('questions/' + this.questionId + '/', postData).then(function (res) {
                            console.log('---res.data---');
                            console.log(res.data);
                            this.$root.jumpToThisPage('/viewQuestion/' + this.questionId);
                        }, (err) => {
                            console.log('---err.body---');
                            console.log(err.body);
                        });
                    } else {
                        this.$axios.post('questions/', postData).then(function (res) {
                            console.log('---res.data---');
                            console.log(res.data);
                            this.$root.jumpToThisPage('/viewQuestion/' + res.data['id']);
                        }, (err) => {
                            console.log('---err.body---');
                            console.log(err.body);
                        });
                    }
                }.bind(this));
            },
            getQuestionInfoById () {
                this.$axios.get('questions/' + this.questionId + '/')
                    .then((res) => {
                        this.name = res.data['name'];
                        this.label_1 = res.data['label_1'];
                        this.label_2 = res.data['label_2'];
                        this.label_3 = res.data['label_3'];
                        this.label_4 = res.data['label_4'];
                        this.label_5 = res.data['label_5'];
                        var questionDesc = res.data['question_desc'];
                        $('#richTextEditorDiv').html(questionDesc);
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                // 阻止表单的默认提交操作
                $('#richTextEditorForm').submit(function (e) {
                    e.preventDefault();
                });
                // 如果questionId不为空，则为修改已经存在的案例，而不是新建
                if (this.questionId.length > 0) {
                    this.getQuestionInfoById();
                }
                this.initTinyMCE();
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
