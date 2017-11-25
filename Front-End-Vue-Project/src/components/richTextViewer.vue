<template>
    <div>
        <router-link class="button expanded" v-bind:to="editCaseURL">编辑</router-link>
        <div id="richTextViewerDiv" v-html="cases_desc">
        </div>
    </div>
</template>

<script>
    export default {
        props: {
            caseId: {
                type: String,
                default: ''
            }
        },
        data() {
            return {
                category: '',
                name: '',
                click_num: 0,
                fav_num: 0,
                cases_brief: '',
                cases_desc: '',
                cases_front_image: '',
                add_time: '',
                id: 0
            };
        },
        methods: {
            // 请求该案例的详细信息
            getCaseDetail: function () {
                if (this.caseId.length <= 0) {
                    console.log('---请传入案例ID作为query---');
                } else {
                    this.$http.get('cases/' + this.caseId + '/')
                        .then((res) => {
                            this.category = res.data['category'];
                            this.name = res.data['name'];
                            this.click_num = res.data['click_num'];
                            this.fav_num = res.data['fav_num'];
                            this.cases_brief = res.data['cases_brief'];
                            this.cases_desc = res.data['cases_desc'];
                            this.cases_front_image = res.data['cases_front_image'];
                            this.add_time = res.data['add_time'];
                            this.id = res.data['id'];
                        }, (err) => {
                            var errorReasonDict = err.body;
                            console.log('---errorReasonDict---');
                            console.log(errorReasonDict);
                        });
                }
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                this.getCaseDetail();
            });
        },
        computed: {
            editCaseURL () {
                return '/editCase?id=' + this.id;
            }
        }
    };
</script>
