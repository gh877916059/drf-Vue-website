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
<script>
    import topBar from '../components/topBar.vue';
    import questionList from '../components/questionList.vue';
    import Constants from '../constants';
    export default {
        components: {
            topBar,
            questionList
        },
        mounted: function () {
            const page = this.$route.query['page'] || 1;
            const pageSize = this.$route.query['page_size'] || Constants.PAGE_SIZE;
            this.$store.commit('setCurrPageNum', page);
            this.$store.commit('setCurrPageSize', pageSize);
        }
    };
</script>
<style lang="scss">

</style>
