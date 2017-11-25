<template>
    <div class="panel-group" id="leftAccordionMenu" role="tablist" aria-multiselectable="true">
        <div v-for="(parentCategory, index) in categoryList" class="panel panel-default">
            <div class="panel-heading" role="tab">
                <h4 class="panel-title">
                    <a v-on:click="clickPanelTitle(index)" role="button" data-toggle="collapse" data-parent="#leftAccordionMenu" v-bind:href="'#collapse'+index" v-bind:class="[index===0?'':'collapsed']" v-bind:aria-expanded="index===0?'true':'false'" v-bind:aria-controls="'collapse'+index">
                        {{parentCategory.name}}
                    </a>
                </h4>
            </div>
            <div v-bind:id="'collapse'+index" v-bind:class="[index===0?'in':'', 'panel-collapse','collapse']" role="tabpanel">
                <ul v-for="subCategory in parentCategory.sub_cat" class="list-group">
                    <li class="list-group-item"><a v-on:click="selectOneCategory(subCategory.id)">{{subCategory.name}}</a></li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    import $ from 'jquery';
    export default {
        data() {
            return {
                categoryList: [],
                currUnfoldPanelIndex: 0
            };
        },
        methods: {
            // 请求案例分类信息
            getCategoryList: function () {
                this.$http.get('categorys/')
                    .then((res) => {
                        this.categoryList = res.data;
                        this.$store.commit('setCaseFilterCondition', {top_category: this.categoryList[0].id});
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            },
            selectOneCategory: function (categoryId) {
                this.$store.commit('setCaseFilterCondition', {top_category: categoryId});
            },
            clickPanelTitle: function (panelIndex) {
                if (this.currUnfoldPanelIndex !== panelIndex) {
                    this.currUnfoldPanelIndex = panelIndex;
                    var categoryId = this.categoryList[panelIndex].id;
                    this.$store.commit('setCaseFilterCondition', {top_category: categoryId});
                }
            }
        },
        mounted: function () {
            this.$nextTick(function () {
                this.getCategoryList();
                $('#leftAccordionMenu').on('hide.bs.collapse', function () {
                    var currUnfoldPanelIndex = parseInt($('#leftAccordionMenu div.panel-collapse.in').attr('id').substr(-1));
                    // 如果要隐藏的是当前正在显示的列表框，则不仅要阻止事件往上冒泡，而且要阻止事件本身
                    if (this.currUnfoldPanelIndex === currUnfoldPanelIndex) {
                        return false;
                    }
                    return true;
                }.bind(this));
            });
        }
    };
</script>
