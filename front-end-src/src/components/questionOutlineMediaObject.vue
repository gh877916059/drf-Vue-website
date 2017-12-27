<template>
    <div class="media">
        <div class="media-left media-middle">
            <router-link v-bind:to="questionDetailUrl">
                <img v-bind:src="questionOutline.user_avatar" class="media-object" style="height:80px">
            </router-link>
        </div>
        <div class="media-body">
            <h4 class="media-heading">{{questionOutline.name}} <small><i>Posted on {{questionOutline.add_time | makeTimeFriendly()}}</i></small></h4>
            <p v-text="questionOutline.question_brief"></p>
        </div>
    </div>
</template>

<script lang="ts">
    import {Component, Vue, Prop} from 'vue-property-decorator';
    import {QuestionData} from '../commonType';
    @Component
    export default class questionOutlineMediaObject extends Vue{
        @Prop()
        questionOutline: QuestionData;
        get questionDetailUrl(): string{
            return '/viewQuestion/' + this.questionOutline.id;
        }
    };
</script>
