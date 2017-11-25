<template>
    <form data-toggle="validator" role="form" id="registerForm">
        <div class="form-group">
            <i class="fa fa-user-circle fa-lg" aria-hidden="true"></i>
            <input type="text" class="form-control" name="username" placeholder="请输入用户名" data-pattern-error="用户名长度不足6位" data-required-error="用户名不可以为空" pattern="^.{6,}$" required data-serverValidation>
            <div class="help-block with-errors"></div>
        </div>

        <div class="form-group">
            <i class="fa fa-envelope fa-lg" aria-hidden="true"></i>
            <input type="email" class="form-control" name="email" placeholder="请输入邮箱地址" data-error="邮箱地址格式非法" required>
            <div class="help-block with-errors"></div>
        </div>

        <div class="form-group">
            <i class="fa fa-envelope fa-lg" aria-hidden="true"></i>
            <input type="text" class="form-control" name="mobile" placeholder="(非必填）请输入手机号码" data-pattern-error="手机号码格式错误" pattern="^1[34578]\d{9}$">
            <div class="help-block with-errors"></div>
        </div>

        <div class="form-group">
            <i class="fa fa-lock fa-lg" aria-hidden="true"></i>
            <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" data-pattern-error="密码长度不足6位" data-required-error="密码不可以为空" pattern="^.{6,}$" required>
            <div class="help-block with-errors"></div>
        </div>

        <div class="form-group">
            <i class="fa fa-lock fa-lg" aria-hidden="true"></i>
            <input type="password" class="form-control" name="repeated_password" placeholder="请重复上面所输入的密码" data-match-error="两次输入的密码不一样" data-required-error="必须重复上面的密码" data-match="#password" required>
            <div class="help-block with-errors"></div>
        </div>

        <div class="form-group">
            <img v-bind:src="pictureCodeSrc" style="cursor: pointer" v-on:click='requestForPictureCode'>
            <input type="text" class="form-control" name="code" placeholder="请输入图片验证码" data-pattern-error="验证码的长度必须为4位" data-required-error="验证码不可以为空" pattern="^.{4,4}$" required data-serverValidation>
            <div class="help-block with-errors"></div>
        </div>

        <div class="form-group">
            <input type="hidden" name="picture_token" v-bind:value="pictureToken"/>
        </div>

        <div class="form-group">
            <button class="button expanded" v-on:click='postRegisterData'>注册</button>
        </div>
    </form>
</template>

<script>
    import $ from 'jquery';
    import Vue from 'vue';

    export default {
        data() {
            return {
                pictureCodeSrc: '',
                pictureToken: '',
                serverValidationResult: {}
            };
        },
        methods: {
            postRegisterData: function () {
                var errorNum = $('#registerForm').validator('validate').has('.has-error').length;
                if (errorNum > 0) {
                    return;
                }
                var postData = this.$root.getFormInput('registerForm');
                this.$http.post('users/', postData)
                    .then((res) => {
                        Vue.http.headers.common['Authorization'] = 'JWT ' + res.data['jwt_token'];
                        window.sessionStorage.AuthorizationHeader = 'JWT ' + res.data['jwt_token'];
                        this.setUserName($('#registerForm input[name="username"]').val());
                        this.$emit('closeRegisterModal');
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                        for (var key in errorReasonDict) {
                            if (key === 'non_field_errors') {
                                var reason = errorReasonDict[key][0];
                                if (reason.indexOf('令牌') === -1) {
                                    this.serverValidationResult['code'] = errorReasonDict[key];
                                }
                                this.requestForPictureCode();
                            } else if (key === 'picture_token') {
                                this.requestForPictureCode();
                            } else {
                                this.serverValidationResult[key] = errorReasonDict[key];
                            }
                        };
                        $('#registerForm').validator('validate');
                        this.serverValidationResult = {};
                    });
            },
            // 请求图片验证码
            requestForPictureCode: function () {
                this.$http.get('picturecodes/')
                    .then((res) => {
                        this.pictureCodeSrc = this.$root.$data.requestHost + res.data['cptch_image'];
                        this.pictureToken = res.data['cptch_key'];
                        $('#registerForm input[name="code"]').val('');
                    }, (err) => {
                        console.log('图片验证码请求错误');
                        console.log(err);
                    });
            },
            setUserName: function(userName) {
                this.$store.commit('setUserName', userName);
                window.sessionStorage.userName = userName;
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                // 阻止表单的默认提交操作
                $('#registerForm').submit(function (e) {
                    e.preventDefault();
                });
                $('#registerForm i').css('margin-left', '2%');
                $('#registerForm input[name]').css('display', 'inline-block').css('width', '70%').css('margin-left', '2%');
                $('#registerForm').validator({
                    custom: {
                        serverValidation: function ($el) {
                            // 存储服务器验证错误信息的字典为空，则说明所有输入均合法（或者还没提交表单）
                            var inputFieldName = $el.attr('name');
                            if (inputFieldName in this.serverValidationResult) {
                                var result = this.serverValidationResult[inputFieldName];
                                return result;
                            } else {
                                return false;
                            }
                        }.bind(this)
                    }
                });
            });
        }
    };
</script>
