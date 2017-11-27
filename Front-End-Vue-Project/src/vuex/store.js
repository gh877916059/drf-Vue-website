import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

const store = new Vuex.Store({
    state: {
        userName: '',
        caseFilterCondition: {},
        ForcedRequestCounter: 0 // 用于在caseFilterCondition不变的情况下，强制进行数据请求
    },
    // 更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
    mutations: {
        setUserName(state, userName) {
            state.userName = userName;
        },
        setCaseFilterCondition(state, caseFilterCondition) {
            state.caseFilterCondition = caseFilterCondition;
        },
        addCaseFilterCondition(state, conditionKey, conditionValue) {
            state.caseFilterCondition[conditionKey] = conditionValue;
        },
        increaseForcedRequestCounter(state) {
            state.ForcedRequestCounter = state.ForcedRequestCounter + 1;
        }
    }
});

export default store;
