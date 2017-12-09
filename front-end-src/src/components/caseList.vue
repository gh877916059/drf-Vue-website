<template>
    <div class="row">
        <template v-if="caseOutlineList.length > 0">
            <div class="col-sm-12">
                <ul class="list-group">
                    <li v-for="(caseOutline, index) in caseOutlineList" class="list-group-item"><case-outline-media-object v-bind="caseOutline"></case-outline-media-object></li>
                </ul>
            </div>
            <div class="col-sm-8 col-sm-offset-4">
                <pagination-nav></pagination-nav>
            </div>
        </template>
        <template v-else>
            <div class="col-sm-12">
                <h1>暂无相关的案例</h1>
            </div>
        </template>
    </div>
</template>

<script>
    import caseOutlineMediaObject from './caseOutlineMediaObject.vue';
    import paginationNav from './paginationNav.vue';
    export default {
        data() {
            return {
                caseOutlineList: []
            };
        },
        components: {
            caseOutlineMediaObject,
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
