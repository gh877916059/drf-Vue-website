import Vue from 'vue';
import $ from 'jquery';

/**
 * 全局注册弱提示
 */
export default {
    install() {
        let timer = null;
        // 直接替换掉Vue的$alert方法
        Vue.prototype.$alert = (msg) => {
            $('#alertWeek').remove();   // 按ID查找DOM节点，如果上次添加的alert节点还没被定时器销毁，则在这里手动销毁
            let $alert = $('<div class="week-alert" id="alertWeek"></div>');    // 重新把DOM包装为jQuery对象
            $('body').append($alert);   // 插入DOM节点，让警告得以显示
            $alert.html(msg);   // <div></div>标签对内部的内容
            $alert.addClass('alert-show');  // 增加class="***"的取值
            clearTimeout(timer);
            timer = setTimeout(() => {
                $alert.remove();
            }, 2000);
        };
    }
};
