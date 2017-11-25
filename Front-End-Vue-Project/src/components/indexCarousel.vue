<template>
    <div id="focusslide" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li v-for="(banner, index) in bannerList" data-target="#focusslide" v-bind:data-slide-to="index" v-bind:class="[index===0?'active':'']"></li>
        </ol>
        <div class="carousel-inner" role="listbox">
            <div v-for="(banner, index) in bannerList" v-bind:class="[index===0?'active':'', 'item']">
                <a v-bind:href="banner.hyperlink" target="_blank" v-bind:title="banner.title" >
                    <img v-bind:src="banner.image" v-bind:alt="banner.title" class="img-responsive"></a>
            </div>
        </div>
        <a class="left carousel-control" href="#focusslide" role="button" data-slide="prev" rel="nofollow">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">上一个</span>
        </a>
        <a class="right carousel-control" href="#focusslide" role="button" data-slide="next" rel="nofollow">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">下一个</span>
        </a>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                bannerList: []
            };
        },
        methods: {
            // 请求首页轮播图信息
            getBannerList: function () {
                this.$http.get('banners/')
                    .then((res) => {
                        this.bannerList = res.data;
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                this.getBannerList();
            });
        }
    };
</script>
