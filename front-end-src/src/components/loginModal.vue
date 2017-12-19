<template>
    <form data-toggle="validator" role="form" id="loginForm" class="form-horizontal">

        <div class="form-group has-feedback has-success has-error">
            <label for="loginUsernameInput" class="col-sm-3 control-label"><i class="glyphicon glyphicon-user" aria-hidden="true"></i> 用户名：</label>
            <div class="col-sm-9">
                <input type="text" id="loginUsernameInput" class="form-control" name="username" placeholder="请输入用户名" data-pattern-error="用户名长度不足6位" data-required-error="用户名不可以为空" pattern="^.{6,}$" required data-serverValidation>
                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback"></span>
            </div>
            <div class="help-block with-errors col-sm-12"></div>
        </div>

        <div class="form-group has-feedback has-success has-error">
            <label for="loginPasswordInput" class="col-sm-3 control-label"><i class="glyphicon glyphicon-lock" aria-hidden="true"></i> 密码：</label>
            <div class="col-sm-9">
                <input type="password" id="loginPasswordInput" class="form-control" name="password" placeholder="请输入密码" data-pattern-error="密码长度不足6位" data-required-error="密码不可以为空" pattern="^.{6,}$" required>
                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback"></span>
            </div>
            <div class="help-block with-errors col-sm-12"></div>
        </div>

        <div class="form-group">
            <button class="btn btn-primary btn-block" v-on:click='postLoginData'>登录</button>
        </div>
    </form>
</template>

<script>
    import $ from 'jquery';
    import Utils from '../utils';
    import NetworkCommunication from '../vuex/networkCommunication';
    export default {
        data() {
            return {
                serverValidationResult: {}
            };
        },
        mounted: function () {
            this.$nextTick(function () {
                // 阻止表单的默认提交操作
                $('#loginForm').submit(function (e) {
                    e.preventDefault();
                });
                $('label').css('text-align', 'left');
                $('#loginForm').validator({
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
        },
        methods: {
            postLoginData: function () {
                var errorNum = $('#loginForm').validator('validate').has('.has-error').length;
                if (errorNum > 0) {
                    return;
                }
                var postData = Utils.getFormInput('loginForm');
                this.$axios.post('login/', postData)
                    .then((res) => {
                        NetworkCommunication.setAuthorizationToken(res.data['token']);
                        this.setUserName($('#loginForm input[name="username"]').val());
                        this.$emit('closeLoginModal');
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                        for (var key in errorReasonDict) {
                            this.serverValidationResult[key] = errorReasonDict[key];
                        };
                        $('#loginForm').validator('validate');
                        this.serverValidationResult = {};
                    });
            },
            setUserName: function(userName) {
                this.$store.commit('setUserName', userName);
                window.sessionStorage.userName = userName;
            }
        }
    };
</script>
