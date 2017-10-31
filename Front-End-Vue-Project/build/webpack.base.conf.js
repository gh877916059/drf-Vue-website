var path = require('path')
var config = require('../config')
var utils = require('./utils')
var projectRoot = path.resolve(__dirname, '../')
var env = process.env.NODE_ENV

var cssSourceMapDev = (env === 'development' && config.dev.cssSourceMap)
var cssSourceMapProd = (env === 'production' && config.build.productionSourceMap)
var useCssSourceMap = cssSourceMapDev || cssSourceMapProd

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
    publicPath: process.env.NODE_ENV === 'production' ? config.build.assetsPublicPath : config.dev.assetsPublicPath,
    filename: '[name].js'
  },
  /*
   extensions：自动解析确定的扩展，默认值为：[".js", ".json"]
   alias：创建 import 或 require 的别名，来确保模块引入变得更简单
   */
  resolve: {
    extensions: ['', '.js', '.vue'],
    fallback: [path.join(__dirname, '../node_modules')],
    alias: {
      'vue$': 'vue/dist/vue',
      'src': path.resolve(__dirname, '../src'),
      'assets': path.resolve(__dirname, '../src/assets'),
      'components': path.resolve(__dirname, '../src/components')
    }
  },
  resolveLoader: {
    fallback: [path.join(__dirname, '../node_modules')]
  },
  /*
   配置loader加载器处理文件：比如 sass less 等, 告知webpack每一种文件都需要使用什么加载器来处理
   ①eslint-loader是一个用来识别ECMAScript并且按照规则给出报告的代码检测工具
   ②vue-loader可以将Vue组件转换为JavaScript、CSS模块
   ③babel-loader用于将ES6代码转为ES5代码，从而在现有环境执行
   ④sass-loader：加载SASS/SCSS文件并将它编译为CSS文件
   ⑤css-loader可以实现在文件中通过require的方式，来引入css
   ⑥style-loader通过注入<style>标签将CSS添加到DOM中
   ⑦url-loader提供了一个limit参数，小于limit字节的文件会被转为DataURl（base64编码），大于limit字节就会使用file-loader（url-loader封装了file-loader，url路径被重新调整为相对入口html页面）

   配置plugin用来更改loader的默认行为
   ①ExtractTextPlugin会将所有的入口chunk中的require("style.css")移动到分开的css文件
   */
  module: {
    loaders: [
      {
        test: /\.vue$/,
        loader: 'vue'
      },
      {
        test: /\.js$/,
        loader: 'babel',
        include: projectRoot,
        exclude: /node_modules/
      },
      {
        test: /\.json$/,
        loader: 'json'
      },
      {
        test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
        loader: 'url',
        query: {
          limit: 10000,
          name: utils.assetsPath('img/[name].[hash:7].[ext]')
        }
      },
      {
        test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
        loader: 'url',
        query: {
          limit: 10000,
          name: utils.assetsPath('fonts/[name].[hash:7].[ext]')
        }
      }
    ]
  },
  vue: {
    loaders: utils.cssLoaders({ sourceMap: useCssSourceMap }),
    postcss: [
      require('autoprefixer')({
        browsers: ['last 2 versions']
      })
    ]
  }
}
