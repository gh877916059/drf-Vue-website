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
                        <case-outline-media-object v-bind="caseOutline"></case-outline-media-object>
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

<script>
    import caseOutlineMediaObject from './caseOutlineMediaObject.vue';
    import paginationNav from './paginationNav.vue';
    import Constants from '../constants';
    export default {
        data() {
            return {
                caseOutlineList: [],
                requestUrl: 'cases/',
                sumPageNum: 1,
                nextPageUrl: '',
                previousPageUrl: ''
            };
        },
        components: {
            caseOutlineMediaObject,
            paginationNav
        },
        mounted: function () {
            this.$store.commit('setListComponent', this);
        },
        destroyed: function () {
            this.$store.commit('setListComponent', null);
        },
        props: {
            isShowPagination: {
                type: Boolean,
                default: true
            }
        },
        methods: {
            // 请求该案例的详细信息
            setOutlineList: function (caseOutlineList) {
                this.caseOutlineList = caseOutlineList;
                for (var index in this.caseOutlineList) {
                    this.caseOutlineList[index]['category_name'] = this.caseOutlineList[index]['category']['name'];
                    delete this.caseOutlineList[index]['category'];
                    delete this.caseOutlineList[index]['cases_desc'];
                    this.caseOutlineList[index]['cases_front_image'] = Constants.REQUEST_HOST + this.caseOutlineList[index]['cases_front_image'];
                }
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
