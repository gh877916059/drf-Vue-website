<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=4>
                </top-bar>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <question-editor-form v-bind:questionId="questionId">
                </question-editor-form>
            </div>
        </div>
    </div>
</template>
<script>
    import topBar from '../components/topBar.vue';
    import questionEditorForm from '../components/questionEditorForm.vue';
    export default {
        components: {
            topBar,
            questionEditorForm
        },
        computed: {
            questionId () {
                if (this.$route.query.id) {
                    return this.$route.query.id;
                }
                return '';
            }
        }
    };
</script>
