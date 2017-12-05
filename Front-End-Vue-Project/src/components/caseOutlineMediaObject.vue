<template>
    <div class="media row">
        <div class="col-sm-4 media-object-container" style="height:150px;margin-right:-10px">
            <router-link v-bind:to="caseDetailUrl" data-toggle="tooltip" data-original-title="查看详情">
                <img class="media-object img-responsive" v-bind:src="cases_front_image" alt="Generic placeholder image">
            </router-link>
        </div>
        <div class="col-sm-8" style="margin-left:-10px">
            <div class="row">
                <div class="col-sm-12">
                    <h4 class="media-heading">
                        <span class="label label-primary" v-text="category_name"></span>
                        <span v-text="name"></span>
                    </h4>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <ul class="list-inline">
                        <li><i class="glyphicon glyphicon-time"></i> {{add_time | makeTimeFriendly()}}</li>
                        <li><i class="glyphicon glyphicon-eye-open"></i> {{click_num}}</li>
                        <li><i class="glyphicon glyphicon-comment"></i> {{reply_num}}</li>
                        <li><i class="glyphicon glyphicon-star"></i> {{fav_num}}</li>
                    </ul>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-8">
                    <pre v-text="cases_brief"></pre>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import $ from 'jquery';
    export default {
        // 模板<template>默认替换挂载元素，如果 replace 选项为 false，模板将插入挂载元素内
        replace: true,
        props: {
            cases_front_image: {
                type: String,
                default: ''
            },
            name: {
                type: String,
                default: '暂无标题'
            },
            cases_brief: {
                type: String,
                default: '暂无简介'
            },
            category_name: {
                type: String,
                default: '未知类别'
            },
            add_time: {
                type: String,
                default: '未知日期'
            },
            click_num: {
                type: Number,
                default: 0
            },
            reply_num: {
                type: Number,
                default: 0
            },
            fav_num: {
                type: Number,
                default: 0
            },
            id: {
                type: Number,
                default: 0
            }
        },
        computed: {
            caseDetailUrl () {
                return '/viewCase/' + this.id;
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                $('[data-toggle=tooltip]').tooltip();
            });
        },
        methods: {
            jumpToCaseDetailPage: function () {
                this.$root.jumpToThisPage('/viewCase/' + this.id);
            }
        }
    };
</script>
