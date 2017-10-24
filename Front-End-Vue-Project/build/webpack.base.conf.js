var path = require('path')
var config = require('../config')
var utils = require('./utils')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var vueLoaderConfig = require('./vue-loader.conf')


function resolve(dir) {
    return path.join(__dirname, '..', dir)
}

module.exports = {
    /*
    ①当entry是个字符串时，用来定义单入口文件
    ②当entry是个数组时，将创建多个主入口，将它们的依赖导向(graph)到一个“chunk”
    ③当entry是一个对象时，通常是为了实现关注点分离，例如分离应用程序(app)和公共库(vendor)入口
     */
    entry: {
        app: './src/main.js'
    },
    /*
    path：打包后的文件存放的地方
    publicPath：公共资源路径
    filename：打包后输出文件的文件名
     */
    output: {
        path: config.build.assetsRoot,
        publicPath: config.build.assetsPublicPath,
        filename: '[name].js'
    },
    /*
    extensions：自动解析确定的扩展，默认值为：[".js", ".json"]
    alias：创建 import 或 require 的别名，来确保模块引入变得更简单
     */
    resolve: {
        extensions: ['.css', '.js', '.vue'],
        // fallback: [path.join(__dirname, '../node_modules')],
        alias: {
            'vue$': 'vue/dist/vue',
            'src': path.resolve(__dirname, '../src'),
            'assets': path.resolve(__dirname, '../src/assets'),
            'components': path.resolve(__dirname, '../src/components')
        }
    },
    /*
    配置loader加载器处理文件：比如 sass less 等, 告知 webpack每一种文件都需要使用什么加载器来处理
    ①ESLint是一个用来识别 ECMAScript 并且按照规则给出报告的代码检测工具
    ②babel-loader用于将ES6代码转为ES5代码，从而在现有环境执行
    ③css-loader用于向CSS加入了局部作用域和模块依赖
    ④url-loader提供了一个limit参数，小于limit字节的文件会被转为DataURl（base64编码），大于limit字节就会使用file-loader（url-loader封装了file-loader，url路径被重新调整为相对入口html页面）
    ⑤style-loader通过注入<style>标签将CSS添加到DOM中

    配置plugin用来更改loader的默认行为
    ①ExtractTextPlugin会将所有的入口chunk中的require("style.css")移动到分开的css文件
    这样，样式不再内联到 javascript 里面，但会放到一个单独的 css 包文件 (styles.css)当中
    如果你的样式文件大小较大，这会更快，因为样式文件会跟 javascript 包并行加载
    use：指示加载器 (Loader), 被用于将资源转换成一个输出的 CSS 模块（例如'sass-loader'和'css-loader' )
    fallback：指示加载器 (例如'style-loader'), 应用于当 css 没有被提取(也就是一个额外的 chunk，当 allChunks: false)
     */
    module: {
        rules: [{
                test: /\.(js|vue)$/,
                loader: 'eslint-loader',
                // enforce用于指示加载器的执行顺序
                enforce: "pre",
                include: [resolve('src'), resolve('test')],
                options: {
                    formatter: require('eslint-friendly-formatter')
                }
            },
            {
                test: /\.vue$/,
                loader: 'vue-loader',
                options: vueLoaderConfig
            },
            {
                test: /\.js$/,
                loader: 'babel-loader',
                include: [resolve('src'), resolve('test')]
            },
            {
                test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
                loader: 'url-loader',
                query: {
                    limit: 10000,
                    name: utils.assetsPath('img/[name].[hash:7].[ext]')
                }
            },
            {
                test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
                loader: 'url-loader',
                query: {
                    limit: 10000,
                    name: utils.assetsPath('fonts/[name].[hash:7].[ext]')
                }
            },
            {
                test: /\.scss$/,
                include: [resolve('src'), resolve('test')],
                exclude: [/node_modules\/(?!(ng2-.+|ngx-.+))/],
                use: ExtractTextPlugin.extract({
                    use: ['css-loader', 'sass-loader'],
                    fallback: 'style-loader'
                })
            },
            {
                test: /\.css$/,
                include: [resolve('src'), resolve('test')],
                exclude: [/node_modules\/(?!(ng2-.+|ngx-.+))/],
                use: ExtractTextPlugin.extract({
                    use: ['css-loader'],
                    fallback: 'style-loader'
                })
            }
        ]
    }
}
