<template>
    <div class="row">
        <template v-if="questionOutlineList.length > 0">
            <div class="col-sm-12">
                <ul class="list-group">
                    <li v-for="(questionOutline, index) in questionOutlineList" class="list-group-item"><question-outline-media-object v-bind:questionOutline="questionOutline"></question-outline-media-object></li>
                </ul>
            </div>
            <div class="col-sm-8 col-sm-offset-4">
                <pagination-nav v-bind:sumPageNum="sumPageNum" v-bind:nextPageUrl="nextPageUrl" v-bind:previousPageUrl="previousPageUrl"></pagination-nav>
            </div>
        </template>
        <template v-else>
            <div class="col-sm-12">
                <h1>暂无相关的提问</h1>
            </div>
        </template>
    </div>
</template>

<script lang="ts">
    import questionOutlineMediaObject from './questionOutlineMediaObject.vue';
    import paginationNav from './paginationNav.vue';
    import {Component, Vue} from 'vue-property-decorator';
    import {Mutation} from 'vuex-class';
    import {Dict, QuestionData} from '../commonType';
    @Component({
        components: {
            questionOutlineMediaObject,
            paginationNav
        }
    })
    export default class questionList extends Vue{
        questionOutlineList: QuestionData[] = [];
        requestUrl: string = 'questions/';
        sumPageNum: number = 1;
        nextPageUrl: string = '';
        previousPageUrl: string = '';
        @Mutation('setListComponent') mutationSetListComponent;
        mounted(): void{
            this.mutationSetListComponent(this);
        }
        destroyed(): void{
            this.mutationSetListComponent(null);
        }
        // 请求该案例的详细信息
        setOutlineList(resDataList: Dict[]): void{
            this.questionOutlineList = [];
            for (let resDict of resDataList) {
                let caseOutline = new QuestionData(resDict);
                this.questionOutlineList.push(caseOutline);
            }
        }
    };
</script>
