<template>
    <ul class="list-group">
        <li v-for="(questionOutline, index) in questionOutlineList" class="list-group-item"><question-outline-media-object v-bind="question"></question-outline-media-object></li>
    </ul>
</template>

<script>
    import questionOutlineMediaObject from '../components/questionOutlineMediaObject.vue';
    export default {
        components: {
            questionOutlineMediaObject
        },
        data() {
            return {
                questionOutlineList: []
            };
        }
    };
</script>
