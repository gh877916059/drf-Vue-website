<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex='0'>
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
                <div class="row">
                    <div v-for="caseObj in caseList" class="col-sm-4">
                        <case-media-object thumbnailSrc=caseObj.thumbnailSrc title=caseObj.tile content=caseObj.content>
                        </case-media-object>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import topBar from '../components/topBar.vue';
    import leftAccordionMenu from '../components/leftAccordionMenu.vue';
    import caseMediaObject from '../components/caseMediaObject.vue';
    import indexCarousel from '../components/indexCarousel.vue';
    export default {
        components: {
            topBar,
            leftAccordionMenu,
            caseMediaObject,
            indexCarousel
        },
        data() {
            return {
                caseList: []
            };
        }
    };
</script>
<style lang="scss">

</style>
