import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import Utils from '../utils';
import Constants from '../constants';
const store = new Vuex.Store({
    state: {
        userName: '',
        listComponent: null,
        currPageNum: 1,
        currPageSize: Constants.PAGE_SIZE,
        filterCondition: {},
        lastRequestUrl: ''
    },
    // 更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
    mutations: {
        setUserName(state, userName) {
            state.userName = userName;
        },
        setListComponent(state, listComponent) {
            state.lastRequestUrl = '';
            state.listComponent = listComponent;
        },
        setFilterCondition(state, filterCondition) {
            state.filterCondition = filterCondition;
            state.listComponent.$nextTick(function () {
                Utils.requestList(state);
            });
        },
        setCurrPageNum(state, currPageNum) {
            state.currPageNum = currPageNum;
            state.listComponent.$nextTick(function () {
                Utils.requestList(state);
            });
        },
        setCurrPageSize(state, currPageSize) {
            state.currPageSize = currPageSize;
            state.listComponent.$nextTick(function () {
                Utils.requestList(state);
            });
        },
        resetFilterCondition(state) {
            state.filterCondition = {};
            state.lastRequestUrl = '';
        }
    }
});

export default store;
