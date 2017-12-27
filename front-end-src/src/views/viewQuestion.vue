<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=3>
                </top-bar>
            </div>
        </div>
        <main id="mainContent" class="main-content">
            <div class="page-container ptb-10">
                <div class="container">
                    <question-viewer v-bind:questionId="questionId">
                    </question-viewer>
                </div>
            </div>
        </main>

    </div>
</template>
<script lang="ts">
    import topBar from '../components/topBar.vue';
    import questionViewer from '../components/questionViewer.vue';
    import {Component, Vue} from 'vue-property-decorator';
    @Component({
        components: {
            topBar,
            questionViewer
        }
    })
    export default class viewQuestionView extends Vue{
        get questionId(): string{
            if (this.$route.params['id']) {
                return this.$route.params['id'];
            }
            return '';
        }
    };
</script>
