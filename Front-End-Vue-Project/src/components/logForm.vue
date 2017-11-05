<template>
  <div class="login-form">
    <div class="g-form">
      <div class="g-form-line">
        <span class="g-form-label">用户名：</span>
        <div class="g-form-input">
          <input type="text"
                 v-model="usernameModel" placeholder="请输入用户名">
        </div>
        <span class="g-form-error">{{ usernameErrorText }}</span>
      </div>
      <div class="g-form-line">
        <span class="g-form-label">密码：</span>
        <div class="g-form-input">
          <input type="password"
                 v-model="passwordModel" placeholder="请输入密码">
        </div>
        <span class="g-form-error">{{ passwordErrorText }}</span>
      </div>
      <div class="g-form-line">
        <span class="g-form-error">{{ ResponseErrorText }}</span>
      </div>
      <div class="g-form-line">
        <div class="g-form-btn">
          <a class="button" @click="onLogin">登录</a>
        </div>
      </div>
      <p>{{ errorText }}</p>
    </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        usernameModel: '',
        passwordModel: '',
        usernameErrorText: '',
        passwordErrorText: '',
        ResponseErrorText: ''
      }
    },
    methods: {
      onLogin() {
        let [status, errorText] = this.$root.checkUsername(this.usernameModel);
        if (!status) {
          this.usernameErrorText = errorText;
          return;
        }
        else
        {
          this.usernameErrorText = "";
        }
        [status, errorText] = this.$root.checkPassword(this.passwordModel);
        if (!status) {
          this.passwordErrorText = errorText;
          return;
        }
        else
        {
          this.passwordErrorText = "";
        }
        let reqParams = {
          username: this.usernameModel,
          password: this.passwordModel,
        };
        this.$http.post(this.$root.$data.request_host + '/login/', reqParams)
          .then((res) => {
            console.log("----res.data----");
            console.dir(res.data);
            this.$emit('has-log', res.data)
          }, (err) => {
            console.log("----err----");
            console.log("????");
            console.log(err);
            this.ResponseErrorText = '网络请求错误';
          })
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
