import $ from 'jquery';

exports.jumpToThisPage = function (name, query) {
    this.$router.push({name, query});
};

exports.convertURLtoRawFileName = function (url) {
    var urlElementList = url.split('/');
    var fileName = urlElementList[urlElementList.length - 1];
    var lastDotIndex = fileName.lastIndexOf('.');
    var fileNamePrefix = fileName.substr(0, lastDotIndex);
    var extension = fileName.substr(lastDotIndex);
    var rawFileName = fileNamePrefix.substr(0, fileNamePrefix.length - 20) + extension;
    return rawFileName;
};

exports.getFormInput = function (formId) {
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
