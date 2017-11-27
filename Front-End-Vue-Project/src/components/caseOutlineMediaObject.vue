<template>
    <router-link v-bind:to="jumpURL">
        <div class="media row">
            <div class="col-sm-4 media-object-container" style="height:150px">
                <img class="media-object" v-bind:src="cases_front_image" alt="Generic placeholder image">
            </div>
            <h4 class="media-heading">
                <span class="badge" v-text="category_name"></span>
                <span v-text="name"></span>
            </h4>
            <p>
                <span><i class="glyphicon glyphicon-time"></i> {{add_time | makeTimeFriendly()}}</span>
                <span><i class="glyphicon glyphicon-eye-open"></i> {{click_num}}</span>
                <span><i class="glyphicon glyphicon-comment"></i> {{reply_num}}</span>
                <span><i class="glyphicon glyphicon-star"></i> {{fav_num}}</span>
            </p>
            <div v-text="cases_brief"></div>
        </div>
    </router-link>
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
            jumpURL () {
                return '/viewCase/' + this.id;
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                $('.media-object-container').autoIMG();
            });
        }
    };
</script>
