<template>
    <div>
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
                <input type="file" id="coverPictureImg" class="file" accept="image/*">
            </div>

            <div class="form-group">
                <input type="hidden" name="cases_front_image" v-bind:value="coverPictureURL"/>
            </div>

            <input type="submit" class="btn btn-primary btn-block" v-on:click='postRichTextEditorData' value="提交"></input>
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

<script>
    import $ from 'jquery';
    import pictureCropper from './pictureCropper.vue';
    export default {
        components: {
            pictureCropper
        },
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
                categoryNameToId: {},
                imageData: '',
                coverPictureType: '',
                coverPictureName: ''
            };
        },
        computed: {
            coverPictureFileName () {
                return this.$root.convertURLtoRawFileName(this.coverPictureURL);
            },
            completePictureFileName () {
                return this.$root.convertURLtoCompleteFileName(this.coverPictureURL);
            },
            bootstrapInputConfig () {
                var config = {
                    language: 'zh',
                    ajaxSettings: {headers: {Authorization: this.$axios.defaults.headers.common['Authorization']}},
                    deleteExtraData: {case_id: this.caseId},
                    msgPlaceholder: '案例封面图片',
                    initialPreviewAsData: false, // allows you to set a raw markup
                    initialPreviewFileType: 'image', // image is the default and can be overridden in config below
                    previewFileType: 'image',
                    browseClass: 'btn btn-success',
                    browseLabel: '选择图片',
                    browseIcon: '<i class=\"glyphicon glyphicon-picture\"></i> ',
                    removeClass: 'btn btn-danger',
                    removeLabel: '删除',
                    removeIcon: '<i class=\"glyphicon glyphicon-trash\"></i> ',
                    uploadClass: 'btn btn-info',
                    uploadLabel: '上传',
                    uploadIcon: '<i class=\"glyphicon glyphicon-upload\"></i> '
                };
                if (this.coverPictureFileName.lastIndexOf('.') > 0) {
                    config['initialPreview'] = [
                        '<img src="' + this.coverPictureURL + '" class="kv-preview-data file-preview-image">'
                    ];
                    config['initialPreviewConfig'] = [
                        {type: 'image', caption: this.coverPictureFileName, url: 'http://127.0.0.1:8000/deletefile/', key: this.completePictureFileName, downloadUrl: false}
                    ];
                    config['initialCaption'] = this.coverPictureFileName;
                }
                return config;
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
                        this.$axios.put('cases/' + this.caseId + '/', postData).then(function (res) {
                            console.log('---res.data---');
                            console.log(res.data);
                            this.$root.jumpToThisPage('/viewCase/' + this.caseId);
                        }, (err) => {
                            console.log('---err.body---');
                            console.log(err.body);
                        });
                    } else {
                        this.$axios.post('cases/', postData).then(function (res) {
                            console.log('---res.data---');
                            console.log(res.data);
                            this.$root.jumpToThisPage('/viewCase/' + res.data['id']);
                        }, (err) => {
                            console.log('---err.body---');
                            console.log(err.body);
                        });
                    }
                }.bind(this));
            },
            // 读取封面图片，准备进行裁剪并上传
            readPictureData (event) {
                let file = event.target.files[0];
                var imageInfoDict = {};
                imageInfoDict['type'] = file.type;
                imageInfoDict['name'] = file.name;
                var reader = new FileReader();
                reader.onload = function (evt) {
                    imageInfoDict['data'] = evt.target.result;
                    // 强制触发子组件initCropper()函数
                    this.$refs.pictureCropperModal.initCropper(imageInfoDict);
                    this.openPictureCropperModal();
                }.bind(this);
                reader.readAsDataURL(file);
            },
            // 请求案例分类信息
            getCategoryInfo () {
                this.$axios.get('categorys/')
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
                        });
                    }.bind(this))
                    .fail(function() {
                        console.log('TinyMCE加载失败。。。');
                    });
            },
            getCaseInfoById () {
                this.$axios.get('cases/' + this.caseId + '/')
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
            },
            closePictureCropperModal () {
                $('#pictureCropperModal').modal('hide');
            },
            openPictureCropperModal () {
                // backdrop 为 static 时，点击模态对话框的外部区域不会将其关闭
                // keyboard 为 false 时，按下 Esc 键不会关闭 Modal
                $('#pictureCropperModal').modal({backdrop: 'static', keyboard: false});
            },
            setCoverPictureURL (coverPictureURL) {
                this.coverPictureURL = coverPictureURL;
            },
            deleteCoverPicture: function (event, key, data) {
                var aborted = !window.confirm('你确定要删除该封面图片吗?');
                if (aborted) {
                    window.alert('删除操作被中止!');
                } else {
                    const postData = {
                        file_name: key,
                        case_id: data['case_id']
                    };
                    this.$axios.post('deletefile/case_cover_picture/', postData).then((res) => {
                        this.coverPictureURL = this.$root.$data.requestHost + '/static/image/fail.jpg';
                        this.refreshBootstrapInput();
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
                }
                // 阻止默认的删除操作，使用vue-resource进行删除请求
                return true;
            },
            // 利用bootstrap-input插件初始化封面图片文件选择器
            initBootstrapInput: function () {
                const $picture = $('#coverPictureImg');
                $picture.fileinput(this.bootstrapInputConfig);
                $picture.on('filebeforedelete',
                    function(event, key, data) {
                        this.deleteCoverPicture(event, key, data);
                    }.bind(this)
                );
                $picture.on('change', function(event, numFiles, label) {
                    this.readPictureData(event);
                }.bind(this));
            },
            refreshBootstrapInput: function () {
                $('#coverPictureImg').fileinput('destroy');
                this.initBootstrapInput();
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
                this.initBootstrapInput();
                $('#pictureCropperModal').on('hidden.bs.modal', function (e) {
                    // 强制触发子组件destroyCropper()函数
                    this.$refs.pictureCropperModal.destroyCropper();
                    this.refreshBootstrapInput();
                }.bind(this));
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
