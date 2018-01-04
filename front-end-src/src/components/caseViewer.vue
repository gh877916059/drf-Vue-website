<template>
    <div>
        <router-link class="button expanded" v-bind:to="editCaseURL" data-toggle="tooltip" data-original-title="编辑">编辑</router-link>
        <button class="button expanded" v-on:click="deleteCase">删除</button>
        <div id="richTextViewerDiv" v-html="casesDesc">
        </div>
    </div>
</template>

<script lang="ts">
    import $ from 'jquery';
    import axios from 'axios';
    import {jumpToThisPage} from '../router';
    import {Component, Vue, Prop} from 'vue-property-decorator';
    import Utils from '../utils';
    import {Mutation} from 'vuex-class';
    @Component
    export default class caseViewer extends Vue{
        casesDesc: string = '案例详情';
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
                        let casesDesc = res.data['cases_desc'];
                        this.casesDesc = Utils.completeAllHostInImgLabel(casesDesc);
                    }, (err) => {
                        let errorReasonDict = err.body;
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
                        let errorReasonDict = err.body;
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
