<template>
    <div class="media">
        <a class="media-left" href="#">
            <img class="media-object" v-bind:data-src="thumbnailSrc" alt="Generic placeholder image">
        </a>
        <div class="media-body">
            <h4 class="media-heading" v-text="title"></h4>
            {{content}}
        </div>
    </div>
</template>

<script>
    export default {
        // 模板<template>默认替换挂载元素，如果 replace 选项为 false，模板将插入挂载元素内
        replace: true,
        props: {
            thumbnailSrc: String,
            title: String,
            content: String
        }
    };
</script>
