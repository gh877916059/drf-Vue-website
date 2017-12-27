<template>
    <ul class="list-group">
        <li v-for="(questionOutline, index) in questionOutlineList" class="list-group-item"><question-outline-media-object v-bind="question"></question-outline-media-object></li>
    </ul>
</template>

<script lang="ts">
    import questionOutlineMediaObject from '../components/questionOutlineMediaObject.vue';
    import {QuestionData} from '../commonType';
    import {Component, Vue} from 'vue-property-decorator';
    @Component({
        components: {
            questionOutlineMediaObject
        }
    })
    export default class questionListView extends Vue{
        questionOutlineList: QuestionData[] = [];
    };
</script>
