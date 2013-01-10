vim
===

repository for vim's plugins and vim profile


4个目录:
--

* 1.autoload，这里的插件，用于管理其他插件，好比插件管理员。vim打开时，通过它来加载bundle目录下的所有插件 

* 2.bundle，存放后续扩展的插件，1个插件一个目录。不要某个插件只需删除对应的插件目录即可，方便插件管理

* 3.package，存放非git clone的插件压缩包。

* 4.colors. 存放colorscheme的文件。


1个文件:
--
* vimrc，就是vim的profile拉


我是这样根据github来实现多台机器同步vim的：
--
* 1.先备份已有的vim目录和vimrc文件<br/>
`mv ~/.vim ~/vim.bak` <br/>
`mv ~/.vimrc ~/vimrc.bak`

* 2.clone这个vim仓库到机器上<br/>
`git clone git://github.com/popozhu/vim.git`

* 3.把clone下来的vim目录替换到~/.vim <br/>
`mv vim ~/.vim`

* 4.为~/.vim/vimrc文件创建一个软连接 <br/>
`ln -s ~/.vim/vimrc ~/.vimrc`

* 5.启动vim即可<br/>
`vim ~/.vimrc`

* 6.以后要同步，只需在~/.vim目录下git pull或git push即可。

note:
--
一些vim快捷键在~/.vimrc文件里被我注释掉了，个人推崇尽可能少点配置，多点记忆<br/>
且尽可能使用更多大众化的快捷键
