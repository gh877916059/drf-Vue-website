import Utils from './utils'

let [status, errorText] = Utils.checkPassword("8731");
console.log("----status---：", status);
console.log("----errorText---：", errorText);
