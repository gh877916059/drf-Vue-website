require('./check-versions')();
var config = require('./config');
if (!process.env.NODE_ENV) process.env.NODE_ENV = JSON.parse(config.dev.env.NODE_ENV);
var path = require('path');
var express = require('express');
var webpack = require('webpack');
var opn = require('opn');
var proxyMiddleware = require('http-proxy-middleware');
var webpackConfig = require('./webpack.dev.conf');

var port = process.env.PORT || config.dev.port;
var proxyTable = config.dev.proxyTable;

// Express是第一代最流行的web框架，它对Node.js的http进行了封装
var app = express();
var compiler = webpack(webpackConfig);

/*
这是一个简单webpack中间件，它提供一个连接服务器并处理访问webpack中的文件
webpack中的文件寄存在内存，不会生成文件
如果在观测模式下修改的文件，中间件不再提供旧包，但会延迟请求，直到编译完成，在文件变化后页面刷新之前你无需等待
publicPath其实是访问的目录根
 */
var devMiddleware = require('webpack-dev-middleware')(compiler, {
    publicPath: webpackConfig.output.publicPath,
    stats: {
        colors: true,
        chunks: false
    }
});

/*
使用它的目的是让代码变化时能更新代码而无需刷新整个页面，但是这块配置就较为繁琐
首先得在每个入口前加上webpack-hot-middleware/client，还需要添加一下plugin到webpack配置
 */
var hotMiddleware = require('webpack-hot-middleware')(compiler);
// force page reload when html-webpack-plugin template changes
compiler.plugin('compilation', function (compilation) {
    compilation.plugin('html-webpack-plugin-after-emit', function (data, cb) {
        hotMiddleware.publish({action: 'reload'})
        cb()
    })
});

// 设置HTTP代理，context用于匹配URL ,target用于指定代理域名
Object.keys(proxyTable).forEach(function (context) {
    var options = proxyTable[context]
    if (typeof options === 'string') {
        options = {target: options, changeOrigin: true}
    }
    app.use(proxyMiddleware(context, options))
});

// 让你的单页面路由处理更自然（比如vue-router的mode设置为html5时）
app.use(require('connect-history-api-fallback')());

app.use(devMiddleware);
app.use(hotMiddleware);

// 将静态资源文件所在的目录作为参数传递给express.static中间件就可以提供静态资源文件的访问了（staticPath的值为"/static")
var staticPath = path.posix.join(config.build.assetsPublicPath, config.build.assetsSubDirectory);
app.use(staticPath, express.static('./static'));

module.exports = app.listen(port, function (err) {
    if (err) {
        console.log(err)
        return
    }
    var uri = 'http://localhost:' + port
    console.log('Listening at ' + uri + '\n')
    if (process.env.NODE_ENV !== 'testing') {
        // 用于安全、方便、跨平台地打开各种资源（比如网站、文件、可执行程序），这里用于自动打开浏览器
        opn(uri)
    }
});
