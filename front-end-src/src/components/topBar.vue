<template>
    <div>
        <div class="header-header bg-white">
            <div class="container">
                <div class="row row-rl-0 row-tb-20 row-md-cell">
                    <div class="brand col-md-3 t-xs-center t-md-left valign-middle pt-15">
                        <router-link to="/index" class="logo">
                            <img v-bind:src="logoUrl" alt="" width="250">
                        </router-link>
                    </div>
                    <div class="header-search col-md-9">
                        <div class="row row-tb-10 ">
                            <div class="col-sm-8">
                                <form class="search-form">
                                    <div class="input-group">
                                        <input type="text" class="form-control input-lg search-input" placeholder="请输入要搜索的关键字 ..." required="required">
                                        <div class="input-group-btn">
                                            <div class="input-group">
                                                <select class="form-control input-lg search-select">
                                                    <option>请选择搜索类型</option>
                                                    <option>案例</option>
                                                    <option>问题</option>
                                                    <option>用户</option>
                                                </select>
                                                <div class="input-group-btn">
                                                    <button type="submit" class="btn btn-lg btn-search btn-block">
                                                        <i class="fa fa-search font-16"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="col-sm-4 t-xs-center t-md-right pt-15">
                                <template v-if="userName.length > 0">
                                    <div class="header-login">
                                        <span>当前用户：</span>
                                        <span v-text="userName"></span>
                                    </div>
                                    <div class="header-login">
                                        <a v-on:click="logout">
                                            <span class="icon fa fa-lock"></span>
                                            <span class="title pt-10">注销</span>
                                        </a>
                                    </div>
                                </template>
                                <template v-else>
                                    <div class="header-login">
                                        <a v-on:click="openLoginModal">
                                            <span class="icon fa fa-lock font-30"></span>
                                            <span class="title pt-10">登录</span>
                                        </a>
                                    </div>
                                    <div class="header-register ml-20">
                                        <a v-on:click="openRegisterModal">
                                            <span class="icon fa fa-user font-30"></span>
                                            <span class="title pt-10">注册</span>
                                        </a>
                                    </div>
                                </template>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="header-menu bg-blue">
            <div class="container">
                <nav class="nav-bar">
                    <div class="nav-header">
                            <span class="nav-toggle" data-toggle="#header-navbar">
		                        <i></i>
		                        <i></i>
		                        <i></i>
		                    </span>
                    </div>
                    <div id="header-navbar" class="nav-collapse">
                        <ul class="nav-menu" id="navUl">
                            <li>
                                <router-link to="/index">首页</router-link>
                            </li>
                            <li>
                                <router-link to="/showAllCases">案例</router-link>
                                <ul style="display: none;">
                                    <li v-for="parentCategory in categoryList">
                                        <a href="#" v-on:click="jumpToShowCaseByCategoryPage(parentCategory.id)">{{parentCategory.name}}</a>
                                        <ul>
                                            <li v-for="subCategory in parentCategory.sub_cat">
                                                <a href="#" v-on:click="jumpToShowCaseByCategoryPage(subCategory.id)">{{subCategory.name}}</a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <router-link to="/editCase">发表</router-link>
                            </li>
                            <li>
                                <router-link to="/showAllQuestions">问题</router-link>
                                <ul style="">
                                    <li v-for="questionState in questionStateList">
                                        <a href="#">{{questionState.name}}</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <router-link to="/editQuestion">提问</router-link>
                            </li>
                        </ul>
                    </div>
                    <div class="nav-menu nav-menu-fixed">
                        <a href="http://app.gzjkw.net/" target="_blank">关于我们</a>
                    </div>
                </nav>
            </div>
        </div>

        <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title text-center">登录</h4>
                    </div>
                    <login-modal ref="loginModal" v-on:closeLoginModal="closeLoginModal"></login-modal>
                </div>
            </div>
        </div>

        <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title text-center">注册</h4>
                    </div>
                    <register-modal ref="registerModal" v-on:closeRegisterModal="closeRegisterModal"></register-modal>
                </div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
    import $ from 'jquery';
    import JQuery from 'jquery/dist/jquery.slim';
    import loginModal from './loginModal.vue';
    import registerModal from './registerModal.vue';
    import Constants from '../constants';
    import FixedData, {questionState} from '../vuex/fixedData';
    import {Component, Vue, Prop, Watch} from 'vue-property-decorator';
    import {jumpToThisPage} from '../router';
    import {State, Mutation} from 'vuex-class';
    import networkCommunication from "../vuex/networkCommunication";

    @Component({
        components: {
            loginModal,
            registerModal
        }
    })
    export default class topBar extends Vue{
        windowWidth: number|undefined = $(window).width();
        @Prop({type: String, default: '0'})
        activeIndex: string;
        @State('userName') userName;
        @State('categoryList') categoryList;
        get logoUrl(): string{
            return Constants.REQUEST_HOST + '/static/image/logo.png';
        }
        get questionStateList(): questionState[]{
            return FixedData.questionStateList;
        }
        @Mutation('setUserName') mutationSetUserName;
        closeLoginModal(): void{
            $('#loginModal').modal('hide');
        }
        closeRegisterModal(): void{
            $('#registerModal').modal('hide');
        }
        openLoginModal(): void{
            // backdrop 为 static 时，点击模态对话框的外部区域不会将其关闭
            // keyboard 为 false 时，按下 Esc 键不会关闭 Modal
            $('#loginModal').modal({backdrop: 'static', keyboard: false});
        }
        openRegisterModal(): void{
            // backdrop 为 static 时，点击模态对话框的外部区域不会将其关闭
            // keyboard 为 false 时，按下 Esc 键不会关闭 Modal
            $('#registerModal').modal({backdrop: 'static', keyboard: false});
            // 触发手机号码的检测函数（因为它可以为空，需要特殊处理）
            $('#mobileInput').trigger('change');
        }
        logout(): void{
            this.mutationSetUserName('');
            window.sessionStorage.userName = '';
            networkCommunication.deleteAuthorizationToken();
            this.$router.go(0);
        }
        jumpToShowCaseByCategoryPage(topCategory) {
            jumpToThisPage('/showAllCases', {top_category: topCategory});
        }
        navbarResizeLoad() {
            if ($('.nav-header').css('display') === 'block') {
                $('.nav-bar').addClass('nav-mobile');
                $('.nav-menu').find('li.active').addClass('active-mobile');
            } else {
                $('.nav-bar').removeClass('nav-mobile');
            }
            if (this.windowWidth && this.windowWidth >= 943) {
                $('.dropdown-mega-menu a, .nav-menu li:has( > ul) a').each(function () {
                    $(this).parent().children('ul, .mega-menu').slideUp(0);
                });
                $($('.nav-toggle').data('toggle')).show();
                $('.nav-menu').find('li').removeClass('active-mobile');
            }
        }
        navbarInit() {
            $('.nav-menu > li:has( > ul) > a').append('<span class="indicator"><i class="fa fa-angle-down"></i></span>');
            $('.nav-menu > li ul > li:has( > ul) > a').append('<span class=\"indicator\"><i class=\"fa fa-angle-right\"></i></span>');
            let _this: topBar = this;
            $('.nav-menu li:has( > ul)').on('mouseenter', function () {
                if (_this.windowWidth && _this.windowWidth > 943) {
                    $(this).children('ul, .mega-menu').fadeIn(100);
                }
            });
            $('.nav-menu li:has( > ul)').on('mouseleave', function () {
                if (_this.windowWidth && _this.windowWidth > 943) {
                    $(this).children('ul, .mega-menu').fadeOut(100);
                }
            });
            $('.nav-menu li:has( > ul) > a').on('click', function (e) {
                if (_this.windowWidth && _this.windowWidth <= 943) {
                    $(this).parent().addClass('active-mobile').children('ul, .mega-menu').slideToggle(150, function() {

                    });
                    $(this).parent().siblings().removeClass('active-mobile').children('ul, .mega-menu').slideUp(150);
                }
                e.preventDefault();
            });
            $('.nav-toggle').on('click', function (e) {
                var toggleId = $(this).data('toggle');
                $(toggleId).slideToggle(150);
                e.preventDefault();
            });
        }
        // 参数或查询的改变并不会触发进入/离开的导航守卫，因此需要通过观察$route对象来应对这些变化
        @Watch('$route')
        onQueryArgsChanged() {
            if (this.$route.query['needToLogin']) {
                this.openLoginModal();
                delete this.$route.query['needToLogin'];
            }
        }
        mounted(): void{
            this.$nextTick(function () {
                let $selector: JQuery<HTMLElement> = $('#navUl > li');
                $($selector[parseInt(this.activeIndex)]).addClass('active');
                $('#registerModal').on('show.bs.modal', function (this: topBar) {
                    // 请求图片验证码
                    (<registerModal>this.$refs.registerModal).requestForPictureCode();
                }.bind(this));
                if (this.$route.query.needToLogin) {
                    this.openLoginModal();
                    delete this.$route.query.needToLogin;
                }
                this.navbarInit();
                this.navbarResizeLoad();
                $(window).on('resize', this.navbarResizeLoad);
            });
        }
    };
