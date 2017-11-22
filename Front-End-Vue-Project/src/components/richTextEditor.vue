<template>
    <form id="richTextEditorForm">

        <div class="form-group">
            <label>案例名称：</label>
            <input type="text" class="form-control" name="name" placeholder="请输入案例名称" data-required-error="案例名称不可以为空" required>
            <div class="help-block with-errors"></div>
        </div>

        <div class="form-group">
            <label>案例简短描述：</label>
            <input type="text" class="form-control" name="cases_brief" placeholder="请输入案例简短描述" data-required-error="案例简短描述不可以为空" required>
            <div class="help-block with-errors"></div>
        </div>

        <div class="form-group">
            <label>案例类别：</label>
            <select name="category_name">
                <optgroup v-for="parentCategory in categoryList" v-bind:label="parentCategory.name">
                    <option v-for="subCategory in parentCategory.sub_cat">{{subCategory.name}}</option>
                </optgroup>
            </select>
            <div class="help-block with-errors"></div>
        </div>

        <textarea name="cases_desc">
        <p style="text-align: center;">
            <img title="TinyMCE Logo" src="//www.tinymce.com/images/glyph-tinymce@2x.png" alt="TinyMCE Logo" width="110"
                 height="97"/></p>
        <h1 style="text-align: center;">Welcome to the TinyMCE editor demo!</h1>
        <p>Please try out the features provided in this basic example.
            <br>Note that any
            <strong>MoxieManager</strong>file and image management functionality in this example is part of our commercial offering – the demo is to show the integration.
        </p>
        <h2>Got questions or need help?</h2>
        <ul>
            <li>Our<a href="https://www.tinymce.com/docs/">documentation</a>is a great resource for learning how to configure TinyMCE.</li>
            <li>Have a specific question? Visit the<a href="https://community.tinymce.com/forum/" target="_blank">Community Forum</a>.</li>
            <li>We also offer enterprise grade support as part of<a
                href="www.tinymce.com/pricing">TinyMCE Enterprise</a>.</li></ul>
        <h2>A simple table to play with</h2>
        <table style="text-align: center;">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Cost</th>
                    <th>Really?</th></tr>
            </thead>
            <tbody>
                <tr>
                    <td>TinyMCE</td>
                    <td>Free</td>
                    <td>YES!</td></tr>
                <tr>
                    <td>Plupload</td>
                    <td>Free</td>
                    <td>YES!</td></tr>
            </tbody>
        </table>
        <h2>Found a bug?</h2>
        <p>If you think you have found a bug please create an issue on the
            <a href="https://github.com/tinymce/tinymce/issues">GitHub repo</a>to report it to the developers.
        </p>
        <h2>Finally ...</h2>
        <p>Don't forget to check out our other product
            <a href="http://www.plupload.com" target="_blank">Plupload</a>, your ultimate upload solution featuring HTML5 upload support.</p>
        <p>Thanks for supporting TinyMCE! We hope it helps you and your users create great content.
            <br>All the best from the TinyMCE team.</p>
        </textarea>

        <div class="form-group">
            <label>案例封面图片：</label>
            <input type="file" v-on:change="uploadCoverPicture" id="coverPictureSelector">
            <label>上传进度：{{uploadProgress}}%</label>
        </div>

        <div class="form-group">
            <input type="hidden" name="cases_front_image" v-bind:value="coverPictureURL"/>
        </div>

        <button class="button expanded" v-on:click='postRichTextEditorData'>提交</button>
    </form>
</template>

<script>
    import $ from 'jquery';

    export default {
        data() {
            return {
                categoryList: [],
                coverPictureURL: '',
                uploadProgress: 0.0
            };
        },
        methods: {
            postRichTextEditorData: function () {
                window.tinymce.activeEditor.uploadImages(function(success) {
                    var postData = this.$root.getFormInput('richTextEditorForm');
                    this.$http.post('cases/', postData).then(function(res) {
                        console.log('---表单提交成功---');
                    }, (err) => {
                        console.log('---err.body---');
                        console.log(err.body);
                    });
                }.bind(this));
            },
            uploadCoverPicture (event) {
                this.uploadProgress = 0.0;
                this.coverPictureURL = '';
                let file = event.target.files[0];
                if (file) {
                    const formData = new FormData();
                    formData.append('file', file);
                    this.$http.post('uploadfile/case_cover_picture/', formData, {
                        progress: function(event) {
                            this.uploadProgress = parseFloat(event.loaded / event.total * 100);
                        }.bind(this)
                    }).then((res) => {
                        this.coverPictureURL = res.data['location'];
                        console.log('---this.coverPictureURL---');
                        console.log(this.coverPictureURL);
                    }, (err) => {
                        this.uploadProgress = 0.0;
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
                }
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                // 阻止表单的默认提交操作
                $('#richTextEditorForm').submit(function (e) {
                    e.preventDefault();
                });
                // 请求案例分类信息
                this.$http.get('categorys/')
                    .then((res) => {
                        this.categoryList = res.data;
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
                // 如果还没加载强大的富文本编辑器TinyMCE，则进行动态请求并加载
                if (!window.tinymce) {
                    $.getScript('https://cloud.tinymce.com/stable/tinymce.min.js?apiKey=w1jnifw6jyuhsi04yjizbcmplt1s0w5zks3u7xeaitd7samr')
                        .done(function() {
                            // 要等到下一次DOM更新完成（即window.tinymce已经生成）后才进行tinymce的初始化
                            this.$nextTick(function () {
                                // 初始化富文本编辑器TinyMCE
                                window.tinymce.init({
                                    selector: 'textarea',
                                    branding: false,
                                    language_url: this.$root.$data.requestHost + '/static/zh_CN.js',  // site absolute URL
                                    height: 500,
                                    menubar: false,
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
                                        this.$http.post('uploadfile/rich_text_picture/', formData).then((res) => {
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
                            });
                        }.bind(this))
                        .fail(function() {
                            console.log('TinyMCE加载失败。。。');
                        });
                }
            });
        }
    };
</script>

<style>
    body {
        padding: 5px
    }
</style>
