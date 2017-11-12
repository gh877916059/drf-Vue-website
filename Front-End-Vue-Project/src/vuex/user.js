import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

const userStore = new Vuex.Store({
    state: {
        userInfo: {}
    },
    getters: {
        getUserInfo(state) {
            return state.userInfo;
        }
    },
    // 更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
    mutations: {
        setUserInfo(state, userInfo) {
            state.userInfo = userInfo;
        }
    },
    /*
     Action 类似于 mutation，不同在于：①Action提交的是mutation，而不是直接变更状态；②Action可以包含任意异步操作
     Action 函数接受一个与store 实例具有相同方法和属性的context对象，因此你可以调用context.commit提交一个mutation
     或者通过context.state和context.getters来获取state和getters。但是context 对象并不是store实例本身
    */
    actions: {
        // {commit}这种写法属于ES6新特性，属于对象的解构赋值，得到的commit相当于context.commit
        setUserInfo({ commit }, user) {
            // user为mutation的载荷（payload），这里会引发setUserInfo(state, user)这个mutation
            commit('setUserInfo', user);
        }
    }
});

export default userStore;
