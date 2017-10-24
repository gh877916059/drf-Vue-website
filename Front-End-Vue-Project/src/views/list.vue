<template>
    <div>
        <!-- 全局header -->
        <nv-head :page-type="getTitleStr(searchKey.tab)"
                ref="head"
                :fix-head="true"
                :need-add="true">
        </nv-head>

        <section id="page">
            <!-- 首页列表 -->
            <ul class="posts-list">
                <!-- 使用key，它会基于key的变化重新排列元素顺序，并且会移除key不存在的元素。 -->
                <li v-for="item in topics" :key="item.id">
                    <router-link :to="{name:'topic',params:{id:item.id}}">
                    <h3 v-text="item.title"
                            :class="getTabInfo(item.tab, item.good, item.top, true)"
                            :title="getTabInfo(item.tab, item.good, item.top, false)">
                    </h3>
                    <div class="content">
                        <img class="avatar" :src="item.author.avatar_url" />
                        <div class="info">
                            <p>
                                <span class="name">
                                    {{item.author.loginname}}
                                </span>
                                <span class="status" v-if="item.reply_count > 0">
                                    <b>{{item.reply_count}}</b>
                                    /{{item.visit_count}}
                                </span>
                            </p>
                            <p>
                                <time>{{item.create_at | getLastTimeStr(true)}}</time>
                                <time>{{item.last_reply_at | getLastTimeStr(true)}}</time>
                            </p>
                        </div>
                    </div>
                    </router-link>
                </li>
            </ul>
        </section>
        <nv-top></nv-top>
    </div>
</template>

<script>
    import $ from 'webpack-zepto';
    import utils from '../libs/utils.js';
    import nvHead from '../components/header.vue';
    import nvTop from '../components/backtotop.vue';

    export default {
        filters: {
            getLastTimeStr(time, isFromNow) {
                return utils.getLastTimeStr(time, isFromNow);
            }
        },
        data() {
            return {
                scroll: true,
                topics: [],
                index: {},
                searchKey: {
                    page: 1,
                    limit: 20,
                    tab: 'all',
                    mdrender: true
                },
                searchDataStr: ''
            };
        },
        mounted() {
            if (this.$route.query && this.$route.query.tab) {
                this.searchKey.tab = this.$route.query.tab;
            }

            // 如果从详情返回并且之前存有对应的查询条件和参数
            // 则直接渲染之前的数据
            // window对象的window属性指向该window对象本身
            if (window.window.sessionStorage.searchKey && window.window.sessionStorage.tab === this.searchKey.tab) {
                this.topics = JSON.parse(window.window.sessionStorage.topics);
                this.searchKey = JSON.parse(window.window.sessionStorage.searchKey);
                // 可以使用$(document).scrollTop()和$(window).scrollTop()来获取滚动条距离
                this.$nextTick(() => $(window).scrollTop(window.window.sessionStorage.scrollTop));
            } else {
                this.getTopics();
            }
            // 滚动加载，触发scroll事件后0.3--1.0秒后执行getScrollData函数
            $(window).on('scroll', utils.throttle(this.getScrollData, 300, 1000));
        },
        beforeRouteLeave(to, from, next) {
            // 如果跳转到详情页面，则记录关键数据
            // 方便从详情页面返回到该页面的时候继续加载之前位置的数据
            if (to.name === 'topic') {
                // 当前滚动条位置
                window.window.sessionStorage.scrollTop = $(window).scrollTop();
                // 当前页面主题数据
                window.window.sessionStorage.topics = JSON.stringify(this.topics);
                // 查询参数
                window.window.sessionStorage.searchKey = JSON.stringify(this.searchKey);
                // 当前tab
                window.window.sessionStorage.tab = from.query.tab || 'all';
            }
            // 移除window上的scroll事件
            $(window).off('scroll');
            next();
        },
        beforeRouteEnter(to, from, next) {
            if (from.name !== 'topic') {
                // 页面切换移除之前记录的数据集
                if (window.window.sessionStorage.tab) {
                    window.window.sessionStorage.removeItem('topics');
                    window.window.sessionStorage.removeItem('searchKey');
                    window.window.sessionStorage.removeItem('tab');
                }
            }
            next();
        },
        methods: {
            // 获取title文字
            getTitleStr(tab) {
                let str = '';
                switch (tab) {
                    case 'share':
                        str = '分享';
                        break;
                    case 'ask':
                        str = '问答';
                        break;
                    case 'job':
                        str = '招聘';
                        break;
                    case 'good':
                        str = '精华';
                        break;
                    default:
                        str = '全部';
                        break;
                }
                return str;
            },
            // 获取不同tab的样式或者标题
            getTabInfo(tab, good, top, isClass) {
                return utils.getTabInfo(tab, good, top, isClass);
            },
            // 获取主题数据
            getTopics() {
                // jQuery.param()函数用于将一个JS数组或纯粹的对象序列化为字符串值，以便用于URL查询字符串或AJAX请求
                let params = $.param(this.searchKey);
                $.get('https://cnodejs.org/api/v1/topics?' + params, (d) => {
                    this.scroll = true;
                    if (d && d.data) {
                        d.data.forEach(this.mergeTopics);
                    }
                });
            },
            mergeTopics(topic) {
                if (typeof this.index[topic.id] === 'number') {
                    const topicsIndex = this.index[topic.id];
                    this.topics[topicsIndex] = topic;
                } else {
                    this.index[topic.id] = this.topics.length;
                    this.topics.push(topic);
                }
            },
            // 滚动加载数据
            getScrollData() {
                if (this.scroll) {
                    /*
                    They are both going to have the same effect
                    However, as pointed out in the comments: $(window).scrollTop() is supported by more web browsers than $('html').scrollTop()
                    $(document).scrollTop() 获取垂直滚动的距离 (即当前滚动的地方的窗口顶端到整个页面顶端的距离)
                    $(document).scrollLeft() 这是获取水平滚动条的距离
                    scrollTop() ≥ $(document).height()-$(window).height()说明已经滚动到底端了
                     */
                    // 以20进制来解析整数，totalheight代表能显示到的最下方的数据位置
                    let totalheight = parseInt($(window).height(), 20) + parseInt($(window).scrollTop(), 20);
                    // 如果已经超出范围，则需要刷新数据
                    if ($(document).height() <= totalheight + 200) {
                        this.scroll = false;
                        this.searchKey.page += 1;
                        this.getTopics();
                    }
                }
            }
        },
        /*
        键是观察表达式，值是对应回调。值也可以是方法名，或者是对象，包含选项。在实例化时为每个键调用$watch()
        当键是某个data属性时，说明监听的是数据变化，函数接收两个参数（现在的值、之前的值）
        下面的键是'$route'，说明监听的是页面跳转，函数接收两个参数（目标页面、当前页面）
         */
        watch: {
            '$route' (to, from) {
                // 如果是当前页面切换分类的情况
                if (to.query && to.query.tab) {
                    this.searchKey.tab = to.query.tab;
                    this.topics = [];   // topics就是存储页面按照从上到下顺序的topic数组
                    this.index = {};    // index维护topic的id-->topic在topics数组的下标的映射关系
                }
                this.searchKey.page = 1;
                this.getTopics();
                // 隐藏ref="head"的全局导航栏（这种方式可以减少获取dom节点的消耗）
                this.$refs.head.show = false;
            }
        },
        components: {
            nvHead,
            nvTop
        }
    };
</script>
