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
<script lang="ts">
    import topBar from '../components/topBar.vue';
    import questionEditorForm from '../components/questionEditorForm.vue';
    import {Component, Vue} from 'vue-property-decorator';
    @Component({
        components: {
            topBar,
            questionEditorForm
        }
    })
    export default class editQuestionView extends Vue{
        get questionId () {
            if (this.$route.query['id']) {
                return this.$route.query['id'];
            }
            return '';
        }
    };
</script>
