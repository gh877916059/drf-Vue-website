import Vue from 'vue';
import Vuex from 'vuex';
Vue.use(Vuex);
import Utils from '../utils';

const store = new Vuex.Store({
    state: {
        userName: '',
        caseFilterCondition: {
            page_size: 1,
            page: 1
        },
        lastCaseFilterCondition: null,
        caseListComponent: null,
        pageNumToShowList: [],
        nextPageUrl: null,
        previousPageUrl: null,
        questionListComponent: null
    },
    // 更改 Vuex 的 store 中的状态的唯一方法是提交 mutation
    mutations: {
        setUserName(state, userName) {
            state.userName = userName;
        },
        setCaseListComponent(state, caseListComponent) {
            state.lastCaseFilterCondition = null;
            state.caseListComponent = caseListComponent;
        },
        setCaseFilterCondition(state, caseFilterCondition) {
            if (Utils.isTwoObjectsEqual(caseFilterCondition, state.lastCaseFilterCondition)) {
                return;
            }
            var self = state.caseListComponent;
            state.caseFilterCondition = caseFilterCondition;
            var requestURL = 'cases/?';
            for (var key in caseFilterCondition) {
                requestURL = requestURL + key + '=' + caseFilterCondition[key] + '&';
            }
            requestURL = requestURL.slice(0, -1);
            console.log('---requestURL---');
            console.log(requestURL);
            state.lastCaseFilterCondition = caseFilterCondition;
            self.$axios.get(requestURL)
                .then((res) => {
                    if (state.caseFilterCondition['page_size']) {
                        state.previousPageUrl = res.data['previous'];
                        state.nextPageUrl = res.data['next'];
                        var sumPageNum = Math.ceil(res.data['count'] / state.caseFilterCondition['page_size']);
                        state.pageNumToShowList = Utils.rangeArray(1, sumPageNum);
                    } else {
                        state.pageNumToShowList = [];
                        state.nextPageUrl = null;
                        state.previousPageUrl = null;
                    }
                    self.caseOutlineList = res.data.results;
                    for (var index in self.caseOutlineList) {
                        self.caseOutlineList[index]['category_name'] = self.caseOutlineList[index]['category']['name'];
                        delete self.caseOutlineList[index]['category'];
                        delete self.caseOutlineList[index]['cases_desc'];
                    }
                }, (err) => {
                    var errorReasonDict = err.body;
                    console.log('---errorReasonDict---');
                    console.log(errorReasonDict);
                });
        }
    }
});

export default store;
