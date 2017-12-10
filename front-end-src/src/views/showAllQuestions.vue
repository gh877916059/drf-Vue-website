<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=3>
                </top-bar>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <question-list></question-list>
            </div>
        </div>
    </div>
</template>
<script>
    import topBar from '../components/topBar.vue';
    import questionList from '../components/questionList.vue';
    import $ from 'jquery';
    export default {
        components: {
            topBar,
            questionList
        },
        mounted: function () {
            this.$nextTick(function () {
                if ($.isEmptyObject(this.$route.query)) {
                    this.$store.commit('setCaseFilterCondition', {page_size: 1, page: 1});
                } else {
                    this.$store.commit('setCaseFilterCondition', this.$route.query);
                }
            });
        }
    };
</script>
<style lang="scss">

</style>
