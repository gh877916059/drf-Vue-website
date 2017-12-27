<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=0>
                </top-bar>
            </div>
        </div>

        <main id="mainContent" class="main-content">
            <div class="page-container ptb-10">
                <div class="container">
                    <div class="section deals-header-area ptb-30">
                        <div class="row row-tb-20">
                            <div class="col-xs-12 col-md-4 col-lg-3">
                                <hot-category-list></hot-category-list>
                            </div>
                            <div class="col-xs-12 col-md-8 col-lg-9">
                                <index-carousel></index-carousel>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-3">
                            <left-accordion-menu>
                            </left-accordion-menu>
                        </div>
                        <div class="col-sm-9">
                            <div class="row">
                                <div class="col-sm-12">
                                    <case-list v-bind:isShowPagination='isShowPagination'></case-list>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </main>
    </div>
</template>
<script lang="ts">
    import { Component, Prop, Vue, Watch } from 'vue-property-decorator'
    import topBar from '../components/topBar.vue';
    import leftAccordionMenu from '../components/leftAccordionMenu.vue';
    import hotCategoryList from '../components/hotCategoryList.vue';
    import indexCarousel from '../components/indexCarousel.vue';
    import caseList from '../components/caseList.vue';
    @Component({
        components: {
            topBar,
            leftAccordionMenu,
            hotCategoryList,
            caseList,
            indexCarousel
        }
    })
    export default class indexView extends Vue{
        isShowPagination: boolean =  false
    };
</script>
<style lang="scss">

</style>