</script>
<style lang="scss" >
    @import '../assets/scss/base';
    /* |–––––––––––––––––[ Top bar ]–––––––––––––––| */
    .nav-top ul {
        padding: 8px;
        opacity: 0;
        display: none;
        visibility: hidden;
        position: absolute;
        top: 150%;
        left: 0;
        text-align: left;
        background: #fff;
        border: 1px solid #eee;
        min-width: 200px;
        -webkit-box-shadow: 1px 0 2px rgba(0, 0, 2, 0.1);
        box-shadow: 1px 0 2px rgba(0, 0, 2, 0.1);
        -webkit-transition: all 0.5s ease-in-out;
        -o-transition: all 0.5s ease-in-out;
        transition: all 0.5s ease-in-out;
        z-index: -9;
    }
    .nav-top > li {
        position: relative;
    }
    .nav-top-left > li + li {
        padding-left: 12px;
    }
    .nav-top-right > li + li {
        padding-right: 12px;
    }
    .nav-top > li:hover ul {
        display: block;
        visibility: visible;
        z-index: 9;
        opacity: 1;
        top: 100%;
    }
    .nav-top a {
        display: block;
        font-size: 12px;
        line-height: 22px;
        color: #333;
        padding-top: 5px;
        padding-bottom: 5px;
    }
    .nav-top a:hover {
        color: #000;
    }
    .nav-top > li > a {
        padding-top: 12px;
        padding-bottom: 12px;
    }
    .nav-top > li:hover > a {
        color: #000;
    }
    .nav-top ul a {
        padding: 5px 10px;
        -webkit-transition: all 0.5s ease-in-out;
        -o-transition: all 0.5s ease-in-out;
        transition: all 0.5s ease-in-out;
    }
    .nav-top ul a:hover {
        background-color: #f1f1f1;
    }
    .nav-top .fa {
        margin-right: 6px;
        font-size: 14px;
        color: #2ed87b;
    }

    /* |–––––––––––––––––[ Header Header ]–––––––––––––––| */
    .header-header {
        padding-top: 30px;
        padding-bottom: 30px;
    }
    .header-search .search-input {
        border-right: 1px solid #ddd;
    }
    .header-search .search-select {
        width: 180px !important;
        border-left: 0;
        border-radius: 0;
    }
    .header-search .btn-lg {
        padding-left: 20px;
        padding-right: 20px;
    }
    .header-search .form-control {
        font-size: 12px;
    }
    .header-search .form-control:focus {
        border-color: #ddd;
    }
    .header-login,
    .header-register {
        position: relative;
        display: inline-block;
        padding-left: 40px;
        vertical-align: top;
        text-align: left;
    }
    .header-login .icon,
    .header-register .icon {
        position: absolute;
        top: 2px;
        left: 0;
        font-size: 34px;
        font-weight: normal;
    }
    .header-login .title,
    .header-register .title {
        display: inline-block;
        width: 35px;
        line-height: 1.6;
    }
    .header-login .cart-number,
    .header-register .cart-number {
        display: inline-block;
        font-size: 12px;
        height: 16px;
        padding: 0 8px;
        line-height: 16px;
        text-align: center;
        color: #fff;
        background-color: #ff6666;
        border-radius: 16px;
    }

    /* |–––––––––––––––––[ Header Menu ]–––––––––––––––| */
    .nav-menu > li > a,
    .nav-menu-fixed > a {
        color: #fff;
    }
    .nav-menu > li > ul a {
        color: #314555;
    }
    .nav-menu-fixed > a,
    .nav-menu > li:hover > a,
    .nav-menu > li.active > a {
        background-color: #2ed87b;
    }
    .nav-menu > li > ul a {
        color: #314555;
        background-color: #fff;
    }
    .nav-menu > li > ul li:hover > a,
    .nav-menu > li > ul li.active > a {
        color: #2ed87b;
        background-color: #f1f1f1;
    }
    .nav-bar {
        position: relative;
    }
    .nav-header {
        position: relative;
        display: none;
    }
    .nav-menu > li a .indicator {
        margin-left: 10px;
    }
    .nav-menu > li > ul li a .indicator {
        position: absolute;
        top: 0;
        right: 15px;
    }
    .nav-toggle {
        display: inline-block;
        vertical-align: middle;
        cursor: pointer;
        width: 40px;
        padding: 10px 4px;
        left: 0;
    }
    .nav-toggle i {
        display: block;
        width: 100%;
        height: 2px;
        background-color: #fff;
    }
    .nav-toggle i + i {
        margin-top: 7px;
    }
    .nav-menu {
        margin: 0 auto;
        list-style: none;
        padding: 0;
        position: relative;
    }
    .nav-menu:before,
    .nav-menu:after {
        content: "";
        display: table;
    }
    .nav-menu:after {
        clear: both;
    }
    .nav-menu.nav-menu-fixed {
        position: absolute;
        top: 0;
        right: 0;
    }
    .nav-menu.nav-menu-fixed a {
        display: inline-block;
    }
    .nav-bar ul {
        list-style: none;
        margin: 0;
        padding: 0;
    }
    .nav-menu > li > ul,
    .nav-menu > li > ul > li ul,
    .nav-menu .mega-menu {
        background: #fff;
        margin: 0;
        display: none;
        min-width: 200px;
        position: absolute;
        z-index: 99;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
    }
    .nav-menu > li > ul {
        top: 100%;
        left: 0;
    }
    .nav-menu > li:last-child > ul {
        right: 0;
    }
    .nav-menu > li > ul > li ul {
        top: 0;
        left: 100%;
    }
    .nav-menu > li:last-child > ul > li ul {
        right: 100%;
    }
    .nav-menu .mega-menu {
        width: 100%;
        top: 100%;
        left: 0;
        padding: 15px 20px;
    }
    .nav-menu li {
        display: block;
        position: relative;
    }
    .nav-menu .dropdown-mega-menu {
        position: static;
    }
    .nav-menu > li {
        float: left;
    }
    .nav-menu a {
        text-decoration: none;
        display: block;
        padding: 0 20px;
        margin: 0;
        position: relative;
    }
    .nav-menu .mega-menu a {
        padding: 0;
    }
    .nav-menu > li > a,
    .nav-menu > a {
        height: 60px;
        line-height: 60px;
    }
    .nav-menu > li ul li a {
        height: 40px;
        line-height: 40px;
    }
    .nav-menu .mega-menu li a {
        height: 35px;
        line-height: 35px;
    }
    .nav-menu .mega-menu .mega-title {
        display: inline-block;
        height: 40px;
        line-height: 40px;
        text-transform: uppercase;
        font-size: 14px;
    }
    @media only screen and (max-width: 959px) {
        .nav-menu {
            background-color: #fff;
        }
        .nav-menu li > a,
        .nav-menu li.active a {
            color: #314555;
            background-color: #fff;
        }
        .nav-menu li:hover > a,
        .nav-menu li.active-mobile > a {
            color: #2ed87b;
            background-color: #f1f1f1;
        }
        .nav-header {
            display: block;
        }
        .nav-collapse {
            display: none;
            padding-bottom: 10px;
        }
        .nav-header,
        .nav-menu.nav-menu-fixed a {
            height: 60px;
            line-height: 60px;
        }
        .nav-menu > li a .indicator {
            position: absolute;
            top: 0;
            right: 20px;
        }
        .nav-menu ul {
            padding-left: 20px;
        }
        .nav-menu .mega-menu,
        .nav-menu > li > ul,
        .nav-menu > li > ul > li ul {
            width: 100%;
            position: static;
        }
        .nav-menu .mega-menu {
            padding: 0 20px;
        }
        .nav-menu li {
            width: 100%;
            float: none;
            border-bottom: 1px solid #eee;
        }
        .nav-menu li:last-child {
            border-bottom: 0;
        }
        .nav-menu > li > a {
            height: 40px;
            line-height: 40px;
        }
        .nav-menu > li ul li a {
            height: 40px;
            line-height: 40px;
        }
    }
</style>
