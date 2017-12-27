<template>
    <div>
        <router-link class="button expanded" v-bind:to="editCaseURL" data-toggle="tooltip" data-original-title="编辑">编辑</router-link>
        <button class="button expanded" v-on:click="deleteCase">删除</button>
        <div id="richTextViewerDiv" v-html="cases_desc">
        </div>
    </div>
</template>

<script lang="ts">
    import $ from 'jquery';
    import axios from 'axios';
    import {jumpToThisPage} from '../router';
    import {Component, Vue, Prop} from 'vue-property-decorator';
    import {CaseData} from '../commonType';
    import {Mutation} from 'vuex-class';
    @Component
    export default class caseViewer extends Vue{
        caseOutline: CaseData;
        @Prop({type: String, default: ''})
        caseId: string;
        get editCaseURL(): string{
            return '/editCase?id=' + this.caseId;
        }
        @Mutation('increaseForcedRequestCounter') mutationIncreaseForcedRequestCounter;
        // 请求该案例的详细信息
        getCaseDetail(): void{
            if (this.caseId.length <= 0) {
                console.log('---请传入案例ID作为query---');
            } else {
                axios.get('cases/' + this.caseId + '/')
                    .then((res) => {
                        this.caseOutline = new CaseData(res.data);
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            }
        }
        deleteCase(): void{
            if (this.caseId.length <= 0) {
                console.log('---请传入案例ID作为query---');
            } else {
                axios.delete('cases/' + this.caseId + '/')
                    .then((res) => {
                        console.log('---删除案例成功---');
                        this.mutationIncreaseForcedRequestCounter();
                        jumpToThisPage('/showAllCases');
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            }
        }
        mounted(): void{
            this.$nextTick(function () {
                this.getCaseDetail();
                $('[data-toggle=tooltip]').tooltip();
            });
        }
    };
</script>
