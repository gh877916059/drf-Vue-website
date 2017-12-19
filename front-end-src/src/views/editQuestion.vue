<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=4>
                </top-bar>
            </div>
        </div>

        <main id="mainContent" class="main-content">
            <div class="page-container ptb-10">
                <div class="container">
                    <question-editor-form v-bind:questionId="questionId">
                    </question-editor-form>
                </div>
            </div>
        </main>
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
