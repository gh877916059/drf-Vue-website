function makeTimeFriendly(timeStr: string): string{
    // 后台Django已经自动帮我们处理好了（去掉了后面的'.000000'）
    if (timeStr.length < 20) {
        timeStr = timeStr + '.000000'; // 重新加回去
    }
    let lastDotIndex: number = timeStr.lastIndexOf('.');
    timeStr = timeStr.substr(0, lastDotIndex);
    let indexOfT:number = timeStr.indexOf('T');
    timeStr = timeStr.substr(0, indexOfT) + ' ' + timeStr.substr(indexOfT + 1);
    return timeStr;
};

export default {
    makeTimeFriendly
};
