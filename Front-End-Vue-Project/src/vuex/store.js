import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);

const store = new Vuex.Store({
    state: {
        userName: '',
        caseFilterCondition: {},
        isCaseFilterValid: false
    },
    // 更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
    mutations: {
        setUserName(state, userName) {
            state.userName = userName;
        },
        setCurrSelectedCaseCategory(state, currSelectedCaseCategory) {
            state.currSelectedCaseCategory = currSelectedCaseCategory;
        },
        setCaseFilterCondition(state, caseFilterCondition) {
            state.caseFilterCondition = caseFilterCondition;
        },
        addCaseFilterCondition(state, conditionKey, conditionValue) {
            state.caseFilterCondition[conditionKey] = conditionValue;
        },
        setIsCaseFilterValid(state, isCaseFilterValid) {
            state.isCaseFilterValid = isCaseFilterValid;
        }
    }
});

export default store;
