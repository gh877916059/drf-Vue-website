import Vuex from 'vuex';
import NetworkCommunication from './networkCommunication';
import Constants from '../constants';
import {Vue} from "vue-property-decorator";
import {KeyValueDict, CaseCategory} from '../commonType';
Vue.use(Vuex);

class VuexState {
    userName: string = '';
    listComponent: Vue|null = null;
    currPageNum: number = 1;
    currPageSize: number = Constants.PAGE_SIZE;
    filterCondition: KeyValueDict = {};
    lastRequestUrl: string = '';
    categoryList: CaseCategory[]|null = null;
    requestAfterListComponentInitialized: boolean = false;
}

let state: VuexState = new VuexState();

function requestListOrDelay(state: VuexState) {
    if (!state.listComponent) {
        state.requestAfterListComponentInitialized = true;
    } else {
        state.listComponent.$nextTick(function () {
            NetworkCommunication.requestListInfo(state);
        });
    }
}

const store = new Vuex.Store({
    state: state,
    // 更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
    mutations: {
        setUserName(state: VuexState, userName: string) {
            state.userName = userName;
            window.sessionStorage.userName = userName;
        },
        setListComponent(state: VuexState, listComponent: Vue|null) {
            state.lastRequestUrl = '';
            state.listComponent = listComponent;
            if (state.requestAfterListComponentInitialized) {
                NetworkCommunication.requestListInfo(state);
                state.requestAfterListComponentInitialized = false;
            }
        },
        setFilterCondition(state: VuexState, filterCondition: KeyValueDict) {
            state.filterCondition = filterCondition;
            requestListOrDelay(state);
        },
        setCurrPageNum(stateL: VuexState, currPageNum: number) {
            state.currPageNum = currPageNum;
            requestListOrDelay(state);
        },
        setCurrPageSize(state: VuexState, currPageSize: number) {
            state.currPageSize = currPageSize;
            requestListOrDelay(state);
        },
        resetFilterCondition(state: VuexState) {
            state.filterCondition = {};
            state.lastRequestUrl = '';
        },
        setCategoryList(state: VuexState, categoryList: CaseCategory[]) {
            state.categoryList = categoryList;
        }
    }
});

export default store;
