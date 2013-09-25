这是什么
=======

这是我自己的SICP学习记录，各种杂碎，仅供参考。

截止到 3-10.scm(含) 的代码都是基于 [Racket](http://racket-lang.org/) 实现的；之后的代码切换到 [Guile](http://www.gnu.org/software/guile/) 。其实很好区别，如果第一行是 `#lang racket` 这样的都是Racket的代码。

之所以要切换到Guile，是因为Racket并不直接支持 `set-cdr!` 等修改操作，需要改用scheme/mpair包里的 `set-mcdr!` ，并且连带的也得用 `mcons`, `mcar`, `mlist` ... 太麻烦了，所以就换过来了。而且Guile的错误提示什么的比Racket要丰富很多，便于查错。

参考文档
========

以下是学习过程中用到的资源

[SICP-Solutions](http://community.schemewiki.org/?SICP-Solutions): 大部分都有，但部分习题未完成。

[huangz 的 SICP 解题集](http://sicp.readthedocs.org/en/latest/): 目前更新到4.14，其中有部分习题未完成

[zzljlu的专栏.SICP](http://blog.csdn.net/zzljlu/article/category/789761): 目前更新到4.16, 2012.06

[ini.kelvin 的 SICP学习笔记和习题解答](http://kelvinh.github.io/wiki/sicp/)

[SICP 公开课 中文字幕](http://www.douban.com/group/topic/36584558/)

[racket非REPL环境如何正确load一个现有脚本](http://www.douban.com/group/topic/42119635/)

[The SICP 2.2.4 Picture Language](http://planet.racket-lang.org/display.ss?package=sicp.plt&owner=soegaard): 在DrRacket里可以运行。
