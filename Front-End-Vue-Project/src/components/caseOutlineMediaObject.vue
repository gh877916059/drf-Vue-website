<template>
    <router-link v-bind:to="jumpURL">
        <div class="media row">
            <div class="col-sm-4">
                <a class="media-left thumbnail" href="#">
                    <img class="media-object" v-bind:src="cases_front_image" alt="Generic placeholder image">
                </a>
            </div>
            <h4 class="media-heading">
                <span v-text="category_name"></span>
                <span v-text="name"></span>
            </h4>
            <div>
                <span v-text="add_time"></span>
                <span v-text="click_num"></span>
                <span v-text="fav_num"></span>
                <span v-text="reply_num"></span>
            </div>
            <div v-text="cases_brief"></div>
        </div>
    </router-link>
</template>

<script>
    export default {
        // 模板<template>默认替换挂载元素，如果 replace 选项为 false，模板将插入挂载元素内
        replace: true,
        props: {
            cases_front_image: {
                type: String,
                default: '/static/image/fail.jpg'
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
        }
    };
</script>
