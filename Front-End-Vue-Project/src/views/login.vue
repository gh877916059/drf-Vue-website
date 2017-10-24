<template>
    <div class="login-page">
        <nv-head page-type="登录">
        </nv-head>
        <section class="page-body">
            <div class="label">
                <!-- placeholder为输入提示信息 -->
                <input class="txt" type="text" placeholder="Access Token" v-model="token" maxlength="36">
            </div>
            <div class="label">
                <a class="button" @click="logon">登录</a>
            </div>
        </section>
    </div>
</template>

<script>
    // import $ from 'webpack-zepto';   因为node运行时会检查是否存在未使用的变量，从而引起编译打包错误
    import nvHead from '../components/header.vue';

    export default {
        data() {
            return {
                token: ''
            };
        },
        methods: {
            logon() {
                if (this.token === '') {
                    this.$alert('令牌格式错误,应为36位UUID字符串');
                    return false;
                }
                /*
                $.ajax({
                    type: 'POST',
                    url: 'https://cnodejs.org/api/v1/accesstoken',
                    data: {
                        accesstoken: this.token
                    },
                    dataType: 'json',
                    success: (res) => {
                        let user = {
                            loginname: res.loginname,
                            avatar_url: res.avatar_url,
                            userId: res.id,
                            token: this.token
                        };
                        window.window.sessionStorage.user = JSON.stringify(user);
                        this.$store.dispatch('setUserInfo', user);
                        // decodeURIComponent() 函数可对 encodeURIComponent() 函数编码的 URI 进行解码
                        let redirect = decodeURIComponent(this.$route.query.redirect || '/');
                        this.$router.push({
                            path: redirect
                        });
                    },
                    error: (res) => {
                        var error = JSON.parse(res.responseText);
                        this.$alert(error.error_msg);
                    }
                });
                */

                // 下面的代码为新增，为了绕过登录验证
                let user = {
                    loginname: '路人',
                    avatar_url: 'https://avatars3.githubusercontent.com/u/3118295?v=4&s=120',
                    userId: 'gg877916059',
                    token: this.token
                };
                window.window.sessionStorage.user = JSON.stringify(user);
                this.$store.dispatch('setUserInfo', user);
                let redirect = decodeURIComponent(this.$route.query.redirect || '/');
                this.$router.push({
                    path: redirect
                });
            }
        },
        components: {
            nvHead
        }
    };
</script>
<style lang="scss">
    .page-body {
        padding: 50px 15px;
        min-height: 400px;
        background-color: #fff;
        .label {
            display: inline-block;
            width: 100%;
            margin-top: 15px;
            position: relative;
            left: 0;
            top: 0;
            .txt {
                /*上下内间距为12像素大小，左右内间距为零*/
                padding: 12px 0;
                border: none;
                border-bottom: 1px solid #4fc08d;
                /*transparent为默认配置，背景颜色为透明（不希望某元素拥有背景色，同时又不希望用户对浏览器的颜色设置影响到您的设计）*/
                background-color: transparent;
                width: 100%;
                font-size: 14px;
                color: #313131;
            }
            .button {
                display: inline-block;
                width: 99%;
                height: 42px;
                line-height: 42px;
                border-radius: 3px;
                color: #fff;
                font-size: 16px;
                background-color: #4fc08d;
                border: none;
                border-bottom: 2px solid #3aa373;
                text-align: center;
                vertical-align: middle;
            }
            .file {
                position: absolute;
                top: 0;
                left: 0;
                height: 42px;
                width: 48%;
                outline: medium none;
                opacity: 0;
            }
        }
    }
</style>
