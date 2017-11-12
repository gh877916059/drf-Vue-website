<template>
    <!-- 置顶导航 -->
    <nav class="top-bar topbar-responsive">
        <div class="top-bar-title">
            <!-- data-responsive-toggle指定触发显示/消失的对象的id，如果屏幕的大小大于640px则不显示该触发按钮 -->
            <span data-responsive-toggle="topbar-responsive" data-hide-for="medium">
                <!--- 附带data-toggle属性的元素负责真正事件的触发 -->
                <button class="menu-icon" type="button" data-toggle></button>
            </span>
            <a class="topbar-responsive-logo" href="#"><strong>APP Inventor案例库</strong></a>
        </div>
        <div id="topbar-responsive" class="topbar-responsive-links">
            <div class="top-bar-right">
                <!-- Add the .simple class to a Menu to remove the padding and color change -->
                <ul class="menu simple vertical medium-horizontal">
                    <li><a href="/">首页</a></li>
                    <li><a href="#">案例</a></li>
                    <li><a href="#">发表</a></li>
                    <li><a href="#">问答</a></li>
                    <li><input type="search" placeholder="Search"></li>
                    <li>
                        <button type="button" class="button hollow topbar-responsive-button" v-on:click='toLoginPage'>登录
                        </button>
                    </li>
                    <li class="menu-text" style="color:gray">Or</li>
                    <li>
                        <button type="button" class="button hollow topbar-responsive-button" v-on:click='toRegisterPage'>注册
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</template>

<script>
    import $ from 'jquery';

    export default {
        // 模板<template>默认替换挂载元素，如果 replace 选项为 false，模板将插入挂载元素内
        replace: true,
        props: {
            pageType: String
        },
        methods: {
            toLoginPage: function () {
                this.$root.jumpToThisPage('login');
            },
            toRegisterPage: function () {
                this.$root.jumpToThisPage('register');
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                var prev = 0;
                var $window = $(window);
                var nav = $('.scrollhide-nav');

                $window.on('scroll', function () {
                    var scrollTop = $window.scrollTop();
                    nav.toggleClass('hidden', scrollTop > prev);
                    prev = scrollTop;
                });
            });
        }
    };
</script>
<style lang="scss">
    @import "../assets/scss/constant";
    @import "../../node_modules/foundation-sites/scss/util/util";

    $topbar-responsive-bg: #2c3840;
    $topbar-responsive-animation-type: fade-in; // or use slide-down or none

    .or-text {
        color: $White;
    }

    .topbar-responsive {
        background: $topbar-responsive-bg;
        padding: 1rem 1.5rem;

        // 白色字体+垂直居中
        .topbar-responsive-logo {
            color: $White;
            vertical-align: middle;
        }

        .menu {
            background: $topbar-responsive-bg;

            li:last-of-type {
                margin-right: 0;
            }

            a {
                color: $White;
                transition: color 0.15s ease-in;

                &:hover {
                    color: lighten($topbar-responsive-bg, 60%);
                }

                @media screen and (max-width: 39.9375em) {
                    padding: 0.875rem 0;
                }
            }

            .topbar-responsive-button {
                color: $White;
                border-color: $White;
                // 向 div 元素添加圆角边框
                border-radius: 500px;
                // transition: property duration timing-function delay;
                // property属性规定应用过渡效果的CSS属性的名称（当指定的 CSS 属性改变时，过渡效果将开始）
                // ease-in规定以慢速开始的过渡效果
                transition: color 0.15s ease-in, border-color 0.15s ease-in;
                // 伪类嵌套和属性嵌套非常类似，只不过他需要借助`&`符号一起配合使用
                &:hover {
                    color: lighten($topbar-responsive-bg, 60%);
                    border-color: lighten($topbar-responsive-bg, 60%);
                }

                @media screen and (max-width: 39.9375em) {
                    width: 100%;
                    margin: 0.875rem 0;
                }
            }
        }

        @media screen and (max-width: 39.9375em) {
            padding: 0.75rem;

            .top-bar-title {
                position: relative;
                width: 100%;

                span {
                    position: absolute;
                    right: 0;
                    border: 1px solid $White;
                    border-radius: 5px;
                    padding: 0.25rem 0.45rem;
                    top: 50%;
                    transform: translateY(-50%);

                    .menu-icon {
                        margin-bottom: 4px;
                    }
                }
            }
        }
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }

    @keyframes slideDown {
        0% {
            transform: translateY(-100%);
        }
        100% {
            transform: translateY(0%);
        }
    }

    @include breakpoint(small only) {
        .topbar-responsive-links {
            // forwards：当动画完成后，保持最后一个属性值（在最后一个关键帧中定义）。
            // backwards：在 animation-delay 所指定的一段时间内，在动画显示之前，应用开始属性值（在第一个关键帧中定义）。
            animation-fill-mode: both;
            animation-duration: 0.5s;
            width: 100%;
            // animation: name duration timing-function delay iteration-count direction;
            // ease	默认。动画以低速开始，然后加快，在结束前变慢。
            @if $topbar-responsive-animation-type == slide-down {
                animation: slideDown 1s ease-in;
            } @else if $topbar-responsive-animation-type == fade-in {
                animation: fadeIn 1s ease-in;
            } @else {
                animation: none;
            }
        }
    }
</style>
