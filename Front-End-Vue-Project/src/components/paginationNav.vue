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

<script>
    export default {
        computed: {
            currPageNum () {
                return this.$store.state.currPageNum;
            },
            pageNumToShowList () {
                return this.$store.state.pageNumToShowList;
            },
            nextPageUrl () {
                return this.$store.state.nextPageUrl;
            },
            previousPageUrl () {
                return this.$store.state.previousPageUrl;
            }
        },
        methods: {
            jumpToPage: function (PageId) {
                if (PageId < 1) {
                    PageId = 1;
                } else if (PageId > this.pageNumToShowList.length) {
                    PageId = this.pageNumToShowList.length;
                }
                this.$store.commit('setCurrPageNum', PageId);
            }
        }
    };
</script>
