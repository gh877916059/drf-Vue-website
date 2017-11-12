// see http://vuejs-templates.github.io/webpack for documentation.
var path = require('path')

module.exports = {
  build: {
    env: require('./prod.env'),
    index: path.resolve(__dirname, '../dist/index.html'),   // index.html文件的路径
    assetsRoot: path.resolve(__dirname, '../dist'),     // build时公共资源根目录
    assetsSubDirectory: 'public',       // 公共资源子目录
    assetsPublicPath: '/',          // dev时公共资源根目录
    productionSourceMap: true,
    productionGzip: false,              // 是否对productionGzipExtensions中包含的后缀的文件进行压缩处理
    productionGzipExtensions: ['js', 'css']     // 对该后缀的文件进行压缩处理
  },
  dev: {
    env: require('./dev.env'),
    port: 8020,
    proxyTable: {
    }
  }
}
