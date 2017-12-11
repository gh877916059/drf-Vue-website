<template>
    <div>
        <router-link class="button expanded" v-bind:to="editQuestionURL" data-toggle="tooltip" data-original-title="编辑">编辑</router-link>
        <button class="button expanded" v-on:click="deleteQuestion">删除</button>
        <div id="richTextViewerDiv" v-html="question_desc">
        </div>
    </div>
</template>

<script>
    import $ from 'jquery';
    import Utils from '../utils';
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
                click_num: 0,
                fav_num: 0,
                reply_num: 0,
                question_desc: '',
                add_time: '',
                id: 0
            };
        },
        methods: {
            // 请求该问题的详细信息
            getQuestionDetail: function () {
                if (this.questionId.length <= 0) {
                    console.log('---请传入问题ID作为query---');
                } else {
                    this.$axios.get('questions/' + this.questionId + '/')
                        .then((res) => {
                            this.name = res.data['name'];
                            this.click_num = res.data['click_num'];
                            this.fav_num = res.data['fav_num'];
                            this.reply_num = res.data['reply_num'];
                            this.question_desc = res.data['question_desc'];
                            this.add_time = res.data['add_time'];
                            this.id = res.data['id'];
                        }, (err) => {
                            var errorReasonDict = err.body;
                            console.log('---errorReasonDict---');
                            console.log(errorReasonDict);
                        });
                }
            },
            deleteQuestion: function () {
                if (this.questionId.length <= 0) {
                    console.log('---请传入问题ID作为query---');
                } else {
                    this.$axios.delete('questions/' + this.questionId + '/')
                        .then((res) => {
                            console.log('---删除问题成功---');
                            this.$store.commit('increaseForcedRequestCounter');
                            Utils.jumpToThisPage('/showAllQuestions');
                        }, (err) => {
                            var errorReasonDict = err.body;
                            console.log('---errorReasonDict---');
                            console.log(errorReasonDict);
                        });
                }
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                this.getQuestionDetail();
                $('[data-toggle=tooltip]').tooltip();
            });
        },
        computed: {
            editQuestionURL () {
                return '/editQuestion?id=' + this.id;
            }
        }
    };
</script>
