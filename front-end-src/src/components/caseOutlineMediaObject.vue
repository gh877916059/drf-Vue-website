<template>
    <div class="deal-single panel" v-bind:id="rootDivId">
        <figure class="deal-thumbnail embed-responsive embed-responsive-16by9" v-bind:data-bg-img="cases_front_image">
            <div class="label-discount" v-text="category_name"></div>
            <div class="time-left font-md-14" style="bottom: 15px;right: 20px">
                <span>
                    <i class="fa fa-clock-o mr-10"></i>
                    <span class="t-uppercase">{{add_time | makeTimeFriendly()}}</span>
                </span>
            </div>
            <div class="deal-store-logo">
                <img v-bind:src="user_avatar">
            </div>
        </figure>
        <div class="bg-white pt-20 pl-20 pr-15">
            <div class="pr-md-10">
                <div class="rating mb-10">
                    <span class="rating-stars rate-allow" v-on:mouseleave="mouseLeaveStars" v-on:mouseenter="mouseEnterStars">
                        <i v-for="index in starSum" class="fa fa-star-o" v-on:click="refreshRating(starSum - index + 1)"></i>
                    </span>
                    <span class="rating-reviews">
                        ( <span v-text="rating_num"></span> rates )
                    </span>
                    <ul class="deal-actions">
                        <li class="like-deal">
                            <i class="fa fa-heart"></i>
                        </li>
                        <li class="share-btn" v-on:click="clickSnsShare">
                            <div class="share-tooltip fade">
                                <a target="_blank" href="#"><i class="fa fa-facebook"></i></a>
                                <a target="_blank" href="#"><i class="fa fa-twitter"></i></a>
                                <a target="_blank" href="#"><i class="fa fa-google-plus"></i></a>
                                <a target="_blank" href="#"><i class="fa fa-pinterest"></i></a>
                            </div>
                            <i class="fa fa-share-alt"></i>
                        </li>
                        <li>
                            <i class="fa fa-camera"></i>
                        </li>
                    </ul>
                </div>
                <h3 class="mb-10">
                    <router-link v-bind:to="viewCaseUrl" v-text="name"></router-link>
                </h3>
                <ul class="list-inline mb-10 color-mid">
                    <li><i class="glyphicon glyphicon-eye-open mr-10"></i> {{click_num}}</li>
                    <li><i class="glyphicon glyphicon-comment mr-10"></i> {{reply_num}}</li>
                    <li><i class="glyphicon glyphicon-star mr-10"></i> {{fav_num}}</li>
                </ul>
                <p class="text-muted mb-20" v-text="cases_brief"></p>
            </div>
        </div>
    </div>
</template>

<script>
    import Constants from '../constants';
    import $ from 'jquery';
    import Utils from '../utils';
    export default {
        // 模板<template>默认替换挂载元素，如果 replace 选项为 false，模板将插入挂载元素内
        replace: true,
        data() {
            return {
                $rootDiv: null,
                $shareIcons: null,
                $ratingStars: null,
                starSum: 5,
                ratingScore: 3
            };
        },
        props: {
            cases_front_image: {
                type: String,
                default: ''
            },
            name: {
                type: String,
                default: '暂无标题'
            },
            cases_brief: {
                type: String,
                default: '暂无简介'
            },
            category_name: {
                type: String,
                default: '未知类别'
            },
            add_time: {
                type: String,
                default: '未知日期'
            },
            click_num: {
                type: Number,
                default: 0
            },
            reply_num: {
                type: Number,
                default: 0
            },
            fav_num: {
                type: Number,
                default: 0
            },
            id: {
                type: Number,
                default: 0
            },
            user_avatar: {
                type: String,
                default: Constants.REQUEST_HOST + '/static/image/fail.jpg'
            },
            rating_num: {
                type: Number,
                default: 0
            },
            sum_rating_score: {
                type: Number,
                default: 0
            }
        },
        computed: {
            viewCaseUrl () {
                return '/viewCase/' + this.id;
            },
            rootDivId () {
                return 'caseMediaObject' + this.id;
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                this.$rootDiv = $('#' + this.rootDivId);
                this.$shareIcons = this.$rootDiv.find('.deal-actions .share-btn .share-tooltip');
                this.$ratingStars = this.$rootDiv.find('.rating .rating-stars.rate-allow i');
                Utils.initAllBackgroundImage();
                this.initRating();
            });
        },
        methods: {
            initRating: function() {
                var ratingScore = Math.ceil(this.sum_rating_score / this.rating_num);
                this.refreshRating(ratingScore);
            },
            refreshRating: function(ratingScore) {
                if (ratingScore) {
                    this.ratingScore = ratingScore;
                }
                var ratingIndex = this.starSum - this.ratingScore;
                this.$ratingStars.eq(ratingIndex).addClass('star-active');
            },
            clickSnsShare: function() {
                this.$shareIcons.toggleClass('in');
            },
            mouseEnterStars: function () {
                this.$ratingStars.removeClass('star-active');
            },
            mouseLeaveStars: function() {
                this.refreshRating();
            }
        }
    };
</script>

<style lang="scss">
    @import '../assets/scss/base';
    @import '../assets/scss/common_style';
    @import '../assets/scss/media_object_base_style';
    .deal-actions {
        display: inline;
        z-index: 10;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        float: right;
        margin-right: -25px;
    }
    .deal-actions li {
        position: relative;
        display: inline-block;
        vertical-align: middle;
        margin-right: 5px;
        color: #2ed87b;
        cursor: pointer;
    }
    .deal-actions li .share-tooltip {
        position: absolute;
        right: -48px;
        top: 35px;
        background-color: #2ed87b;
        white-space: nowrap;
        display: block;
        padding: 0 5px;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        -ms-border-radius: 3px;
        border-radius: 3px;
    }
    .deal-actions li .share-tooltip:after {
        border: solid transparent;
        content: ' ';
        height: 0;
        position: absolute;
        right: 39%;
        top: -13px;
        left: inherit;
        z-index: 2;
        width: 0;
        border-width: 7px;
        border-bottom-color: #2ed87b;
    }
    .deal-actions li .share-tooltip a {
        position: relative;
        top: 7px;
        display: inline-block;
        color: #fff;
        font-size: 16px;
        padding: 0 6px;
        width: 30px;
        height: 30px;
        line-height: 30px;
        text-align: center;
    }
    .deal-actions li.like-deal.favorite .fa-heart {
        color: red;
    }

    .rating {
        color: #ff3100;
    }
    .rating .rating-stars {
        unicode-bidi: bidi-override;
        direction: rtl;
        white-space: nowrap;
        display: inline-table;
    }
    .rating .rating-stars.rate-allow {
        cursor: pointer;
    }
    .rating .fa {
        display: table-cell;
        font-size: 16px;
        padding: 2px;
    }
    .rating .rate-allow .fa:hover:before,
    .rating .rate-allow .fa:hover ~ .fa:before,
    .rating .rating-stars .fa.star-active:before,
    .rating .rating-stars .fa.star-active ~ .fa:before {
        content: "\f005";
    }
    .rating .rating-reviews {
        color: #717f86;
        margin-left: 6px;
    }
</style>
