var path = require('path')
var config = require('./config')
var utils = require('./utils')
var webpack = require('webpack')
var merge = require('webpack-merge')
var baseWebpackConfig = require('./webpack.base.conf')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var env = config.build.env
const UglifyJsPlugin = require('uglifyjs-webpack-plugin')

var webpackConfig = merge(baseWebpackConfig, {
    /*
    webpack2更新变化，module.loaders => module.rules
    This is not a breaking change because module.loaders will continue to be supported, but in the future it will be deprecated in favour of module.rules.
    module: {
        loaders: utils.styleLoaders({ sourceMap: config.build.productionSourceMap, extract: true })
    },
    */

    /*
    为了使调试更容易，输出更多有帮助的信息
    ①source-map：在一个单独的文件中产生一个完整且功能完全的文件。这个文件具有最好的source map，但是它会减慢打包速度；
    ②cheap-module-source-map：在一个单独的文件中生成一个不带列映射的map，不带列映射提高了打包速度，但是也使得浏览器开发者工具只能对应到具体的行，不能对应到具体的列（符号），会对调试造成不便；；
    ③eval-source-map：使用eval打包源文件模块，在同一个文件中生成干净的完整的source map。这个选项可以在不影响构建速度的前提下生成完整的sourcemap，但是对打包后输出的JS文件的执行具有性能和安全的隐患。在开发阶段这是一个非常好的选项，在生产阶段则一定不要启用这个选项；
    ④cheap-module-eval-source-map：这是在打包文件时最快的生成source map的方法，生成的Source Map 会和打包后的JavaScript文件同行显示，没有列映射，和eval-source-map选项具有相似的缺点；
     */
    devtool: config.build.productionSourceMap ? '#source-map' : false,

    /*
    path：打包后的文件存放的地方
    publicPath：公共资源路径
    filename：打包后输出文件的文件名
     */
    output: {
        path: config.build.assetsRoot,
        filename: utils.assetsPath('js/[name].[chunkhash].js'),
        chunkFilename: utils.assetsPath('js/[id].[chunkhash].js')
    },
    plugins: [
        // DefinePlugin：允许你创建一个在编译时可以配置的全局常量
        new webpack.DefinePlugin({
            'process.env': env
        }),
        // UglifyJsPlugin压缩代码
        new UglifyJsPlugin(),
        // ExtractTextPlugin会将所有的入口chunk中的require("style.css")移动到分开的css文件
        new ExtractTextPlugin({
            filename: utils.assetsPath('css/[name].[contenthash].css'),
            allChunks: true,
            disable: false
        }),
        // 这个插件将为您生成一个HTML5文件，该文件的 body 中使用script 标记引用了所有 webpack bundle
        // 如果你有任何CSS资源在webpack的 output 中，（例如，使用 ExtractTextPlugin提取的CSS）那么这些资源将被包含在HTML head 中，使用<link>标记引用
        new HtmlWebpackPlugin({
            filename: config.build.index,   // 生成的html的文件名
            template: 'index.html',         // 依据的模板
            inject: true,                     // 注入的js文件将会被放在body标签中
            minify: {                           // 压缩配置
                removeComments: true,       // 删除html中的注释代码
                collapseWhitespace: true,   // 删除html中的空白符
                removeAttributeQuotes: true     // 删除html元素中属性的引号
                    // more options:
                    // https://github.com/kangax/html-minifier#options-quick-reference
            },
            chunksSortMode: 'dependency'    // 按dependency的顺序引入
        }),
        // 分离公共js到vendor中
        new webpack.optimize.CommonsChunkPlugin({
            name: 'vendor',
            minChunks: function(module, count) {    // 声明公共的模块来自node_modules文件夹
                return (
                    module.resource &&
                    /\.js$/.test(module.resource) &&
                    module.resource.indexOf(
                        path.join(__dirname, '../node_modules')
                    ) === 0
                )
            }
        }),
        // 上面虽然已经分离了第三方库,每次修改编译都会改变vendor的hash值，导致浏览器缓存失效
        // 原因是vendor包含了webpack在打包过程中会产生一些运行时代码，运行时代码中实际上保存了打包后的文件名。当修改业务代码时,业务代码的js文件的hash值必然会改变
        // 下面主要是将运行时代码提取到单独的manifest文件中，防止其影响vendor.js
        new webpack.optimize.CommonsChunkPlugin({
            name: 'manifest',
            chunks: ['vendor']
        })
    ]
})

if (config.build.productionGzip) {
    // 该插件能够将资源文件压缩为.gz文件，并且根据客户端的需求按需加载
    var CompressionWebpackPlugin = require('compression-webpack-plugin')

    webpackConfig.plugins.push(
        new CompressionWebpackPlugin({
            asset: '[path].gz[query]',  // asset：目标资源名称，[file]会被替换成原始资源，[path]会被替换成原始资源的路径，[query] 会被替换成查询字符串
            algorithm: 'gzip',
            test: new RegExp(
                '\\.(' +
                config.build.productionGzipExtensions.join('|') +
                ')$'
            ),                  // test： 所有匹配该正则的资源都会被处理。默认值是全部资源。
            threshold: 10240,           // 只有大小大于该值的资源会被处理，单位是 bytes
            minRatio: 0.8               // 只有压缩率小于这个值的资源才会被处理
        })
    )
}

module.exports = webpackConfig
