<template>
    <div id="indexCarousel" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <template v-for="(bannerCase, index) in bannerCaseList">
                <li data-target="#indexCarousel" v-bind:data-slide-to="index" v-bind:class="[index===0?'active':'']"></li>
            </template>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner" role="listbox">
            <template v-for="(bannerCase, index) in bannerCaseList">
                <div v-bind:class="[index===0?'active':'', 'item']">
                    <img v-bind:src="bannerCase.imageSrc">
                    <div class="carousel-caption">
                        {{bannerCase.title}}
                    </div>
                </div>
            </template>
        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#indexCarousel" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#indexCarousel" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                bannerCaseList: []
            };
        }
    };
</script>
