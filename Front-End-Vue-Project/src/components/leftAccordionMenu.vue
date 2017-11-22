<template>
    <div class="panel-group" id="leftAccordionMenu" role="tablist" aria-multiselectable="true">
        <div v-for="(parentCategory, index) in categoryList" class="panel panel-default">
            <div class="panel-heading" role="tab">
                <h4 class="panel-title">
                    <a role="button" data-toggle="collapse" data-parent="#leftAccordionMenu" v-bind:href="'#collapse'+index" v-bind:class="[index===0?'':'collapsed']" v-bind:aria-expanded="index===0?'true':'false'" v-bind:aria-controls="'collapse'+index">
                        {{parentCategory.name}}
                    </a>
                </h4>
            </div>
            <div v-bind:id="'collapse'+index" v-bind:class="[index===0?'in':'', 'panel-collapse','collapse']" role="tabpanel">
                <ul v-for="subCategory in parentCategory.sub_cat" class="list-group">
                    <li class="list-group-item">{{subCategory.name}}</li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                categoryList: []
            };
        },
        mounted: function () {
            this.$nextTick(function () {
                // 请求案例分类信息
                this.$http.get('categorys/')
                    .then((res) => {
                        this.categoryList = res.data;
                    }, (err) => {
                        var errorReasonDict = err.body;
                        console.log('---errorReasonDict---');
                        console.log(errorReasonDict);
                    });
            });
        }
    };
</script>
