import $ from 'jquery';

const jumpToThisPage = function (name, query) {
    this.$router.push({name, query});
};

const getFormInput = function (formId) {
    var postData = {};
    var fieldArray = $('#' + formId).serializeArray();
    $.each(fieldArray, function (i, field) {
        postData[field.name] = field.value;
    });
    console.log('---请求来自' + formId + '---');
    console.log('---数据序列化为---');
    console.log(postData);
    return postData;
};

export default {jumpToThisPage, getFormInput};
