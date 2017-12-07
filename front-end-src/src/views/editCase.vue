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
                <case-editor-form v-bind:caseId="caseId">
                </case-editor-form>
            </div>
        </div>
    </div>
</template>
<script>
    import topBar from '../components/topBar.vue';
    import caseEditorForm from '../components/caseEditorForm.vue';
    export default {
        components: {
            topBar,
            caseEditorForm
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
