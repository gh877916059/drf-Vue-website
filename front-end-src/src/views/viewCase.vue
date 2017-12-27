<template>
    <div>
        <div class="row">
            <div class="col-sm-12">
                <top-bar activeIndex=1>
                </top-bar>
            </div>
        </div>
        <main id="mainContent" class="main-content">
            <div class="page-container ptb-10">
                <div class="container">
                    <case-viewer v-bind:caseId="caseId">
                    </case-viewer>
                </div>
            </div>
        </main>
    </div>
</template>
<script lang="ts">
    import topBar from '../components/topBar.vue';
    import caseViewer from '../components/caseViewer.vue';
    import {Component, Vue} from 'vue-property-decorator';
    @Component({
        components: {
            topBar,
            caseViewer
        }
    })
    export default class viewCaseView extends Vue{
        get caseId(): string{
            if (this.$route.params['id']) {
                return this.$route.params['id'];
            }
            return '';
        }
    };
</script>
