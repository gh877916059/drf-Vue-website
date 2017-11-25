<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=1>
                </top-bar>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <rich-text-viewer v-bind:caseId="caseId">
                </rich-text-viewer>
            </div>
        </div>
    </div>
</template>
<script>
    import topBar from '../components/topBar.vue';
    import richTextViewer from '../components/richTextViewer.vue';
    export default {
        components: {
            topBar,
            richTextViewer
        },
        computed: {
            caseId () {
                if (this.$route.params.id) {
                    return this.$route.params.id;
                }
                return '';
            }
        }
    };
</script>
<style lang="scss">

</style>
