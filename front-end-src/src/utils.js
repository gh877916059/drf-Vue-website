import $ from 'jquery';

exports.jumpToThisPage = function (path, query) {
    if (query) {
        path = path + '?';
        for (var key in query) {
            path = path + key + '=' + query[key];
        }
    }
    this.$router.push({ path });
};

exports.convertURLtoCompleteFileName = function (url) {
    var urlElementList = url.split('/');
    var fileName = urlElementList[urlElementList.length - 1];
    return fileName;
};

exports.convertURLtoRawFileName = function (url) {
    var fileName = exports.convertURLtoCompleteFileName(url);
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

exports.rangeArray = function (start, end) {
    return Array(end - start + 1).fill(0).map((v, i) => i + start);
};

// 将以base64的图片url数据转换为Blob
exports.convertBase64UrlToBlob = function (urlData) {
    // 去掉url的头，并转换为byte
    var bytes = window.atob(urlData.split(',')[1]);
    // 处理异常,将ascii码小于0的转换为大于0
    var ab = new ArrayBuffer(bytes.length);
    var ia = new Uint8Array(ab);
    for (var i = 0; i < bytes.length; i++) {
        ia[i] = bytes.charCodeAt(i);
    }
    return new Blob([ab], {type: 'image/png'});
};

exports.isTwoObjectsEqual = function (objectA, objectB) {
    if (!objectA && !objectB) {
        return true;
    }
    if (!objectA || !objectB) {
        return false;
    }
    for (var keyA in objectA) {
        if (objectA[keyA] !== objectB[keyA]) {
            return false;
        }
    }
    for (var keyB in objectB) {
        if (objectA[keyB] !== objectB[keyB]) {
            return false;
        }
    }
    return true;
};
