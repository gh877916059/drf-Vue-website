export default {
  checkUsername (user_name) {
    let errorText, status;
    // /g 表示该表达式将用来在输入字符串中查找所有可能的匹配，返回的结果可以是多个。如果不加/g最多只会匹配一个
    if (!/@/g.test(user_name)) {
      status = false;
      errorText = '不包含@';
    }
    else {
      status = true;
      errorText = '';
    }
    return [status, errorText];
  },
  checkPassword (password) {
    let errorText, status;
    if (password.length<6) {
      status = false;
      errorText = '密码少于6位';
    }
    else {
      status = true;
      errorText = '';
    }
    return [status, errorText];
  }
}
