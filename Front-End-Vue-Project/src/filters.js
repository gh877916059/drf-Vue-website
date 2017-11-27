// export、import可以有多个，export default仅有一个

exports.makeTimeFriendly = (timeStr) => {
    var lastDotIndex = timeStr.lastIndexOf('.');
    timeStr = timeStr.substr(0, lastDotIndex);
    var indexOfT = timeStr.indexOf('T');
    timeStr = timeStr.substr(0, indexOfT) + ' ' + timeStr.substr(indexOfT + 1);
    return timeStr;
};
