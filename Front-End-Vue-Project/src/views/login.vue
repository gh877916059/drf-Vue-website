<template>
    <!-- 取消H5的默认表单验证功能，以免与Foundation的Abide发生冲突 -->
    <form data-abide novalidate>
        <div class="row form-icons">
            <h4>登录</h4>
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
                    <i class="fi fi-key"></i>
                </span>
                <input class="input-group-field" type="password" name="password" id="Password" placeholder="请输入密码"
                       required pattern="not-shorter-than-six">
                <label>
                    <span class="form-error">密码长度不足6位</span>
                </label>
            </div>

        </div>
        <button class="button expanded">登录</button>
    </form>
</template>

<script>
    import $ from 'jquery';

    export default {
        mounted: function () {
            this.$nextTick(function () {
                // 添加自定义Pattern
                window.Foundation.Abide.defaults.patterns['not-shorter-than-six'] = /^.{6,}$/;
                // 使得Foundation框架生效所必须的操作
                $(document).foundation();
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
