<template>
    <div class="header-deals-slider owl-carousel">
        <div v-for="(banner, index) in bannerList" class="deal-single panel item">
            <a v-bind:href="banner.hyperlink" target="_blank">
                <figure class="deal-thumbnail embed-responsive embed-responsive-16by9" v-bind:data-bg-img="banner.image">
                    <div class="deal-about p-20 pos-a bottom-0 left-0">
                        <h3 class="deal-title mb-10 ">
                            <span class="color-light color-h-lighter">{{banner.title}}</span>
                        </h3>
                    </div>
                </figure>
            </a>
        </div>
    </div>
</template>

<script lang="ts">
    import Utils from '../utils';
    import $ from 'jquery';
    import axios from 'axios';
    import {Component, Vue} from 'vue-property-decorator';
    import {BannerData} from '../commonType';
    @Component
    export default class indexCarousel extends Vue{
        bannerList: BannerData[] = [];
        // 请求首页轮播图信息
        getBannerList(): void{
            axios.get('banners/')
                .then((res) => {
                    for (let resDict of res.data) {
                        let banner = new BannerData(resDict);
                        this.bannerList.push(banner);
                    }
                    this.$nextTick(function () {
                        Utils.initAllBackgroundImage();
                        this.initSlider();
                    });
                }, (err) => {
                    var errorReasonDict = err.body;
                    console.log('---errorReasonDict---');
                    console.log(errorReasonDict);
                });
        }
        initSlider(): void{
            let $owlSlider = $('.owl-carousel');
            $owlSlider.each(function () {
                let carousel = $(this);
                const initConfig = {
                    autoplayHoverPause: true,
                    loop: true,
                    items: 1,
                    lazyLoad: true,
                    margin: 30,
                    autoplay: true,
                    autoplayTimeout: 10000,
                    smartSpeed: 1000,
                    dots: false,
                    nav: true,
                    navText: ["<i class='fa fa-angle-left' aria-hidden='true'></i>", "<i class='fa fa-angle-right' aria-hidden='true'></i>"],
                    navSpeed: false,
                    center: false,
                    responsiveClass: true
                };
                (<any>carousel).owlCarousel(initConfig);
            });
        }
        mounted(): void{
            this.$nextTick(function () {
                this.getBannerList();
            });
        }
    };
</script>
<style lang="scss">
    @import '../assets/scss/common_style';
    @import '../assets/scss/base';
    .owl-loaded .owl-nav {
        margin-top: 0;
    }
    .owl-loaded .owl-nav [class*=owl-] {
        color: #FFF;
        position: absolute;
        top: 50%;
        font-size: 20px;
        margin: 0;
        padding: 4px 8px;
        border-radius: 0;
        background: rgba(0, 0, 0, 0.5);
        -webkit-transform: translateY(-50%);
        transform: translateY(-50%);
        -webkit-transition: all 400ms linear 0ms;
        -ms-transition: all 400ms linear 0ms;
        -o-transition: all 400ms linear 0ms;
        transition: all 400ms linear 0ms;
    }
    .owl-loaded .owl-nav [class*=owl-]:hover {
        background: rgba(0, 0, 0, 0.7);
    }
    .owl-carousel .owl-nav .owl-prev {
        left: 0;
        border-top-right-radius: 3px;
        border-bottom-right-radius: 3px;
    }
    .owl-carousel .owl-nav .owl-next {
        right: 0;
        border-top-left-radius: 3px;
        border-bottom-left-radius: 3px;
    }
</style>
