<template>
    <div>
        <router-link class="button expanded" v-bind:to="editQuestionURL" data-toggle="tooltip" data-original-title="编辑">编辑</router-link>
        <button class="button expanded" v-on:click="deleteQuestion">删除</button>
        <div id="richTextViewerDiv" v-html="questionOutline.question_desc">
        </div>
    </div>
</template>

<script lang="ts">
    import $ from 'jquery';
    import axios from 'axios';
    import {jumpToThisPage} from '../router';
    import {Component, Vue, Prop} from 'vue-property-decorator';
    import {QuestionData, Dict} from '../commonType';
    import {Mutation} from 'vuex-class';
    @Component
    export default class questionViewer extends Vue{
        questionOutline: QuestionData;
        @Prop({type: String, default: ''})
        questionId: string;
        get editQuestionURL(): string{
            return '/editQuestion?id=' + this.questionOutline.id;
        }
        @Mutation('increaseForcedRequestCounter') mutationIncreaseForcedRequestCounter;
        // 请求该问题的详细信息
        getQuestionDetail(): void{
            if (this.questionId.length <= 0) {
                console.log('---请传入问题ID作为query---');
            } else {
                axios.get('questions/' + this.questionId + '/')
                    .then((res) => {
                        this.questionOutline = new QuestionData(res.data);
                    }, (err) => {
                        let errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            }
        }
        deleteQuestion(): void{
            if (this.questionId.length <= 0) {
                console.log('---请传入问题ID作为query---');
            } else {
                axios.delete('questions/' + this.questionId + '/')
                    .then((res) => {
                        console.log('---删除问题成功---');
                        this.mutationIncreaseForcedRequestCounter();
                        jumpToThisPage('/showAllQuestions');
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            }
        }
        mounted(): void{
            this.$nextTick(function () {
                this.getQuestionDetail();
                $('[data-toggle=tooltip]').tooltip();
            });
        }
    };
</script>
