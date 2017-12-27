<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=1>
                </top-bar>
            </div>
        </div>
        <main id="mainContent" class="main-content">
            <div class="page-container ptb-10">
                <div class="container">
                    <case-list></case-list>
                </div>
            </div>
        </main>
    </div>
</template>
<script lang="ts">
    import topBar from '../components/topBar.vue';
    import caseList from '../components/caseList.vue';
    import Constants from '../constants';
    import {Component, Vue, Watch} from 'vue-property-decorator';
    import {Mutation} from 'vuex-class';
    @Component({
        components: {
            topBar,
            caseList
        }
    })
    export default class showAllCasesView extends Vue{
        @Mutation('setFilterCondition') mutationSetFilterCondition;
        @Mutation('setCurrPageNum') mutationSetCurrPageNum;
        @Mutation('setCurrPageSize') mutationSetCurrPageSize;
        requestCaseList(): void{
            if (this.$route.query['top_category']) {
                this.mutationSetFilterCondition({top_category: this.$route.query['top_category']});
            }
            const page = this.$route.query['page'] || 1;
            const pageSize = this.$route.query['page_size'] || Constants.PAGE_SIZE;
            this.mutationSetCurrPageNum(page);
            this.mutationSetCurrPageSize(pageSize);
        }
        mounted(): void{
            this.requestCaseList();
        }
        @Watch('$route')
        onQueryArgsChanged() {
            this.requestCaseList();
        }
    };
</script>
<style lang="scss">

</style>
