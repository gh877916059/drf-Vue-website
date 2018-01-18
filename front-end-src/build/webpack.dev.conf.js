var utils = require('./utils')
var webpack = require('webpack')
var config = require('./config')
var merge = require('webpack-merge')
var baseWebpackConfig = require('./webpack.base.conf')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var FriendlyErrorsPlugin = require('friendly-errors-webpack-plugin')
var OptimizeCSSPlugin = require('optimize-css-assets-webpack-plugin')
var ExtractTextPlugin = require('extract-text-webpack-plugin')

// add hot-reload related code to entry chunks
Object.keys(baseWebpackConfig.entry).forEach(function(name) {
    // concat() 方法用于连接两个或多个数组
    baseWebpackConfig.entry[name] = ['./build/dev-client'].concat(baseWebpackConfig.entry[name])
})

module.exports = merge(baseWebpackConfig, {
    /*
    为了使调试更容易，输出更多有帮助的信息
    ①source-map：在一个单独的文件中产生一个完整且功能完全的文件。这个文件具有最好的source map，但是它会减慢打包速度；
    ②cheap-module-source-map：在一个单独的文件中生成一个不带列映射的map，不带列映射提高了打包速度，但是也使得浏览器开发者工具只能对应到具体的行，不能对应到具体的列（符号），会对调试造成不便；；
    ③eval-source-map：使用eval打包源文件模块，在同一个文件中生成干净的完整的source map。这个选项可以在不影响构建速度的前提下生成完整的sourcemap，但是对打包后输出的JS文件的执行具有性能和安全的隐患。在开发阶段这是一个非常好的选项，在生产阶段则一定不要启用这个选项；
    ④cheap-module-eval-source-map：这是在打包文件时最快的生成source map的方法，生成的Source Map 会和打包后的JavaScript文件同行显示，没有列映射，和eval-source-map选项具有相似的缺点；
     */
    devtool: '#cheap-module-eval-source-map',
    plugins: [
        // DefinePlugin：允许你创建一个在编译时可以配置的全局常量
        new webpack.DefinePlugin({
            'process.env': config.dev.env
        }),
        // ExtractTextPlugin会将所有的入口chunk中的require("style.css")移动到分开的css文件
        new ExtractTextPlugin({
            filename: utils.assetsPath('css/[name].css'),
            allChunks: true
        }),
        // 模块热替换(HMR)交换, 添加, 或者删除模块, 同时应用持续运行, 不需要页面刷新
        new webpack.HotModuleReplacementPlugin(),
        // 跳过编译时出错的代码并记录，使编译后运行时的包不会发生错误
        new webpack.NoEmitOnErrorsPlugin(),
        // 压缩提取出的css，并解决ExtractTextPlugin分离出的js重复问题(多个文件引入同一css文件)
        new OptimizeCSSPlugin(),
        // 这个插件将为您生成一个HTML5文件，该文件的 body 中使用script 标记引用了所有 webpack bundle
        // 如果你有任何CSS资源在webpack的 output 中，（例如，使用 ExtractTextPlugin提取的CSS）那么这些资源将被包含在HTML head 中，使用<link>标记引用
        new HtmlWebpackPlugin({
            filename: 'index.html',     // 生成的html的文件名
            template: 'index.html',     // 依据的模板
            inject: true                  // 注入的js文件将会被放在body标签中
        }),
        // 用于更友好地输出webpack的警告、错误等信息
        new FriendlyErrorsPlugin()
    ]
})
