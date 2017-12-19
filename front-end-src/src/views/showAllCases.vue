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
<script>
    import topBar from '../components/topBar.vue';
    import caseList from '../components/caseList.vue';
    import Constants from '../constants';
    export default {
        components: {
            topBar,
            caseList
        },
        methods: {
            requestCaseList: function () {
                if (this.$route.query['top_category']) {
                    this.$store.commit('setFilterCondition', {top_category: this.$route.query['top_category']});
                }
                const page = this.$route.query['page'] || 1;
                const pageSize = this.$route.query['page_size'] || Constants.PAGE_SIZE;
                this.$store.commit('setCurrPageNum', page);
                this.$store.commit('setCurrPageSize', pageSize);
            }
        },
        mounted: function () {
            this.requestCaseList();
        },
        watch: {
            '$route'(to, from) {
                this.requestCaseList();
            }
        }
    };
</script>
<style lang="scss">

</style>
