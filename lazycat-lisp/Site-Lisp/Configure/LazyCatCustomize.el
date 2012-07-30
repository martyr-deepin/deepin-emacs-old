;;;;;;;;;;;;;;;;;;;;;;;;;; 需要修改的定义 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 扩展自定义变量
(custom-set-variables
 ;; 基本信息
 '(my-name "Andy")                          ;名字
 '(my-full-name "Andy Stewart")             ;全名
 '(my-mail "lazycat.manatee@gmail.com")     ;邮件地址
 '(my-homepage "http://www.google.com/ncr") ;首页, 无国家/地区的自动转向
 '(my-irc-nick "")                          ;IRC昵称
 '(my-irc-passwd "")                        ;IRC密码
 '(my-irc-channel-list
   '(
     "##manatee"
     "#emacs"
     "#haskell"
     "#darcs"
     "#ghc"
     "#python"
     "#debian"
     ))
 ;; 打开或关闭文件
 '(startup-open-file-list               ;启动打开的文件列表
   '(
     ;; "/usr/share/deepin-emacs/Org/Manatee.org"
     ))
 '(startup-close-file-list              ;启动关闭的buffer列表
   '(
     ))
 ;; 目录设置
 '(my-home-directory "~/")                                              ;HOME目录
 '(my-mldonkey-download-directory "~/.aMule/Incoming/")                 ;mldonkey的下载目录
 '(my-default-download-directory "/test/Download/")                     ;默认下载目录
 '(my-resource-backup-directory "/data/Backup/")                        ;资料备份目录
 '(my-book-directory "/data/Book/")                                     ;图书目录
 '(my-reading-directory "/data/Book/Reading/")                          ;看书目录
 '(my-translate-png-directory "/data/Book/Doc-View_Translate_Book")     ;PDF转换成图片的目录
 '(my-picture-directory "/data/Picture/")                               ;图片目录
 '(my-lyrics-directory "/data/Lyrics/")                                 ;歌词目录
 '(my-screenshots-storage-directory "/data/Picture/Screenshots/")       ;屏幕截图目录
 '(my-emlue-download-directory "/test/WindowsDownload/eMule/")          ;电驴目录
 '(my-notes-directory "/usr/share/deepin-emacs/Org/")                             ;笔记目录
 '(my-emacs-backup-directory "/usr/share/deepin-emacs/Backup/")                   ;备份文件目录
 '(my-emacs-lisp-package-directory "/usr/share/deepin-emacs/Site-Lisp/Packages/") ;elisp 目录
 '(my-elisp-directory "/usr/share/deepin-emacs/Site-Lisp/Packages/LazyCatSelf/")  ;自己扩展目录
 '(my-config-directory "/usr/share/deepin-emacs/Site-Lisp/Configure/Init/")       ;配置目录
 '(my-windows-share-directory "/test/WindowsShare/")                    ;Windows 共享目录
 ;; ERC
 '(erc-server "irc.freenode.net")       ;设置服务器
 '(erc-port 6667)                       ;设置端口
 `(erc-ignore-list '("ams", "trick"))   ;设置白痴列表, 这样就看不到它们的信息
 ;; Google Desktop Search
 '(google-desktop-search-url "http://127.0.0.1:38923/?hl=zh_CN&s=vhITkQ_HHma9o9JG6cj-xJjhra0") ;Google桌面搜索的唯一URL, 从你的外部浏览器的地址栏复制
 ;; Gmail
 '(w3m-gmail-login-string "http://mail.google.com/mail/h/h4339zs3i3b6/?zy=n&f=1") ;gmail 登录字符串
 )

(provide 'LazyCatCustomize)
