<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=3>
                </top-bar>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <question-viewer v-bind:questionId="questionId">
                </question-viewer>
            </div>
        </div>
    </div>
</template>
<script>
    import topBar from '../components/topBar.vue';
    import questionViewer from '../components/questionViewer.vue';
    export default {
        components: {
            topBar,
            questionViewer
        },
        computed: {
            questionId () {
                if (this.$route.params.id) {
                    return this.$route.params.id;
                }
                return '';
            }
        }
    };
</script>
