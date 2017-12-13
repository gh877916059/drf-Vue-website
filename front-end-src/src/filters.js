// export、import可以有多个，export default仅有一个

exports.makeTimeFriendly = (timeStr) => {
    // 后台Django已经自动帮我们处理好了（去掉了后面的'.000000'）
    if (timeStr.length < 20) {
        timeStr = timeStr + '.000000'; // 重新加回去
    }
    var lastDotIndex = timeStr.lastIndexOf('.');
    timeStr = timeStr.substr(0, lastDotIndex);
    var indexOfT = timeStr.indexOf('T');
    timeStr = timeStr.substr(0, indexOfT) + ' ' + timeStr.substr(indexOfT + 1);
    return timeStr;
};
