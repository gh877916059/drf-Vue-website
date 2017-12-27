<template>
    <aside>
        <ul class="nav-coupon-category panel">
            <li v-for="hotCategory in hotCategoryList">
                <a href="#">
                    <i v-bind:class="hotCategory.class"></i>{{hotCategory.name}}<span>{{hotCategory.num_cases}}</span>
                </a>
            </li>
            <li class="all-cat">
                <a class="font-14" href="#">所有分类</a>
            </li>
        </ul>
    </aside>
</template>

<script lang="ts">
    import axios from 'axios';
    import {Component, Vue} from 'vue-property-decorator';
    import {CaseCategory} from '../commonType';
    @Component
    export default class hotCategoryList extends Vue{
        hotCategoryList: CaseCategory[] = [];
        // 请求首页轮播图信息
        getHotCategoryList(): void{
            axios.get('hotcategory/')
                .then((res) => {
                    this.hotCategoryList = res.data;
                    this.convertParentCategoryToIconClass();
                }, (err) => {
                    let errorReasonDict = err.body;
                    console.log('---errorReasonDict---');
                    console.log(errorReasonDict);
                });
        }
        convertParentCategoryToIconClass(): void{
            for (let hotCategory of this.hotCategoryList) {
                if (hotCategory['parent_category_id'] === 1) {
                    hotCategory['class'] = 'fa fa-graduation-cap';
                } else if (hotCategory['parent_category_id'] === 12) {
                    hotCategory['class'] = 'fa fa-paint-brush';
                } else if (hotCategory['parent_category_id'] === 27) {
                    hotCategory['class'] = 'fa fa-gamepad';
                } else {
                    hotCategory['class'] = 'fa fa-cutlery';
                }
            }
        }
        mounted(): void{
            this.$nextTick(function (this: hotCategoryList) {
                this.getHotCategoryList();
            });
        }
    };
</script>
<style lang="scss">
    @import '../assets/scss/common_style';
    .nav-coupon-category li a {
        display: block;
        position: relative;
        text-transform: uppercase;
        line-height: 43px;
        height: 43px;
        white-space: nowrap;
        text-overflow: ellipsis;
        color: #717f86;
        padding-left: 5px;
        font-size: 12px;
        -webkit-transition: all 200ms linear;
        -ms-transition: all 200ms linear;
        -o-transition: all 200ms linear;
        transition: all 200ms linear;
    }
    @media only screen and (min-width: 1200px) {
        .nav-coupon-category li a {
            line-height: 46px;
            height: 46px;
        }
    }
    .nav-coupon-category .all-cat a {
        padding-right: 20px;
        padding-left: 20px;
        height: 50px;
        line-height: 50px;
    }
    .nav-coupon-category li a .fa {
        font-size: 15px;
        width: 40px;
        margin-right: 20px;
        color: #2ed87b;
        border-right: 1px solid #ddd;
        text-align: center;
    }
    .nav-coupon-category li a > span {
        margin-left: 8px;
        color: #bfbfbf;
        padding: 1px 7px;
        border-radius: 2px;
        font-size: 11px;
        -webkit-transition: all 200ms linear;
        -ms-transition: all 200ms linear;
        -o-transition: all 200ms linear;
        transition: all 200ms linear;
    }
    .nav-coupon-category li a:hover {
        padding-left: 12px;
    }
    .nav-coupon-category li a:hover > span {
        margin-left: 10px;
        color: #fff;
        background-color: #2ed87b;
    }
    .nav-coupon-category li + li {
        border-top: 1px solid #eee;
    }
</style>
