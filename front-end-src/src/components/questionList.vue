<template>
    <div id="questionMainContainer">
        <nav id="questionTabNav">
            <ul id="questionTab" class="box-select-tab clearfix">
                <li id="btnMyTag" class="feed-update-count-parent">
                    <p title="我的提问">
                        <span>我的提问</span>
                        <em class="list-notification feed-update-count">0</em>
                    </p>
                </li>
                <li id="btnNew" class="feed-update-count-parent">
                    <p title="最新">
                        <span>最新</span>
                        <em class="list-notification feedUpdateCount">0</em>
                    </p>
                </li>
                <li id="btnHot" class="feed-update-count-parent">
                    <p title="热度">
                        <span>热度</span>
                        <em class="list-notification feed-update-count">0</em>
                    </p>
                </li>
                <li id="btnUnanswered" class="feed-update-count-parent">
                    <p title="未回答">
                        <span>未回答</span>
                        <em class="list-notification feed-update-count">0</em>
                    </p>
                </li>
                <li id="btnUnsolved" class="feed-update-count-parent">
                    <p title="未解决">
                        <span>未解决</span>
                        <em class="list-notification feed-update-count">0</em>
                    </p>
                </li>
                <li id="btnAttention" class="feed-update-count-parent">
                    <p title="我的关注">
                        <span>我的关注</span>
                        <em class="list-notification feed-update-count">0</em>
                    </p>
                </li>
                <li id="btnResolved" class="feed-update-count-parent">
                    <p title="已解决">
                        <span>已解决</span>
                        <em class="list-notification feed-update-count">0</em>
                    </p>
                </li>
            </ul>
        </nav>
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
<style lang="scss">
    .box-select-tab {
        position: relative;
        clear: both;
        padding: 0;
        margin: 8px 0 0 0;
        border-bottom: 1px solid #ccc;
        height: 32px;
    }
    .clearfix {
        min-height: 1px;
        clear: both;
        display: block;
    }
    .box-select-tab li {
        background: #F5F7F9;
        color: #828E96;
        position: relative;
        width: 95px;
        border-radius: 3px 3px 0 0;
        float: left;
        margin: 0 0 -1px 7px;
        text-align: center;
        cursor: pointer;
        -webkit-transition: .1s ease;
        -moz-transition: .1s ease;
        -ms-transition: .1s ease;
        -o-transition: .1s ease;
        transition: .1s ease;
        box-sizing: border-box;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        line-height: 22px;
    }
    .box-select-tab li span {
        display: block;
        width: 100%;
        margin: 0 auto;
        padding: 5px 0;
    }
    .list-notification {
        color: #fff;
        font-size: 10px;
        text-align: center;
        font-weight: bold;
        position: absolute;
        top: -10px;
        right: -4px;
        padding: 0 4px;
        line-height: 16px;
        display: none;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
        background-color: #E9606D;
        border: 1px solid #D84E5B;
        -webkit-box-shadow: 0px 2px 5px 0px rgba(0,0,0,0.16), 0px 2px 10px 0px rgba(0,0,0,0.12);
        -moz-box-shadow: 0px 2px 5px 0px rgba(0,0,0,0.16),0px 2px 10px 0px rgba(0,0,0,0.12);
        box-shadow: 0px 2px 5px 0px rgba(0,0,0,0.16), 0px 2px 10px 0px rgba(0,0,0,0.12);
    }
</style>
