import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

const userStore = new Vuex.Store({
    state: {
        userName: ''
    },
    // 更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
    mutations: {
        setUserName(state, userName) {
            state.userName = userName;
        }
    }
});

export default userStore;
