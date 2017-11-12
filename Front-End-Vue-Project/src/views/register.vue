<template>
    <!-- 取消H5的默认表单验证功能，以免与Foundation的Abide发生冲突 -->
    <form data-abide novalidate id="RegisterForm">
        <div class="row form-icons">
            <h4>注册</h4>
            <!-- 总的错误消息提示框，alert标识的是颜色 -->
            <div data-abide-error class="column small-12 alert callout" style="display: none">
                <p><i class="fi-alert"></i> 表单输入有错误</p>
            </div>
            <div class="column small-12 input-group">
                <span class="input-group-label">
                    <i class="fi fi-torso"></i>
                </span>
                <!-- required表示为必填项 -->
                <input class="input-group-field" type="text" name="username" placeholder="请输入用户名" required
                       pattern="not-shorter-than-six">
                <br/>
                <!-- 对应的错误提示信息 -->
                <span class="form-error">用户名长度不足6位</span>
            </div>

            <div class="column small-12 input-group">
                <span class="input-group-label">
                    <i class="fi fi-mail"></i>
                </span>
                <input class="input-group-field" type="text" name="email" placeholder="请输入邮箱地址" required
                       pattern="email">
                <label>
                    <span class="form-error">邮箱地址格式非法</span>
                </label>
            </div>

            <div class="column small-12 input-group">
                <span class="input-group-label">
                    <i class="fi fi-telephone"></i>
                </span>
                <input class="input-group-field" type="text" name="mobile" placeholder="(非必填）请输入手机号码"
                       pattern="telephone">
                <label>
                    <span class="form-error">手机号码格式非法</span>
                </label>
            </div>

            <div class="column small-12 input-group">
                <span class="input-group-label">
                    <i class="fi fi-key"></i>
                </span>
                <input class="input-group-field" type="password" name="password" id="Password" placeholder="请输入密码"
                       required pattern="not-shorter-than-six">
                <label>
                    <span class="form-error">密码长度不足6位</span>
                </label>
            </div>

            <div class="column small-12 input-group">
                <span class="input-group-label">
                    <i class="fi fi-key"></i>
                </span>
                <input class="input-group-field" type="password" name="repeated_password" placeholder="请重复上面所输入的密码"
                       required data-equalto="Password">
                <div class="form-error">两次输入的密码不一样</div>
            </div>

            <div class="column small-12 input-group">
                <img v-bind:src="pictureCodeSrc">
                <input class="input-group-field" type="text" name="code" placeholder="请输入图片验证码"
                       required pattern="length-equalto-four">
                <div class="form-error">图片验证码长度为4</div>
            </div>

            <input type="hidden" name="picture_token" v-bind:value="pictureToken"/>
        </div>
        <button class="button expanded" v-on:click='postRegisterData'>注册</button>
    </form>
</template>

<script>
    import $ from 'jquery';
    import Vue from 'vue';
    export default {
        data() {
            return {
                pictureCodeSrc: '',
                pictureToken: ''
            };
        },
        methods: {
            postRegisterData: function () {
                var postData = {};
                var fieldArray = $('#RegisterForm').serializeArray();
                $.each(fieldArray, function (i, field) {
                    postData[field.name] = field.value;
                });
                this.$http.post(this.$root.$data.requestHost + '/users/', postData)
                    .then((res) => {
                        Vue.http.headers.common['Authorization'] = 'JWT ' + res.data['jwt_token'];
                        console.log('JWT ' + res.data['jwt_token']);
                        this.$root.jumpToThisPage('/');
                    }, (err) => {
                        console.log('网络请求错误');
                        console.log(err);
                    });
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                // 添加自定义Pattern
                window.Foundation.Abide.defaults.patterns['not-shorter-than-six'] = /^.{6,}$/;
                window.Foundation.Abide.defaults.patterns['length-equalto-four'] = /^.{4,4}$/;
                window.Foundation.Abide.defaults.patterns['telephone'] = /^1[34578]\d{9}$/;
                // 使得Foundation框架生效所必须的操作
                $(document).foundation();
                // 请求图片验证码
                this.$http.get('picturecodes/')
                    .then((res) => {
                        this.pictureCodeSrc = this.$root.$data.requestHost + res.data['cptch_image'];
                        this.pictureToken = res.data['cptch_key'];
                    }, (err) => {
                        console.log('图片验证码请求错误');
                        console.log(err);
                    });
                // 阻止表单的默认提交操作
                $('#RegisterForm').submit(function (e) {
                    e.preventDefault();
                });
            });
        }
    };
</script>

<style lang="scss">
    @import "../assets/scss/constant";

    form {
        .form-icons {
            text-align: center;

            h4 {
                margin-bottom: 1rem;
            }

            .input-group {
                vertical-align: middle;
            }

            .form-error {
                font-size: 1rem;
                margin-top: 1rem;
            }

            .input-group-label {
                background-color: $primary-color;
                border-color: $primary-color;
            }

            .input-group-field {
                border-color: $primary-color;
            }

            .fi {
                color: white;
                width: 1rem; // makes the width of icon labels equal
            }
        }
    }
</style>
