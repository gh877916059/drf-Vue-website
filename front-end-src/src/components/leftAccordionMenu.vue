<template>
    <div class="panel-group" id="leftAccordionMenu" role="tablist" aria-multiselectable="true">
        <div v-for="(parentCategory, index) in categoryList" class="panel panel-default">
            <div class="panel-heading" role="tab">
                <h4 class="panel-title">
                    <a v-on:click="clickPanelTitle(index)" role="button" data-toggle="collapse" data-parent="#leftAccordionMenu" v-bind:href="'#collapse'+index" v-bind:class="[index===currUnfoldPanelIndex?'':'collapsed']" v-bind:aria-expanded="index===currUnfoldPanelIndex?'true':'false'" v-bind:aria-controls="'collapse'+index">
                        {{parentCategory.name}}
                    </a>
                </h4>
            </div>
            <div v-bind:id="'collapse'+index" v-bind:class="[index===currUnfoldPanelIndex?'in':'', 'panel-collapse','collapse']" role="tabpanel">
                <div class="list-group">
                    <a style="cursor: pointer" v-for="subCategory in parentCategory.sub_cat" v-on:click="selectOneCategory(subCategory.id)" class="list-group-item">{{subCategory.name}}</a>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import $ from 'jquery';
    import Constants from '../constants';
    import NetworkCommunication from '../vuex/networkCommunication';
    export default {
        data() {
            return {
                currUnfoldPanelIndex: 1
            };
        },
        computed: {
            categoryList () {
                return this.$store.state.categoryList;
            }
        },
        methods: {
            selectOneCategory: function (categoryId) {
                this.$store.commit('setFilterCondition', {top_category: categoryId});
            },
            clickPanelTitle: function (panelIndex) {
                if (this.currUnfoldPanelIndex !== panelIndex) {
                    this.currUnfoldPanelIndex = panelIndex;
                    var categoryId = this.categoryList[panelIndex].id;
                    this.$store.commit('setFilterCondition', {top_category: categoryId});
                }
            },
            initCaseListRequestParameters: function (categoryList) {
                this.$store.commit('setFilterCondition', {top_category: categoryList[this.currUnfoldPanelIndex].id});
                const page = this.$route.query['page'] || 1;
                const pageSize = this.$route.query['page_size'] || Constants.PAGE_SIZE;
                this.$store.commit('setCurrPageNum', page);
                this.$store.commit('setCurrPageSize', pageSize);
            }
        },
        mounted: function () {
            NetworkCommunication.requestCategoryListWithCache(this.initCaseListRequestParameters);
            this.$nextTick(function () {
                $('#leftAccordionMenu').on('hide.bs.collapse', function () {
                    var currUnfoldPanelIndex = parseInt($('#leftAccordionMenu div.panel-collapse.in').attr('id').substr(-1));
                    // 如果要隐藏的是当前正在显示的列表框，则不仅要阻止事件往上冒泡，而且要阻止事件本身
                    if (this.currUnfoldPanelIndex === currUnfoldPanelIndex) {
                        return false;
                    }
                    return true;
                }.bind(this));
            });
        },
        destroyed: function () {
            this.$store.commit('resetFilterCondition');
        }
    };
</script>
