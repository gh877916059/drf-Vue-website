<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=2>
                </top-bar>
            </div>
        </div>

        <main id="mainContent" class="main-content">
            <div class="page-container ptb-10">
                <div class="container">
                    <case-editor-form v-bind:caseId="caseId">
                    </case-editor-form>
                </div>
            </div>
        </main>

    </div>
</template>
<script lang="ts">
    import topBar from '../components/topBar.vue';
    import caseEditorForm from '../components/caseEditorForm.vue';
    import {Component, Vue} from 'vue-property-decorator';
    @Component({
        components: {
            topBar,
            caseEditorForm
        }
    })
    export default class editCaseView extends Vue{
        get caseId () {
            if (this.$route.query['id']) {
                return this.$route.query['id'];
            }
            return '';
        }
    };
</script>
