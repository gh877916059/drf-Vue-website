<template>
    <div class="row">
        <template v-if="caseOutlineList.length > 0">
            <section>
                <header v-if='!isShowPagination' class="panel ptb-15 prl-20 pos-r mb-30">
                    <h3 class="font-18">案例展示</h3>
                    <router-link to="/showAllCases" class="hollow btn pos-a right-10 pos-tb-center">查看更多</router-link>
                </header>

                <div class="row row-masnory row-tb-20">
                    <div v-bind:class="[isShowPagination?'col-sm-6 col-lg-4':'col-xs-12 col-sm-6', 'mb-20']"v-for="caseOutline in caseOutlineList" :key="caseOutline.id">
                        <case-outline-media-object v-bind:caseOutline="caseOutline"></case-outline-media-object>
                    </div>
                </div>
            </section>
            <div v-if='isShowPagination' class="col-sm-8 col-sm-offset-4">
                <pagination-nav v-bind:sumPageNum="sumPageNum" v-bind:nextPageUrl="nextPageUrl" v-bind:previousPageUrl="previousPageUrl"></pagination-nav>
            </div>
        </template>
        <template v-else>
            <div class="col-sm-12">
                <h1>暂无相关的案例</h1>
            </div>
        </template>
    </div>
</template>

<script lang="ts">
    import caseOutlineMediaObject from './caseOutlineMediaObject.vue';
    import paginationNav from './paginationNav.vue';
    import {Component, Vue, Prop} from 'vue-property-decorator';
    import {CaseData, Dict} from '../commonType';
    import {Mutation} from 'vuex-class';
    @Component({
        components: {
            caseOutlineMediaObject,
            paginationNav
        }
    })
    export default class caseList extends Vue{
        caseOutlineList: CaseData[] = [];
        requestUrl: string = 'cases/';
        sumPageNum: number = 1;
        nextPageUrl: string = '';
        previousPageUrl: string = '';
        @Prop({type: Boolean, default: true})
        isShowPagination: boolean;
        @Mutation('setListComponent') mutationSetListComponent;
        mounted(): void{
            this.mutationSetListComponent(this);
        }
        destroyed(): void{
            this.mutationSetListComponent(null);
        }
        // 请求该案例的详细信息
        setOutlineList(resDictList: Dict[]): void{
            this.caseOutlineList = [];
            for (let resDict of resDictList) {
                let caseOutline = new CaseData(resDict);
                this.caseOutlineList.push(caseOutline);
            }
        }
    };
</script>
<style lang="scss">
    @import '../assets/scss/base';
    @import '../assets/scss/common_style';
    @import '../assets/scss/media_object_base_style';
    .hollow {
        background-color: transparent;
        border-color: #2ed87b;
        color: #2ed87b;
    }
    .hollow:hover {
        background-color: #2ed87b;
        color: #ffffff;
    }
</style>
