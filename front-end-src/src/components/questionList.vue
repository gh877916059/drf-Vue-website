<template>
    <div class="row">
        <template v-if="questionOutlineList.length > 0">
            <div class="col-sm-12">
                <ul class="list-group">
                    <li v-for="(caseOutline, index) in questionOutlineList" class="list-group-item"><question-outline-media-object v-bind="caseOutline"></question-outline-media-object></li>
                </ul>
            </div>
            <div class="col-sm-8 col-sm-offset-4">
                <pagination-nav></pagination-nav>
            </div>
        </template>
        <template v-else>
            <div class="col-sm-12">
                <h1>暂无相关的提问</h1>
            </div>
        </template>
    </div>
</template>

<script>
    import questionOutlineMediaObject from './questionOutlineMediaObject.vue';
    import paginationNav from './paginationNav.vue';
    export default {
        data() {
            return {
                questionOutlineList: []
            };
        },
        components: {
            questionOutlineMediaObject,
            paginationNav
        },
        mounted: function () {
            this.$store.commit('setCaseListComponent', this);
        },
        destroyed: function () {
            this.$store.commit('setCaseListComponent', null);
        }
    };
</script>
