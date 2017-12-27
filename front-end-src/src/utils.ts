import $ from 'jquery';
import JQuery from 'jquery/dist/jquery.slim';
import {KeyValueDict} from './commonType';
import Constants from './constants';
const imgLabelBeginSymbol: string = '<img';
const imgLabelEndSymbol: string = '>';
const imgSrcBeginSymbol: string = 'src="';
const imgSrcEndSymbol: string = '"';

interface htmlLabelSegmentation {
    content: string;
    isImg: boolean;
}

function extractImgLabel(htmlContent: string): htmlLabelSegmentation[]{
    let beginIndex: number = 0;
    let result: htmlLabelSegmentation[] = [];
    while (true) {
        let ImgLabelBeginIndex: number = htmlContent.indexOf(imgLabelBeginSymbol, beginIndex);
        if (ImgLabelBeginIndex < 0) {
            result.push({content: htmlContent.substr(beginIndex),
                isImg: false});
            break;
        }
        let imgAttrBeginIndex: number = ImgLabelBeginIndex + imgLabelBeginSymbol.length;
        let ImgLabelEndIndex: number = htmlContent.indexOf(imgLabelEndSymbol, imgAttrBeginIndex);
        result.push({content: htmlContent.substr(beginIndex, ImgLabelBeginIndex - beginIndex),
            isImg: false});
        result.push({content: htmlContent.substr(imgAttrBeginIndex, ImgLabelEndIndex - imgAttrBeginIndex),
            isImg: true});
        beginIndex = ImgLabelEndIndex + imgLabelEndSymbol.length;
    }
    return result;
};

function deleteHost(imgSrc: string): string{
    if (imgSrc.length > 0) {
        if (imgSrc[0] !== '/') {
            let doubleSlashIndex: number = imgSrc.indexOf('//');
            if (doubleSlashIndex >= 0) {
                imgSrc = imgSrc.substr(doubleSlashIndex + 2);
            }
            let firstSlashIndex: number = imgSrc.indexOf('/');
            if (firstSlashIndex < 0) {
                console.log('---存在非法src的img元素---');
            } else {
                imgSrc = imgSrc.substr(firstSlashIndex);
            }
        }
    }
    return imgSrc;
};

function deleteAllHostInImgLabel(htmlContent: string): string{
    let segmentationList: htmlLabelSegmentation[] = extractImgLabel(htmlContent);
    let result: string = '';
    for (let segmentation of segmentationList) {
        if (segmentation.isImg) {
            let imgContent: string = segmentation.content;
            let srcBeginIndex: number = imgContent.indexOf(imgSrcBeginSymbol) + imgSrcBeginSymbol.length;
            let srcEndIndex: number = imgContent.indexOf(imgSrcEndSymbol, srcBeginIndex);
            let imgSrc: string = imgSrcBeginSymbol + deleteHost(imgContent.substr(srcBeginIndex, srcEndIndex - srcBeginIndex)) + imgSrcEndSymbol;
            let imgAttr: string = imgContent.substr(0, srcBeginIndex - imgSrcBeginSymbol.length) + imgSrc + imgContent.substr(srcEndIndex + 1);
            result = result + imgLabelBeginSymbol + imgAttr + imgLabelEndSymbol;
        } else {
            result = result + segmentation.content;
        }
    }
    return result;
};

function completeHost(imgSrc: string): string{
    if (imgSrc.length > 0) {
        if (imgSrc[0] === '/') {
            imgSrc = Constants.REQUEST_HOST + imgSrc;
        }
    }
    return imgSrc;
};

function completeAllHostInImgLabel(htmlContent: string): string{
    let segmentationList: htmlLabelSegmentation[] = extractImgLabel(htmlContent);
    let result: string = '';
    for (let segmentation of segmentationList) {
        if (segmentation.isImg) {
            let imgContent: string = segmentation.content;
            let srcBeginIndex: number = imgContent.indexOf(imgSrcBeginSymbol) + imgSrcBeginSymbol.length;
            let srcEndIndex: number = imgContent.indexOf(imgSrcEndSymbol, srcBeginIndex);
            let imgSrc: string = imgSrcBeginSymbol + completeHost(imgContent.substr(srcBeginIndex, srcEndIndex - srcBeginIndex)) + imgSrcEndSymbol;
            let imgAttr: string = imgContent.substr(0, srcBeginIndex - imgSrcBeginSymbol.length) + imgSrc + imgContent.substr(srcEndIndex + 1);
            result = result + imgLabelBeginSymbol + imgAttr + imgLabelEndSymbol;
        } else {
            result = result + segmentation.content;
        }
    }
    return result;
};

function convertURLtoCompleteFileName(url: string): string{
    let urlElementList: string[] = url.split('/');
    return urlElementList[urlElementList.length - 1];
};

function convertURLtoRawFileName(url: string): string{
    let fileName: string = convertURLtoCompleteFileName(url);
    let lastDotIndex: number = fileName.lastIndexOf('.');
    let fileNamePrefix: string = fileName.substr(0, lastDotIndex);
    let extension: string = fileName.substr(lastDotIndex);
    return fileNamePrefix.substr(0, fileNamePrefix.length - 20) + extension;
};

function getFormInput(formId: string): KeyValueDict{
    let postData: KeyValueDict = {};
    let fieldArray: JQuery.NameValuePair[] = $('#' + formId).serializeArray();
    $.each(fieldArray, function (i: number, field) {
        postData[field.name] = field.value;
    });
    console.log('---请求来自' + formId + '---');
    console.log('---数据序列化为---');
    console.log(postData);
    return postData;
};

function rangeArray(start: number, end: number): number[]{
    return Array(end - start + 1).fill(0).map((v, i: number) => i + start);
};

// 将以base64的图片url数据转换为Blob
function convertBase64UrlToBlob(urlData: string): Blob{
    // 去掉url的头，并转换为原始字符串（进行base64解码）
    let bytes: string = window.atob(urlData.split(',')[1]);
    // 处理异常,将ascii码小于0的转换为大于0
    let ab: ArrayBuffer = new ArrayBuffer(bytes.length);
    let ia: Uint8Array = new Uint8Array(ab);
    for (let i: number = 0; i < bytes.length; i++) {
        ia[i] = bytes.charCodeAt(i);
    }
    return new Blob([ab], {type: 'image/png'});
};

function initAllBackgroundImage(): void{
    $('[data-bg-img]').each(function(this: HTMLElement) {
        let jqueryElement: JQuery<HTMLElement> = $(this);
        let backgroundImageData: string|undefined = jqueryElement.data('bg-img');
        if (backgroundImageData && backgroundImageData !== '') {
            jqueryElement.css('background-image', 'url(' + backgroundImageData + ')');
        }
    });
};

export default {
    convertURLtoCompleteFileName,
    convertURLtoRawFileName,
    getFormInput,
    rangeArray,
    convertBase64UrlToBlob,
    initAllBackgroundImage,
    deleteAllHostInImgLabel,
    completeAllHostInImgLabel,
    deleteHost,
    completeHost
};
