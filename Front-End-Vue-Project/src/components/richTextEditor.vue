<template>
    <form id="richTextEditorForm">

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

        <textarea id="MyTextArea">请在这里编辑案例介绍</textarea>

        <div class="form-group">
            <label v-if="coverPictureFileName.lastIndexOf('.') > 0" class="cover-picture-tip">案例封面图片名（已上传）：{{coverPictureFileName}}</label>
            <label v-else class="cover-picture-tip">未上传案例封面图片</label>
            <input type="file" v-on:change="uploadCoverPicture" id="coverPictureSelector">
            <label>上传进度：{{uploadProgress}}%</label>
        </div>

        <div class="form-group">
            <input type="hidden" name="cases_front_image" v-bind:value="coverPictureURL"/>
        </div>

        <input type="submit" class="button expanded" v-on:click='postRichTextEditorData' value="提交"></input>
    </form>
</template>

<script>
    import $ from 'jquery';
    export default {
        props: {
            caseId: {
                type: String,
                default: ''
            }
        },
        data() {
            return {
                name: '',
                cases_brief: '',
                category_name: '',
                categoryList: [],
                coverPictureURL: this.$root.$data.requestHost + '/static/image/fail.jpg',
                uploadProgress: 0.0,
                categoryNameToId: {}
            };
        },
        computed: {
            coverPictureFileName () {
                return this.$root.convertURLtoRawFileName(this.coverPictureURL);
            }
        },
        methods: {
            // 提交案例相关信息和富文本框内容
            postRichTextEditorData: function () {
                window.tinymce.activeEditor.uploadImages(function(success) {
                    var postData = this.$root.getFormInput('richTextEditorForm');
                    postData = this.$root.getFormInput('richTextEditorForm');
                    var casesDesc = window.tinymce.activeEditor.getContent();
                    postData['cases_desc'] = casesDesc;
                    postData['category_id'] = this.categoryNameToId[postData['category_name']];
                    delete postData['category_name'];
                    if (this.caseId.length > 0) {
                        this.$http.put('cases/' + this.caseId + '/', postData).then(function (res) {
                            console.log('---res.data---');
                            console.log(res.data);
                            this.$root.jumpToThisPage('viewCase/' + this.caseId);
                        }, (err) => {
                            console.log('---err.body---');
                            console.log(err.body);
                        });
                    } else {
                        this.$http.post('cases/', postData).then(function (res) {
                            console.log('---res.data---');
                            console.log(res.data);
                            this.$root.jumpToThisPage('viewCase/' + res.data['id']);
                        }, (err) => {
                            console.log('---err.body---');
                            console.log(err.body);
                        });
                    }
                }.bind(this));
            },
            // 异步上传封面图片
            uploadCoverPicture (event) {
                console.log('---调用了uploadCoverPicture()函数---');
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
            },
            // 请求案例分类信息
            getCategoryInfo () {
                this.$http.get('categorys/')
                    .then((res) => {
                        this.categoryList = res.data;
                        for (var index1 in this.categoryList) {
                            var subCategoryList = this.categoryList[index1].sub_cat;
                            for (var index2 in subCategoryList) {
                                var subCategory = subCategoryList[index2];
                                this.categoryNameToId[subCategory.name] = subCategory.id;
                            }
                        }
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            },
            // 加载强大的富文本编辑器TinyMCE
            initTinyMCE () {
                $.getScript('https://cloud.tinymce.com/stable/tinymce.min.js?apiKey=w1jnifw6jyuhsi04yjizbcmplt1s0w5zks3u7xeaitd7samr')
                    .done(function() {
                        // 要等到下一次DOM更新完成（即window.tinymce已经生成）后才进行tinymce的初始化
                        this.$nextTick(function () {
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
            },
            getCaseInfoById () {
                this.$http.get('cases/' + this.caseId + '/')
                    .then((res) => {
                        this.category_name = res.data['category']['name'];
                        this.name = res.data['name'];
                        this.cases_brief = res.data['cases_brief'];
                        this.coverPictureURL = res.data['cases_front_image'];
                        var casesDesc = res.data['cases_desc'];
                        $('#richTextEditorDiv').html(casesDesc);
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
                this.getCategoryInfo();
                // 动态请求并加载TinyMCE
                if (!window.tinymce) {
                    this.initTinyMCE();
                }
                // 如果caseId不为空，则为修改已经存在的案例，而不是新建
                if (this.caseId.length > 0) {
                    this.getCaseInfoById();
                }
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
