import $ from 'jquery';
import Constants from './constants';

const imgLabelBeginSymbol = '<img';
const imgLabelEndSymbol = '>';
const imgSrcBeginSymbol = 'src="';
const imgSrcEndSymbol = '"';

const extractImgLabel = function (htmlContent) {
    var beginIndex = 0;
    var result = [];
    while (true) {
        var ImgLabelIndex1 = htmlContent.indexOf(imgLabelBeginSymbol, beginIndex);
        if (ImgLabelIndex1 < 0) {
            result.push({content: htmlContent.substr(beginIndex),
                isImg: false});
            break;
        }
        var imgSrcBeginIndex = ImgLabelIndex1 + imgLabelBeginSymbol.length;
        var ImgLabelIndex2 = htmlContent.indexOf(imgLabelEndSymbol, imgSrcBeginIndex);
        result.push({content: htmlContent.substr(beginIndex, ImgLabelIndex1 - beginIndex),
            isImg: false});
        result.push({content: htmlContent.substr(imgSrcBeginIndex, ImgLabelIndex2 - imgSrcBeginIndex),
            isImg: true});
        beginIndex = ImgLabelIndex2 + imgLabelEndSymbol.length;
    }
    return result;
};

const deleteHost = function (imgSrc) {
    if (imgSrc.length > 0) {
        if (imgSrc[0] !== '/') {
            var doubleSlashIndex = imgSrc.indexOf('//');
            if (doubleSlashIndex >= 0) {
                imgSrc = imgSrc.substr(doubleSlashIndex + 2);
            }
            var firstSlashIndex = imgSrc.indexOf('/');
            if (firstSlashIndex < 0) {
                console.log('---存在非法src的img元素---');
            } else {
                imgSrc = imgSrc.substr(firstSlashIndex);
            }
        }
    }
    return imgSrc;
};

const deleteAllHostInImgLabel = function (htmlContent) {
    var segmentationList = extractImgLabel(htmlContent);
    var result = '';
    for (var index in segmentationList) {
        var segmentation = segmentationList[index];
        if (segmentation.isImg) {
            var imgContent = segmentation.content;
            var srcBeginIndex = imgContent.indexOf(imgSrcBeginSymbol) + imgSrcBeginSymbol.length;
            var srcEndIndex = imgContent.indexOf(imgSrcEndSymbol, srcBeginIndex);
            var imgSrc = imgSrcBeginSymbol + deleteHost(imgContent.substr(srcBeginIndex, srcEndIndex - srcBeginIndex)) + imgSrcEndSymbol;
            imgSrc = imgContent.substr(0, srcBeginIndex - imgSrcBeginSymbol.length) + imgSrc + imgContent.substr(srcEndIndex + 1);
            result = result + imgLabelBeginSymbol + imgSrc + imgLabelEndSymbol;
        } else {
            result = result + segmentation.content;
        }
    }
    return result;
};

const completeHost = function (imgSrc) {
    if (imgSrc.length > 0) {
        if (imgSrc[0] === '/') {
            imgSrc = Constants.REQUEST_HOST + imgSrc;
        }
    }
    return imgSrc;
};

const completeAllHostInImgLabel = function (htmlContent) {
    var segmentationList = extractImgLabel(htmlContent);
    var result = '';
    for (var index in segmentationList) {
        var segmentation = segmentationList[index];
        if (segmentation.isImg) {
            var imgContent = segmentation.content;
            var srcBeginIndex = imgContent.indexOf(imgSrcBeginSymbol) + imgSrcBeginSymbol.length;
            var srcEndIndex = imgContent.indexOf(imgSrcEndSymbol, srcBeginIndex);
            var imgSrc = imgSrcBeginSymbol + completeHost(imgContent.substr(srcBeginIndex, srcEndIndex - srcBeginIndex)) + imgSrcEndSymbol;
            imgSrc = imgContent.substr(0, srcBeginIndex - imgSrcBeginSymbol.length) + imgSrc + imgContent.substr(srcEndIndex + 1);
            result = result + imgLabelBeginSymbol + imgSrc + imgLabelEndSymbol;
        } else {
            result = result + segmentation.content;
        }
    }
    return result;
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

const initAllBackgroundImage = function() {
    $('[data-bg-img]').each(function() {
        var attr = $(this).attr('data-bg-img');
        if (typeof attr !== typeof undefined && attr !== false && attr !== '') {
            $(this).css('background-image', 'url(' + attr + ')');
        }
    });
};

export default {
    convertURLtoCompleteFileName,
    convertURLtoRawFileName,
    getFormInput,
    rangeArray,
    convertBase64UrlToBlob,
    isTwoObjectsEqual,
    initAllBackgroundImage,
    deleteAllHostInImgLabel,
    completeAllHostInImgLabel,
    deleteHost,
    completeHost
};
