



- hexo安装

> $ npm install -g hexo

- 初始化项目（不提交到 github）

> $ cd /f/Workspaces/hexo/
>
> $ hexo init # 初始化
>
> $ hexo g # 生成 
>
> $ hexo s # 启动服务
>
> ----
>
> $ # init有问题可以使用以下指令代替 hexo init
>
> $ git clone https://github.com/hexojs/hexo-starter.git
>
> $ cd hexo-starter
>
> $ npm install 

- 修改模版: 
  - 官方模版主题：[hexo](https://hexo.io/themes/)

> $ git clone https://github.com/litten/hexo-theme-yilia.git themes/yilia
>
> $ # 修改 _config.yml 中的 theme 配置为 yilia
>
> $ hexo g # 重新生产，如果有异常，可以用 hexo clean 清理

- 写作

> $ hexo new page "_pageName" # 新建页面，建议以下划线开头，方便新建文章使用
>
> $ hexo new page "_java" # 创建java页面访问地址为 domain/java
>
> $ hexo new java "title" # 在java页面下，创建文章

