import $ from 'jquery';

const jumpToThisPage = function (path, query) {
    if (query) {
        path = path + '?';
        for (var key in query) {
            path = path + key + '=' + query[key];
        }
    }
    this.$router.push({ path });
};

const convertURLtoCompleteFileName = function (url) {
    var urlElementList = url.split('/');
    var fileName = urlElementList[urlElementList.length - 1];
    return fileName;
};

const convertURLtoRawFileName = function (url) {
    var fileName = convertURLtoCompleteFileName(url);
    var lastDotIndex = fileName.lastIndexOf('.');
    var fileNamePrefix = fileName.substr(0, lastDotIndex);
    var extension = fileName.substr(lastDotIndex);
    var rawFileName = fileNamePrefix.substr(0, fileNamePrefix.length - 20) + extension;
    return rawFileName;
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

const rangeArray = function (start, end) {
    return Array(end - start + 1).fill(0).map((v, i) => i + start);
};

// 将以base64的图片url数据转换为Blob
const convertBase64UrlToBlob = function (urlData) {
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

const isTwoObjectsEqual = function (objectA, objectB) {
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

const requestList = function (vuexState) {
    var self = vuexState.listComponent;
    if (!self) {
        return;
    }
    var requestUrl = self.requestUrl + '?';
    requestUrl = requestUrl + 'page' + '=' + vuexState.currPageNum + '&';
    requestUrl = requestUrl + 'page_size' + '=' + vuexState.currPageSize + '&';
    for (var key in vuexState.filterCondition) {
        requestUrl = requestUrl + key + '=' + vuexState.filterCondition[key] + '&';
    }
    requestUrl = requestUrl.slice(0, -1);
    if (requestUrl === vuexState.lastRequestUrl) {
        return;
    }
    console.log('---requestUrl---');
    console.log(requestUrl);
    vuexState.lastRequestUrl = requestUrl;
    self.$axios.get(requestUrl)
        .then((res) => {
            vuexState.listComponent.previousPageUrl = res.data['previous'];
            vuexState.listComponent.nextPageUrl = res.data['next'];
            vuexState.listComponent.sumPageNum = Math.ceil(res.data['count'] / vuexState.currPageSize);
            self.setOutlineList(res.data.results);
        }, (err) => {
            var errorReasonDict = err.body;
            console.log('---errorReasonDict---');
            console.log(errorReasonDict);
        });
};

export default {
    jumpToThisPage,
    convertURLtoCompleteFileName,
    convertURLtoRawFileName,
    getFormInput,
    rangeArray,
    convertBase64UrlToBlob,
    isTwoObjectsEqual,
    requestList
};
