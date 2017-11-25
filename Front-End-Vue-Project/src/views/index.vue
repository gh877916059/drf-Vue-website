<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=0>
                </top-bar>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <index-carousel>
                </index-carousel>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-3">
                <left-accordion-menu>
                </left-accordion-menu>
            </div>
            <div class="col-sm-9">
                <case-list></case-list>
            </div>
        </div>
    </div>
</template>
<script>
    import topBar from '../components/topBar.vue';
    import leftAccordionMenu from '../components/leftAccordionMenu.vue';
    import indexCarousel from '../components/indexCarousel.vue';
    import caseList from '../components/caseList.vue';
    export default {
        components: {
            topBar,
            leftAccordionMenu,
            caseList,
            indexCarousel
        }
    };
</script>
<style lang="scss">

</style>
