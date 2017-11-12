<template>
    <ai-head page-type="登录">
    </ai-head>
</template>
<script>
    import aiHead from '../components/header.vue';
    import $ from 'jquery';
    export default {
        components: {
            aiHead
        },
        mounted: function () {
            this.$nextTick(function () {
                // 使得Foundation框架生效所必须的操作
                $(document).foundation();
            });
        }
    };
</script>
<style lang="scss">

</style>
