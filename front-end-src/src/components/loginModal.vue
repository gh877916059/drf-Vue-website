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

<script lang="ts">
    import $ from 'jquery';
    import JQuery from 'jquery/dist/jquery.slim';
    import Utils from '../utils';
    import NetworkCommunication from '../vuex/networkCommunication';
    import axios from 'axios';
    import {Component, Vue} from 'vue-property-decorator';
    import {Mutation} from 'vuex-class';
    import {Dict} from '../commonType';
    @Component
    export default class loginModal extends Vue{
        serverValidationResult: Dict = {};
        $loginForm: JQuery<HTMLElement>|null = null;
        @Mutation('setUserName') mutationSetUserName;
        mounted(): void{
            this.$nextTick(function (this: loginModal) {
                this.$loginForm = $('#loginForm');
                // 阻止表单的默认提交操作
                this.$loginForm.submit(function (e) {
                    e.preventDefault();
                });
                $('label').css('text-align', 'left');
                this.$loginForm.validator({
                    custom: {
                        serverValidation: function (this: loginModal, $el) {
                            // 存储服务器验证错误信息的字典为空，则说明所有输入均合法（或者还没提交表单）
                            let inputFieldName: string = $el.attr('name') || '';
                            if (inputFieldName in this.serverValidationResult) {
                                return this.serverValidationResult[inputFieldName];
                            } else {
                                return false;
                            }
                        }.bind(this)
                    }
                });
            }.bind(this));
        }
        postLoginData(): void{
            if(this.$loginForm) {
                let errorNum: number = this.$loginForm.validator('validate').has('.has-error').length;
                if (errorNum > 0) {
                    return;
                }
                let postData = Utils.getFormInput('loginForm');
                axios.post('login/', postData)
                    .then((res) => {
                        NetworkCommunication.setAuthorizationToken(res.data['token']);
                        this.mutationSetUserName(postData['username']);
                        this.$emit('closeLoginModal');
                    }, (err) => {
                        let errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                        for (let key in errorReasonDict) {
                            this.serverValidationResult[key] = errorReasonDict[key];
                        }
                        if(this.$loginForm) {
                            this.$loginForm.validator('validate');
                        }
                        this.serverValidationResult = {};
                    });
            }
        }
    };
</script>
