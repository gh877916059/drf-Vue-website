<template>
    <div>
        <template v-if="caseOutlineList.length > 0">
            <ul class="list-group" v-on:switchCaseCategory="getcaseOutlineList">
                <li v-for="(caseOutline, index) in caseOutlineList" class="list-group-item"><case-outline-media-object v-bind="caseOutline"></case-outline-media-object></li>
            </ul>
        </template>
        <template v-else>
            <h1>暂无相关的案例</h1>
        </template>
    </div>
</template>

<script>
    import caseOutlineMediaObject from './caseOutlineMediaObject.vue';
    import $ from 'jquery';
    export default {
        data() {
            return {
                caseOutlineList: []
            };
        },
        components: {
            caseOutlineMediaObject
        },
        computed: {
            caseFilterCondition () {
                return this.$store.state.caseFilterCondition;
            },
            ForcedRequestCounter () {
                return this.$store.state.ForcedRequestCounter;
            }
        },
        methods: {
            // 请求某一类别的所有案例
            getcaseOutlineList: function (caseFilterCondition) {
                var requestURL = 'cases/?';
                for (var key in caseFilterCondition) {
                    requestURL = requestURL + key + '=' + caseFilterCondition[key] + '&';
                }
                requestURL = requestURL.slice(0, -1);
                var path = this.$route.path;
                this.$http.get(requestURL)
                    .then((res) => {
                        if (path !== this.$route.path) {
                            return;
                        }
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
                if (!$.isEmptyObject(this.caseFilterCondition)) {
                    this.getcaseOutlineList(this.caseFilterCondition);
                }
            });
        },
        watch: {
            caseFilterCondition: {
                handler: function (val, oldVal) {
                    this.getcaseOutlineList(val);
                },
                deep: true
            },
            ForcedRequestCounter: {
                handler: function (val, oldVal) {
                    console.log('---因为计数器而引起案例列表重新请求---');
                    this.getcaseOutlineList(this.caseFilterCondition);
                }
            }
        }
    };
</script>
