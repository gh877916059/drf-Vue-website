<template>
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <template v-if="previousPageUrl">
                <li>
                    <a href="#" v-on:click="jumpToPage(currPageNum - 1)" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </template>
            <template v-else>
                <li class="disabled">
                    <a aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </template>

            <template v-for="pageNum in pageNumToShowList">
                <li v-bind:class="[pageNum===currPageNum?'active':'']">
                    <a href="#" v-on:click="jumpToPage(pageNum)">{{pageNum}} <span v-if="pageNum===currPageNum" class="sr-only">(current)</span></a>
                </li>
            </template>

            <template v-if="nextPageUrl">
                <li>
                    <a href="#" v-on:click="jumpToPage(currPageNum + 1)" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </template>
            <template v-else>
                <li class="disabled">
                    <a aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </template>

        </ul>
    </nav>
</template>

<script lang="ts">
    import Utils from '../utils';
    import {Component, Vue, Prop} from 'vue-property-decorator';
    import {Mutation} from 'vuex-class';
    @Component
    export default class paginationNav extends Vue{
        @Prop({type: Number, default: 1})
        sumPageNum: number;
        @Prop({type: String, default: ''})
        nextPageUrl: string;
        @Prop({type: String, default: ''})
        previousPageUrl: string;
        get currPageNum(): number{
            return this.$store.state.currPageNum;
        }
        get pageNumToShowList(): number[]{
            return Utils.rangeArray(1, this.sumPageNum);
        }
        @Mutation('setCurrPageNum') mutationSetCurrPageNum;
        jumpToPage(pageNum: number): void{
            if (pageNum < 1) {
                pageNum = 1;
            } else if (pageNum > this.pageNumToShowList.length) {
                pageNum = this.pageNumToShowList.length;
            }
            this.mutationSetCurrPageNum(pageNum);
        }
    };
</script>
