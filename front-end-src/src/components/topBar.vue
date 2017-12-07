<template>
    <div>
        <nav class="navbar navbar-default">
            <!-- 占满整行 -->
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">APP Inventor案例库</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav" id="navUl">
                        <li><router-link to="/index">首页<!--<span class="sr-only">(current)</span>--></router-link></li>
                        <li><router-link to="/showAllCases">案例</router-link></li>
                        <li><router-link to="/editCase">发表</router-link></li>
                        <li><router-link to="/index">问答</router-link></li>
                    </ul>
                    <form class="navbar-form navbar-left">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="请输入搜索关键字">
                        </div>
                        <button type="submit" class="btn btn-default">搜索</button>
                    </form>
                    <template v-if="userName.length > 0">
                        <ul class="nav navbar-nav navbar-right">
                            <li><button type="button" class="btn btn-default navbar-btn" v-on:click='logout'>注销</button></li>
                        </ul>
                    </template>
                    <template v-else>
                        <ul class="nav navbar-nav navbar-right">
                            <li><button type="button" class="btn btn-default navbar-btn" v-on:click="openLoginModal">登录</button></li>
                            <li><p class="navbar-text">Or</p></li>
                            <li><button type="button" class="btn btn-default navbar-btn" v-on:click="openRegisterModal">注册</button></li>
                        </ul>
                    </template>
                </div>
            </div>
        </nav>

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

<script>
    import $ from 'jquery';
    import loginModal from './loginModal.vue';
    import registerModal from './registerModal.vue';
    export default {
        // 模板<template>默认替换挂载元素，如果 replace 选项为 false，模板将插入挂载元素内
        replace: true,
        props: {
            activeIndex: {
                type: String,
                default: '0'
            }
        },
        components: {
            loginModal,
            registerModal
        },
        computed: {
            userName () {
                return this.$store.state.userName;
            }
        },
        methods: {
            closeLoginModal: function () {
                $('#loginModal').modal('hide');
            },
            closeRegisterModal: function () {
                $('#registerModal').modal('hide');
            },
            openLoginModal: function () {
                // backdrop 为 static 时，点击模态对话框的外部区域不会将其关闭
                // keyboard 为 false 时，按下 Esc 键不会关闭 Modal
                $('#loginModal').modal({backdrop: 'static', keyboard: false});
            },
            openRegisterModal: function () {
                // backdrop 为 static 时，点击模态对话框的外部区域不会将其关闭
                // keyboard 为 false 时，按下 Esc 键不会关闭 Modal
                $('#registerModal').modal({backdrop: 'static', keyboard: false});
                // 触发手机号码的检测函数（因为它可以为空，需要特殊处理）
                $('#mobileInput').trigger('change');
            },
            logout: function () {
                this.$store.commit('setUserName', '');
                window.sessionStorage.userName = '';
                delete window.sessionStorage.AuthorizationHeader;
                delete this.$axios.defaults.headers.common['Authorization'];
                this.$router.go(0);
            }
        },
        // 参数或查询的改变并不会触发进入/离开的导航守卫，因此需要通过观察$route对象来应对这些变化
        watch: {
            $route: function () {
                if (this.$route.query.needToLogin) {
                    this.openLoginModal();
                    delete this.$route.query.needToLogin;
                }
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                var $selector = $('#navUl li');
                $($selector[parseInt(this.activeIndex)]).addClass('active');
                $('#registerModal').on('show.bs.modal', function () {
                    // 请求图片验证码
                    this.$refs.registerModal.requestForPictureCode();
                }.bind(this));
                if (this.$route.query.needToLogin) {
                    this.openLoginModal();
                    delete this.$route.query.needToLogin;
                }
            });
        }
    };
</script>
