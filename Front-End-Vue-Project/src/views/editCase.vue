<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=2>
                </top-bar>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <rich-text-editor v-bind:caseId="caseId">
                </rich-text-editor>
            </div>
        </div>
    </div>
</template>
<script>
    import topBar from '../components/topBar.vue';
    import richTextEditor from '../components/richTextEditor.vue';
    export default {
        components: {
            topBar,
            richTextEditor
        },
        computed: {
            caseId () {
                if (this.$route.query.id) {
                    return this.$route.query.id;
                }
                return '';
            }
        }
    };
</script>
<style lang="scss">

</style>
