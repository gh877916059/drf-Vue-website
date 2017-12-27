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

<script lang="ts">
    import $ from 'jquery';
    import Constants from '../constants';
    import NetworkCommunication from '../vuex/networkCommunication';
    import {Component, Vue} from 'vue-property-decorator';
    import {CaseCategory} from '../commonType';
    import {State, Mutation} from 'vuex-class';
    @Component
    export default class leftAccordionMenu extends Vue{
        currUnfoldPanelIndex: number = 1;
        @State('categoryList') categoryList;
        @Mutation('setFilterCondition') mutationSetFilterCondition;
        @Mutation('setCurrPageNum') mutationSetCurrPageNum;
        @Mutation('setCurrPageSize') mutationSetCurrPageSize;
        @Mutation('resetFilterCondition') mutationResetFilterCondition;
        selectOneCategory(categoryId: number): void{
            this.mutationSetFilterCondition({top_category: categoryId});
        }
        clickPanelTitle(panelIndex: number): void{
            if (this.currUnfoldPanelIndex !== panelIndex) {
                this.currUnfoldPanelIndex = panelIndex;
                let categoryId: number = this.categoryList[panelIndex].id;
                this.mutationSetFilterCondition({top_category: categoryId});
            }
        }
        initCaseListRequestParameters(categoryList: CaseCategory[]): void{
            this.mutationSetFilterCondition({top_category: categoryList[this.currUnfoldPanelIndex].id});
            const page: number = parseInt(this.$route.query['page']) || 1;
            const pageSize: number = parseInt(this.$route.query['page_size']) || Constants.PAGE_SIZE;
            this.mutationSetCurrPageNum(page);
            this.mutationSetCurrPageSize(pageSize);
        }
        mounted(): void{
            NetworkCommunication.requestCategoryListWithCache(this.initCaseListRequestParameters);
            this.$nextTick(function (this: leftAccordionMenu) {
                $('#leftAccordionMenu').on('hide.bs.collapse', function (this: leftAccordionMenu) {
                    let collapsedPanelIndex: string|undefined = $('#leftAccordionMenu div.panel-collapse.in').attr('id');
                    if (collapsedPanelIndex) {
                        collapsedPanelIndex = collapsedPanelIndex.substr(-1);
                    }
                    let currUnfoldPanelIndex: number = (collapsedPanelIndex && parseInt(collapsedPanelIndex)) || 0;
                    // 如果要隐藏的是当前正在显示的列表框，则不仅要阻止事件往上冒泡，而且要阻止事件本身
                    return !(this.currUnfoldPanelIndex === currUnfoldPanelIndex);
                }.bind(this));
            });
        }
        destroyed(): void{
            this.mutationResetFilterCondition();
        }
    };
</script>
