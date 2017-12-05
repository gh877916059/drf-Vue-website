import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import Utils from '../utils';

const store = new Vuex.Store({
    state: {
        userName: '',
        caseFilterCondition: {},
        forcedRequestCounter: 0, // 用于在caseFilterCondition不变的情况下，强制进行数据请求
        currPageNum: 1,
        caseCountPerPage: 1,
        pageNumToShowList: [1],
        nextPageUrl: null,
        previousPageUrl: null
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
            state.forcedRequestCounter = state.forcedRequestCounter + 1;
        },
        setCurrPageNum(state, currPageNum) {
            state.currPageNum = currPageNum;
        },
        setPageListByCount(state, count) {
            var sumPageNum = Math.ceil(count / state.caseCountPerPage);
            state.pageNumToShowList = Utils.rangeArray(1, sumPageNum);
        },
        setNextPageUrl(state, nextPageUrl) {
            state.nextPageUrl = nextPageUrl;
        },
        setPreviousPageUrl(state, previousPageUrl) {
            state.previousPageUrl = previousPageUrl;
        },
        setCaseCountPerPage(state, caseCountPerPage) {
            state.caseCountPerPage = caseCountPerPage;
        }
    }
});

export default store;
