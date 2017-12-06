<template>
    <div class="row">
        <template v-if="caseOutlineList.length > 0">
            <div class="col-sm-12">
                <ul class="list-group" v-on:switchCaseCategory="getcaseOutlineList">
                    <li v-for="(caseOutline, index) in caseOutlineList" class="list-group-item"><case-outline-media-object v-bind="caseOutline"></case-outline-media-object></li>
                </ul>
            </div>
            <div class="col-sm-8 col-sm-offset-4">
                <pagination-nav></pagination-nav>
            </div>
        </template>
        <template v-else>
            <div class="col-sm-12">
                <h1>暂无相关的案例</h1>
            </div>
        </template>
    </div>
</template>

<script>
    import caseOutlineMediaObject from './caseOutlineMediaObject.vue';
    import paginationNav from './paginationNav.vue';
    import $ from 'jquery';
    export default {
        data() {
            return {
                caseOutlineList: []
            };
        },
        components: {
            caseOutlineMediaObject,
            paginationNav
        },
        computed: {
            listenDataDict () {
                return {
                    caseFilterCondition: this.$store.state.caseFilterCondition,
                    forcedRequestCounter: this.$store.state.forcedRequestCounter,
                    currPageNum: this.$store.state.currPageNum,
                    caseCountPerPage: this.$store.state.caseCountPerPage
                };
            }
        },
        methods: {
            // 请求某一类别的所有案例
            getcaseOutlineList: function () {
                var queryDict = {};
                // 利用jQuery的extend函数实现深拷贝
                $.extend(true, queryDict, this.listenDataDict.caseFilterCondition);
                queryDict['page_size'] = this.listenDataDict.caseCountPerPage;
                queryDict['page'] = this.listenDataDict.currPageNum;
                var requestURL = 'cases/?';
                for (var key in queryDict) {
                    requestURL = requestURL + key + '=' + queryDict[key] + '&';
                }
                requestURL = requestURL.slice(0, -1);
                var path = this.$route.path;
                this.$http.get(requestURL)
                    .then((res) => {
                        if (path !== this.$route.path) {
                            return;
                        }
                        this.$store.commit('setPreviousPageUrl', res.data['previous']);
                        this.$store.commit('setNextPageUrl', res.data['next']);
                        this.$store.commit('setPageListByCount', res.data['count']);
                        this.caseOutlineList = res.data.results;
                        for (var index in this.caseOutlineList) {
                            this.caseOutlineList[index]['category_name'] = this.caseOutlineList[index]['category']['name'];
                            delete this.caseOutlineList[index]['category'];
                            delete this.caseOutlineList[index]['cases_desc'];
                        }
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                if (!$.isEmptyObject(this.listenDataDict.caseFilterCondition)) {
                    this.getcaseOutlineList(this.listenDataDict.caseFilterCondition);
                }
            });
        },
        watch: {
            listenDataDict: {
                handler: function (val, oldVal) {
                    this.getcaseOutlineList();
                },
                deep: true
            }
        }
    };
</script>
