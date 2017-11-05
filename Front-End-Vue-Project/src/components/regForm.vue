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
          <input type="text"
                 v-model="passwordModel" placeholder="请输入密码">
        </div>
        <span class="g-form-error">{{ passwordErrorText }}</span>
      </div>
      <div class="g-form-line">
        <span class="g-form-label">验证码：</span>
        <div class="g-form-input">
          <input type="text"
                 v-model="AuthenticodeModel" placeholder="请输入验证码">
        </div>
        <span class="g-form-error">{{ AuthenticodeErrorText }}</span>
      </div>
      <img width="100" height="30" v-bind:src="imageSrc" />
      <div class="g-form-line">
        <span class="g-form-error">{{ ResponseErrorText }}</span>
      </div>
      <div class="g-form-line">
        <div class="g-form-btn">
          <a class="button" @click="onRegister">注册</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    // 父组件的数据需要通过props才能下发到子组件中，子组件要显式地用props选项声明它预期的数据
    props: {
      'isShow': 'boolean'
    },
    data() {
      return {
        imageSrc: 'data:image/png;base64,',
        authentiCode: '',
        usernameModel: '',
        passwordModel: '',
        AuthenticodeModel:'',
        usernameErrorText: '',
        passwordErrorText: '',
        AuthenticodeErrorText: '',
        ResponseErrorText: ''
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.$http.get(this.$root.$data.request_host + '/picturecodes/')
          .then((res) => {
            console.log("----res.data----");
            console.dir(res.data);
            this.authentiCode = res.data.code;
            this.imageSrc = 'data:image/png;base64,'+ res.data.data_url;
          }, (err) => {
            console.log("----err----");
            console.log(err);
            this.ResponseErrorText = '网络请求错误';
          });
      })
    },
    methods: {
      onRegister() {
        let [status, errorText] = this.$root.checkUsername(this.usernameModel);
        if (!status) {
          this.usernameErrorText = errorText;
          return;
        }
        else {
          this.usernameErrorText = "";
        }
        [status, errorText] = this.$root.checkPassword(this.passwordModel);
        if (!status) {
          this.passwordErrorText = errorText;
          return;
        }
        else {
          this.passwordErrorText = "";
        }
        let reqParams = {
          username: this.usernameModel,
          password: this.passwordModel,
        };
        this.$http.post(this.$root.$data.request_host + '/users/', reqParams)
          .then((res) => {
            console.log("----res.data----");
            console.dir(res.data);
          }, (err) => {
            console.log("----err----");
            console.log(err);
            this.ResponseErrorText = '网络请求错误';
          });
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .dialog-wrap {
    position: fixed;
    width: 100%;
    height: 100%;
  }

  .dialog-cover {
    background: #000;
    opacity: .3;
    position: fixed;
    z-index: 5;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }

  .dialog-content {
    width: 50%;
    position: fixed;
    max-height: 50%;
    overflow: auto;
    background: #fff;
    top: 20%;
    left: 50%;
    margin-left: -25%;
    z-index: 10;
    border: 2px solid #464068;
    padding: 2%;
    line-height: 1.6;
  }

  .dialog-close {
    position: absolute;
    right: 5px;
    top: 5px;
    width: 20px;
    height: 20px;
    text-align: center;
    cursor: pointer;
  }

  .dialog-close:hover {
    color: #4fc08d;
  }
</style>
