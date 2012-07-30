;;; scim-bridge-zh-si.el

;; Copyright (C) 2008, 2009 S. Irie
;; Copyright (C) 2008, 2009 Andy Stewart

;; Author: S. Irie
;; Maintainer: S. Irie
;; Keywords: Input Method, i18n

(defconst scim-bridge-zh-si-version "0.7.4")

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.

;; It is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:

;; The Smart Common Input Method platform (SCIM) is an input
;; method (IM) platform containing support for more than thirty
;; languages (CJK and many European languages) for POSIX-style
;; operating systems including Linux and BSD.

;; scim-bridge.el is SCIM-Bridge client for GNU Emacs. It is,
;; however, not part of official SCIM-Bridge.

;; This program changes the documentation strings of the variables
;; and functions defined in scim-bridge.el into the equivalents
;; which are written in Simplified Chinese.

;;
;; Installation:
;;
;; First, save this file (scim-bridge-zh-si.el) and scim-bridge.el
;; in a directory listed in load-path, and then byte-compile them.
;;
;; Put the following in your .emacs file:
;;
;;   (require 'scim-bridge-zh-si)
;;
;; After that, execute Emacs by typing on command line:
;;
;;   XMODIFIERS=@im=none emacs
;;
;; and turn on scim-mode:
;;
;;   M-x scim-mode
;;
;;
;; Here is the example of settings in .emacs:
;;
;;   (require 'scim-bridge-zh-si)
;;   ;; Turn on scim-mode automatically after loading .emacs
;;   (add-hook 'after-init-hook 'scim-mode-on)
;;   ;; Use C-SPC for Set Mark command
;;   (scim-define-common-key ?\C-\  nil)
;;   ;; Use C-/ for Undo command
;;   (scim-define-common-key ?\C-/ nil)
;;   ;; Change cursor color depending on SCIM status
;;   (setq scim-cursor-color '("red" "blue" "limegreen"))
;;
;;
;; Note that this program requires GNU Emacs 22 or later, and
;; doesn't work when Emacs is running on terminal emulator.
;;

;; History:
;; 2009-01-29  S. Irie
;;         * Modify description of installation
;;         * Version 0.7.4
;;
;; 2009-01-03  S. Irie
;;         * Add/modify translations
;;         * Version 0.7.3.1
;;
;; 2008-12-28  S. Irie
;;         * Add/modify/delete translations
;;         * Version 0.7.3
;;
;; 2008-12-06  S. Irie
;;         * Add/modify/delete translations
;;         * Version 0.7.2
;;
;; 2008-10-20  S. Irie
;;         * Add/modify translations
;;         * Version 0.7.1
;;
;; 2008-10-08  S. Irie
;;         * First release
;;         * Version 0.7.0.1
;;
;; 2008-10-04  Andy Stewart
;;         * Translated from scim-bridge-en.el
;;         * Version 0.7.0

;; ToDo:

;;; Code:

(require 'scim-bridge)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Apply translations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(scim-set-group-doc
 'scim
 "智能通用输入法平台")

(scim-set-variable-doc
 'scim-mode
 "切换 `scim-mode'.
直接设置这个变量没有效果;
使用 \\[customize] 或 函数 `scim-mode'.")

;; Basic settings
(scim-set-group-doc
 'scim-basic
 "操作设置, 例如模式设置和键盘设置")

(scim-set-variable-doc
 'scim-mode-local
 "如果值为非空 (non-nil), 输入法内容会对每一个缓存进行注册以使
各个缓存可以单独切换输入法. 否则, 输入法进行全局切换.")

(scim-set-variable-doc
 'scim-imcontext-temporary-for-minibuffer
 "如果为值为非空 (non-nil), 当在 minibuffer 输入内容时总是以 SCIM 的关闭状态启动.
这个选项只有当选项 `scim-mode-local' 激活 (non-nil) 时才有效.")

(scim-set-variable-doc
 'scim-use-in-isearch-window
 "如果值为非空 (non-nil), SCIM 可以在 `isearch-mode' 中使用. 否则, 就不能.

注意这个选项需要 SCIM-Bridge 0.4.13 或更高的版本.")

(scim-set-variable-doc
 'scim-use-minimum-keymap
 "如果值为非空 (non-nil), 可打印字符事件在SCIM关闭时不处理.
这个选项在避免和其他Emacs-Lisp库冲突时是有用的.

注意: 不要启用此选项, 如果在你系统中 SCIM-Bridge 的版本低于 0.4.13,
否则 SCIM 不能接受你的输入.")

(scim-set-variable-doc
 'scim-common-function-key-list
 "这个列表指定SCIM在直接插入模式和预编辑模式接管的按键.
还有, 你可以使用函数 `scim-define-common-key' 添加/删除元素.
注意: 不要设置前缀按键在此选项, 例如 ESC 或 C-X.
如果你这样做, 操作Emacs可能会变得不可能.")

(scim-set-variable-doc
 'scim-preedit-function-key-list
 "这个列表指定SCIM在预编辑区域存在时接管的按键.
你可以使用函数 `scim-define-preedit-key' 添加/删除元素.")

(scim-set-variable-doc
 'scim-use-kana-ro-key
 "如果你使用日本 106 键盘和日本假名输入法,
开启这个选项 (non-nil) 使输入假名字符 `ろ' 时不需要按住 shift 键.
这个选项可以使用shell命令 `xmodmap' 临时地修改X窗口系统的键盘设置.")

(scim-set-variable-doc
 'scim-simultaneous-pressing-time
 "如果你在 SCIM-Anthy 上使用日本的拇指转换输入法,
指定的时间设置 (以秒计) 相当于SCIM-Anthy里的 `同步按下时间' 设置.
在此时间间隔内的两个按键会被作为一个同步按键发送到SCIM."
 '(choice (const :tag "空的" nil)
          (number :tag "间隔 (秒.)" :value 0.1)))

(scim-set-variable-doc
 'scim-undo-by-committed-string
 "如果这个值为空 (nil),
撤销执行使一些较短的待发字符串链接在一起
或者按一定的范围 (不超过20个字符) 划分长的待发字符串.
否则撤销在每一个待发字符串后执行.")

(scim-set-variable-doc
 'scim-clear-preedit-when-unexpected-event
 "如果这个值为非空 (non-nil), 当意想不到的事件发生在预编辑时候,
预编辑区域会被清空.
意想不到的事件是指, 例如, 用鼠标粘贴字符串.")

;; Appearance
(scim-set-group-doc
 'scim-appearance
 "外观, 候选窗口, 等等.")

(scim-set-face-doc
 'scim-preedit-default-face
 "这个外观显示整个预编辑区域.")

(scim-set-face-doc
 'scim-preedit-underline-face
 "整个外观对应于SCIM图形设置工具中的 `下划线' 文本属性.")

(scim-set-face-doc
 'scim-preedit-highlight-face
 "整个外观对应于SCIM图形设置工具中的 `高亮' 文本属性.")

(scim-set-face-doc
 'scim-preedit-reverse-face
 "整个外观对应于SCIM图形设置工具中的 `反转' 文本属性.")

(scim-set-variable-doc
 'scim-cursor-color
 "如果这个值是一个字符串, 它指定出 SCIM 开启时的光标颜色.
如果这个值为一个细胞单元,
它的第一个和第二项元素分别指定 SCIM 开启和关闭时的光标颜色.
如果是一个列表,
它的第一, 第二和第三 (如果有的话) 项元素分别指定 SCIM 开启, 关闭和禁止时的光标颜色.
如果这个值为空 (nil) 意味着不控制光标的颜色.

注意这个选项需要 SCIM-Bridge 0.4.13 或更高版本."
 ;; ** Don't translate `:value' properties!! **
 '(choice (const :tag "空的" nil)
          (color :tag "红色" :format "红色 (%{sample%})\n" :value "red")
          (color :tag "蓝色" :format "蓝色 (%{sample%})\n" :value "blue")
          (color :tag "绿色" :format "绿色 (%{sample%})\n" :value "limegreen")
          (color :tag "其他" :value "red")
          (cons  :tag "其他 (开 . 关)"
                 (color :format "开: %v (%{sample%})  " :value "red")
                 (color :format "关: %v (%{sample%})\n" :value "blue"))
          (list  :tag "其他 (开 关)"
                 (color :format "开: %v (%{sample%})  " :value "red")
                 (color :format "关: %v (%{sample%})  禁止: none\n"
                        :value "blue"))
          (list  :tag "其他 (开 关 禁止)"
                 (color :format "开: %v (%{sample%})  " :value "red")
                 (color :format "关: %v (%{sample%})\n" :value "blue")
                 (color :format "禁止: %v (%{sample%})\n" :value "limegreen"))))

(scim-set-variable-doc
 'scim-isearch-cursor-type
 "这个选项指定当 `isearch-mode' 激活时所应用的光标形状.
如果是一个整数0, 这个选项不会被激活并使光标形状不会被改变.
详细看 `光标类型'."
 '(choice (const :tag "默认 (0)" 0)
          (const :tag "使用框架参数" t)
          (const :tag "不显示" nil)
          (const :tag "填充方块" box)
          (const :tag "空心方块" hollow)
          (const :tag "垂直条" bar)
          (cons :tag "垂直条 (指定宽度)"
                (const :format "" bar)
                (integer :tag "宽度" :value 1))
          (const :tag "水平条" hbar)
          (cons :tag "水平条 (指定高度)"
                (const :format "" hbar)
                (integer :tag "高度" :value 1))))

(scim-set-variable-doc
 'scim-cursor-type-for-candidate
 "这个选项指定预编辑窗口显示候选变换时应用的光标形状.
如果是一个整数0, 这个选项不会被激活并使光标形状不会被改变.
详细看 `光标类型'."
 '(choice (const :tag "默认 (0)" 0)
          (const :tag "使用框架参数" t)
          (const :tag "不显示" nil)
          (const :tag "填充方块" box)
          (const :tag "空心方块" hollow)
          (const :tag "垂直条" bar)
          (cons :tag "垂直条 (指定宽度)"
                (const :format "" bar)
                (integer :tag "宽度" :value 1))
          (const :tag "水平条" hbar)
          (cons :tag "水平条 (指定高度)"
                (const :format "" hbar)
                (integer :tag "高度" :value 1))))

(scim-set-variable-doc
 'scim-put-cursor-on-candidate
 "如果这个值为非空 (non-nil), 当预编辑区域显示候选转换时,
光标放在选择段的位置, 否则光标放在预编辑区域的末尾.")

(scim-set-variable-doc
 'scim-adjust-window-x-position
 "这个选项指定是否对候选窗口的位置进行调整以纵向排列内置候选和候选窗口.
如果这个值为 `gnome', 会使用 GNOME 桌面环境的字体大小进行调整.
否则, 如果该值是作为一个整数, 指定从正常位置的偏移的像素数量.
这个值不适合候选窗口总是显示的输入法, 比如SCIM拼音输入法.
因为当光标在屏幕底部时, 窗口会隐藏光标."
 '(choice (const :tag "使用GNOME的字体大小" gnome)
          (integer :tag "指定像素数量" :value 24)
          (const :tag "关闭" nil)))

(scim-set-variable-doc
 'scim-adjust-window-y-position
 "如果这个值为非空 (non-nil), 会使用shell命令 `xwininfo'
调整候选窗口的垂直位置到到光标的底部.
否则, 不进行调整, 因此窗口可能会显示在精确位置的下面一点.")

(scim-set-variable-doc
 'scim-prediction-window-position
 "(只用于日本输入法) 这个值以 (位置 . 调整) 的形式给出.
如果 `位置' 的值为非空 (non-nil), 预想的窗口会在预编辑区域的开头显示.
如果 `调整' 的值为非空 (non-nil), 横向调整的位置和
`scim-adjust-window-x-position' 相同."
 '(cons
   (choice :tag "位置"
           (const :tag "预编辑区域的末尾" nil)
           (const :tag "预编辑区域的开头" t))
   (choice :tag "调整"
           (const :tag "和转换窗口一样" t)
           (const :tag "关闭" nil))))

(scim-set-variable-doc
 'scim-mode-line-string
 "这个变量指定一个当 `scim-mode' 激活时出现在模式栏上的字符串, 其他情况不显示.
这个字符串应该是一个以空格开头的简短字符串并描述 `scim-mode'.")

;; Advanced settings
(scim-set-group-doc
 'scim-expert
 "高级设置")

(scim-set-variable-doc
 'scim-focus-update-interval
 "窗口聚焦是以秒为周期进行检查.
当SCIM关闭或输入聚焦到其他应用程序时, 用 `scim-focus-update-interval-long'
给出的一个较慢的时间周期来替代.

注意当你系统里 SCIM-Bridge 的版本低于 0.4.13 或你的窗口管理器不支持
`_NET_ACTIVE_WINDOW' 特性时这个值不能使用.
在这种情况, 任何时候都会使用`scim-focus-update-interval-long'.")

(scim-set-variable-doc
 'scim-focus-update-interval-long
 "这个值可能会替代 `scim-focus-update-interval' 并作为一个缓慢的时间周期来监测输入聚焦.

详情查看 `scim-focus-update-interval'.")

(scim-set-variable-doc
 'scim-kana-ro-x-keysym
 "当日本假名 RO 按键被使用时, 这个选项指定使用在X窗口系统中 KeySym 的替代名字.
这个程序设置反斜杠的 KeySym 替代名字以区分 yen-mark 按键.")

(scim-set-variable-doc
 'scim-kana-ro-key-symbol
 "当日本假名 RO 按键被使用时, 这个选项指定事件对应于 `scim-kana-ro-x-keysym'
给出的 KeySym 替代符号. 这个程序设置反斜杠的 KeySym 替代名字以区分 yen-mark 按键."
 '(choice (symbol)
          (const :tag "空的" nil)))

(scim-set-variable-doc
 'scim-bridge-timeout
 "指定从SCIM接受数据的最大等待时间.
浮点数形式用于表示秒, 整数形式用于表示毫秒.")

(scim-set-variable-doc
 'scim-config-file
 "SCIM 配置文件的名称, 用于探测 SCIM 设置的改变.")

(scim-set-variable-doc
 'scim-meta-key-exists
 "如果键盘存在 mata 修饰键, 设置这个值为 t.
当自动检测不顺利时, 请在 `scim-bridge.el' 加载前手动设置这个值.")

(scim-set-variable-doc
 'scim-tmp-buffer-name
 "这个是和正在代理进行通信的缓存名字.")

(scim-set-variable-doc
 'scim-incompatible-mode-hooks
 "当这个钩子运行, `scim-mode-map' 变为无效.")

(scim-set-variable-doc
 'scim-undo-command-list
 "当预编辑区域存在时这些命令无法使用.")

;; Functions
(scim-set-function-doc
 'scim-set-group-doc
 "改变 GROUP 的文档字符串为 STRING.
如果字符串为空 (nil), 文档字符串保留原来的.")

(scim-set-function-doc
 'scim-set-variable-doc
 "改变 VARIABLE 的文档字符串为 STRING.
如果字符串为空 (nil), 文档字符串保留原来的.
如果 CUSTOM-TYPE 为非空 (non-nil), 它设置为 VARIABLE 的 `custom-type' 属性,
相当于 `defcustom' 中的 `:type' 关键字.")

(scim-set-function-doc
 'scim-set-face-doc
 "改变 FACE 的文档字符串为 STRING.
如果字符串为空 (nil), 文档字符串保留原来的.")

(scim-set-function-doc
 'scim-define-common-key
 "指定SCIM随时接管的按键事件.
如果 HANDLE 为非空 (non-nil), SCIM按给出的按键处理按键事件.
当 KEY 作为一个数组时, 它并不表示按键序列, 而是单一按键的多个定义.
必须调用函数 `scim-update-key-bindings' 或重新启动 `scim-mode'
才能使这些设置生效.")

(scim-set-function-doc
 'scim-define-preedit-key
 "指定于编辑时SCIM接管的按键事件.
如果 HANDLE 为非空 (non-nil), SCIM按给出的按键处理按键事件.
当 KEY 作为一个数组时, 它并不表示按键序列, 而是单一按键的多个定义.
必须调用函数 `scim-update-key-bindings' 或重新启动 `scim-mode'
才能使这些设置生效.")

(scim-set-function-doc
 'scim-reset-imcontext-statuses
 "重新设置每个缓存中保存输入状态的变量以纠正不适当的光标颜色.
这个函数可能会在刚使用 SCIM 图形设置工具后调用.")

(scim-set-function-doc
 'scim-get-frame-extents
 "以 (左边 右边 顶部 底部) 的形式返回框架边缘的像素宽度.
这里 `顶部' 是指定框架标题栏的高度.")

(scim-set-function-doc
 'scim-frame-header-height
 "返回菜单栏和工具栏的总像素高度.
这个函数返回的值并不是那么精确的.")

(scim-set-function-doc
 'scim-real-frame-header-height
 "返回菜单栏和工具栏的总的像素高度.
这个函数返回的值非常精确, 但是这个函数比 `scim-frame-header-height' 要慢很多.")

(scim-set-function-doc
 'scim-compute-pixel-position
 "以 (X轴 . Y轴) 的形式返回屏幕的像素位置.
这个值显示字符左上角的坐标.")

(scim-set-function-doc
 'scim-get-gnome-font-size
 "返回GNOME环境中应用字体的像素大小.
设置屏幕分辨率 (点/英寸) 并能够使用shell命令 `gconftool-2' 是必需的.
如果不是这样, 这个函数返回零.")

(scim-set-function-doc
 'scim-get-active-window-id
 "返回窗口系统前台窗口的 ID.
也就是输入聚焦的窗口.")

(scim-set-function-doc
 'scim-enable-isearch
 "使SCIM可以和 `isearch-mode' 使用.")

(scim-set-function-doc
 'scim-disable-isearch
 "使SCIM不可以和 `isearch-mode' 使用.")

(scim-set-function-doc
 'scim-mode
 "切换SCIM主模式 (scim-mode).
如果可选参数 ARG 是正数, 开启 `scim-mode',
否则, 关闭它.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define functions useful only for Simplified Chinese
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings

;; Functions

;;  (No such functions)

(provide 'scim-bridge-zh-si)

;;;
;;; scim-bridge-zh-si.el ends here
