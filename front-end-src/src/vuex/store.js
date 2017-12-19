import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import NetworkCommunication from './networkCommunication';
import Constants from '../constants';

const requestListOrDelay = function (state) {
    if (!state.listComponent) {
        state.requestAfterListComponentInitialized = true;
    } else {
        state.listComponent.$nextTick(function () {
            NetworkCommunication.requestListInfo(state);
        });
    }
};
const store = new Vuex.Store({
    state: {
        userName: '',
        listComponent: null,
        currPageNum: 1,
        currPageSize: Constants.PAGE_SIZE,
        filterCondition: {},
        lastRequestUrl: '',
        categoryList: null,
        requestAfterListComponentInitialized: false
    },
    // 更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
    mutations: {
        setUserName(state, userName) {
            state.userName = userName;
            window.sessionStorage.userName = userName;
        },
        setListComponent(state, listComponent) {
            state.lastRequestUrl = '';
            state.listComponent = listComponent;
            if (state.requestAfterListComponentInitialized) {
                NetworkCommunication.requestListInfo(state);
                state.requestAfterListComponentInitialized = false;
            }
        },
        setFilterCondition(state, filterCondition) {
            state.filterCondition = filterCondition;
            requestListOrDelay(state);
        },
        setCurrPageNum(state, currPageNum) {
            state.currPageNum = currPageNum;
            requestListOrDelay(state);
        },
        setCurrPageSize(state, currPageSize) {
            state.currPageSize = currPageSize;
            requestListOrDelay(state);
        },
        resetFilterCondition(state) {
            state.filterCondition = {};
            state.lastRequestUrl = '';
        },
        setCategoryList(state, categoryList) {
            state.categoryList = categoryList;
        }
    }
});

export default store;
