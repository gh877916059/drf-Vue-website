<template>
    <form data-toggle="validator" role="form" id="registerForm" class="form-horizontal">

        <div class="form-group has-feedback has-success has-error">
            <label for="usernameInput" class="col-sm-3 control-label"><i class="glyphicon glyphicon-user" aria-hidden="true"></i> 用户名：</label>
            <div class="col-sm-9">
                <input type="text" id="usernameInput" class="form-control" name="username" placeholder="请输入用户名" data-pattern-error="用户名长度不足6位" data-required-error="用户名不可以为空" pattern="^.{6,}$" required data-serverValidation>
                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
            </div>
            <div class="help-block with-errors col-sm-12"></div>
        </div>

        <div class="form-group has-feedback has-success has-error">
            <label for="emailInput" class="col-sm-3 control-label"><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i> 电子邮箱：</label>
            <div class="col-sm-9">
                <input type="email" id="emailInput" class="form-control" name="email" placeholder="请输入邮箱地址" data-error="邮箱地址格式非法" required>
                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback"></span>
            </div>
            <div class="help-block with-errors col-sm-12"></div>
        </div>

        <div class="form-group has-feedback has-success has-error">
            <label for="mobileInput" class="col-sm-3 control-label"><i class="glyphicon glyphicon-phone" aria-hidden="true"></i> 手机号码：</label>
            <div class="col-sm-9">
                <input type="text" id="mobileInput" class="form-control" name="mobile" placeholder="(非必填）请输入手机号码" data-pattern-error="手机号码格式错误" pattern="^1[34578]\d{9}$">
                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback"></span>
            </div>
            <div class="help-block with-errors col-sm-12"></div>
        </div>

        <div class="form-group has-feedback has-success has-error">
            <label for="passwordInput" class="col-sm-3 control-label"><i class="glyphicon glyphicon-lock" aria-hidden="true"></i> 密码：</label>
            <div class="col-sm-9">
                <input type="password" id="passwordInput" class="form-control" name="password" placeholder="请输入密码" data-pattern-error="密码长度不足6位" data-required-error="密码不可以为空" pattern="^.{6,}$" required>
                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback"></span>
            </div>
            <div class="help-block with-errors col-sm-12"></div>
        </div>

        <div class="form-group has-feedback has-success has-error">
            <label for="repeatedPasswordInput" class="col-sm-3 control-label"><i class="glyphicon glyphicon-lock" aria-hidden="true"></i> 重复密码：</label>
            <div class="col-sm-9">
                <input type="password" id="repeatedPasswordInput" class="form-control" name="repeated_password" placeholder="请重复上面所输入的密码" data-match-error="两次输入的密码不一样" data-required-error="必须重复上面的密码" data-match="#passwordInput" required>
                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback"></span>
            </div>
            <div class="help-block with-errors col-sm-12"></div>
        </div>

        <div class="form-group has-feedback has-success has-error">
            <label class="col-sm-3"><img v-bind:src="pictureCodeSrc" style="cursor: pointer" v-on:click='requestForPictureCode'></label>
            <div class="col-sm-9">
                <input type="text" id="captchaCodeInput" class="form-control" name="code" placeholder="请输入图片验证码" data-pattern-error="验证码的长度必须为4位" data-required-error="验证码不可以为空" pattern="^.{4,4}$" required data-serverValidation>
                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback"></span>
            </div>
            <div class="help-block with-errors col-sm-12"></div>
        </div>

        <div class="form-group">
            <input type="hidden" name="picture_token" v-bind:value="pictureToken"/>
        </div>

        <div class="form-group">
            <button class="btn btn-primary btn-block" v-on:click='postRegisterData'>注册</button>
        </div>
    </form>
</template>

<script lang="ts">
    import $ from 'jquery';
    import JQuery from 'jquery/dist/jquery.slim';
    import Constants from '../constants';
    import Utils from '../utils';
    import NetworkCommunication from '../vuex/networkCommunication';
    import {Component, Vue} from 'vue-property-decorator';
    import {Mutation} from 'vuex-class';
    import {Dict} from '../commonType';
    import axios from 'axios';

    @Component
    export default class registerModal extends Vue{
        pictureCodeSrc: string = '';
        pictureToken: string = '';
        serverValidationResult: Dict = {};
        $registerForm: JQuery<HTMLElement>|null = null;
        $captchaCodeInput: JQuery<HTMLElement>|null = null;
        @Mutation('setUserName') mutationSetUserName;
        mounted(): void{
            this.$nextTick(function(this: registerModal) {
                this.$registerForm = $('#registerForm');
                this.$captchaCodeInput = $('#captchaCodeInput');
                // 阻止表单的默认提交操作
                this.$registerForm.submit(function (e) {
                    e.preventDefault();
                });
                $('label').css('text-align', 'left');
                this.$registerForm.validator({
                    custom: {
                        serverValidation: function (this: registerModal, $el) {
                            // 存储服务器验证错误信息的字典为空，则说明所有输入均合法（或者还没提交表单）
                            let inputFieldName: string = $el.attr('name');
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
        postRegisterData(): void{
            if(this.$registerForm) {
                let errorNum: number = this.$registerForm.validator('validate').has('.has-error').length;
                if (errorNum > 0) {
                    return;
                }
                let postData: Dict = Utils.getFormInput('registerForm');
                axios.post('users/', postData)
                    .then((res) => {
                        NetworkCommunication.setAuthorizationToken(res.data['jwt_token']);
                        this.mutationSetUserName(postData['username']);
                        this.$emit('closeRegisterModal');
                    }, (err) => {
                        let errorReasonDict: Dict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                        for (let key in errorReasonDict) {
                            if (key === 'non_field_errors') {
                                let reason: string = errorReasonDict[key][0];
                                if (reason.indexOf('令牌') === -1) {
                                    this.serverValidationResult['code'] = errorReasonDict[key];
                                }
                                this.requestForPictureCode();
                            } else if (key === 'picture_token') {
                                this.requestForPictureCode();
                            } else {
                                this.serverValidationResult[key] = errorReasonDict[key];
                            }
                        }
                        if(this.$registerForm) {
                            this.$registerForm.validator('validate');
                        }
                        this.serverValidationResult = {};
                    });
            }
        }
        // 请求图片验证码
        requestForPictureCode(): void{
            axios.get('picturecodes/')
                .then((res) => {
                    this.pictureCodeSrc = Constants.REQUEST_HOST + res.data['cptch_image'];
                    this.pictureToken = res.data['cptch_key'];
                    if(this.$captchaCodeInput) {
                        this.$captchaCodeInput.val('');
                    }
                }, (err) => {
                    console.log('图片验证码请求错误');
                    console.log(err);
                });
        }
    };
</script>
<style>
    form {
        padding-right: 15px;
        padding-left: 15px;
    }
</style>
