<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=3>
                </top-bar>
            </div>
        </div>
        <main id="mainContent" class="main-content">
            <div class="page-container ptb-10">
                <div class="container">
                    <question-list></question-list>
                </div>
            </div>
        </main>

    </div>
</template>
<script lang="ts">
    import topBar from '../components/topBar.vue';
    import questionList from '../components/questionList.vue';
    import Constants from '../constants';
    import {Component, Vue, Watch} from 'vue-property-decorator';
    import {Mutation} from 'vuex-class';
    @Component({
        components: {
            topBar,
            questionList
        }
    })
    export default class showAllQuestionsView extends Vue{
        @Mutation('setCurrPageNum') mutationSetCurrPageNum;
        @Mutation('setCurrPageSize') mutationSetCurrPageSize;
        mounted() {
            const page = this.$route.query['page'] || 1;
            const pageSize = this.$route.query['page_size'] || Constants.PAGE_SIZE;
            this.mutationSetCurrPageNum(page);
            this.mutationSetCurrPageSize(pageSize);
        }
    };
</script>
<style lang="scss">

</style>
