<template>
    <div class="media">
        <div class="media-left media-middle">
            <router-link v-bind:to="questionDetailUrl">
                <img v-bind:src="user_avatar" class="media-object" style="width:80px">
            </router-link>
        </div>
        <div class="media-body">
            <h4 class="media-heading">{{name}} <small><i>Posted on {{add_time | makeTimeFriendly()}}</i></small></h4>
            <p v-text="question_brief"></p>
        </div>
    </div>
</template>

<script>
    import Constants from '../constants';
    export default {
        // 模板<template>默认替换挂载元素，如果 replace 选项为 false，模板将插入挂载元素内
        replace: true,
        props: {
            user_avatar: {
                type: String,
                default: Constants.REQUEST_HOST + '/static/image/fail.jpg'
            },
            question_brief: {
                type: String,
                default: '暂无简介'
            },
            name: {
                type: String,
                default: '暂无标题'
            },
            id: {
                type: Number,
                default: 0
            },
            add_time: {
                type: String,
                default: '未知日期'
            }
        },
        computed: {
            questionDetailUrl () {
                return '/viewQuestion/' + this.id;
            }
        }
    };
</script>
