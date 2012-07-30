;;; scim-bridge-zh-tr.el

;; Copyright (C) 2008, 2009 S. Irie
;; Copyright (C) 2008, 2009 Andy Stewart

;; Author: S. Irie
;; Maintainer: S. Irie
;; Keywords: Input Method, i18n

(defconst scim-bridge-zh-tr-version "0.7.4")

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
;; which are written in Traditional Chinese.

;;
;; Installation:
;;
;; First, save this file (scim-bridge-zh-tr.el) and scim-bridge.el
;; in a directory listed in load-path, and then byte-compile them.
;;
;; Put the following in your .emacs file:
;;
;;   (require 'scim-bridge-zh-tr)
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
;;   (require 'scim-bridge-zh-tr)
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
 "智能通用輸入法平台")

(scim-set-variable-doc
 'scim-mode
 "切換 `scim-mode'.
直接設置這個變量没有效果;
使用 \\[customize] 或 函數 `scim-mode'.")

;; Basic settings
(scim-set-group-doc
 'scim-basic
 "操作設置, 例如模式設置和鍵盤設置")

(scim-set-variable-doc
 'scim-mode-local
 "如果值為非空 (non-nil), 輸入法內容會對每一個緩存進行注冊以使
各個緩存可以單獨切換輸入法. 否則, 輸入法進行全局切換.")

(scim-set-variable-doc
 'scim-imcontext-temporary-for-minibuffer
 "如果為值為非空 (non-nil), 當在 minibuffer 輸入內容時總是以 SCIM 的關閉狀態啟動.
這個選項隻有當選項 `scim-mode-local' 激活 (non-nil) 時才有效.")

(scim-set-variable-doc
 'scim-use-in-isearch-window
 "如果值為非空 (non-nil), SCIM 可以在 `isearch-mode' 中使用. 否則, 就不能.

注意這個選項需要 SCIM-Bridge 0.4.13 或更高的版本.")

(scim-set-variable-doc
 'scim-use-minimum-keymap
 "如果值為非空 (non-nil), 可打印字符事件在SCIM關閉時不處理.
這個選項在避免和其他Emacs-Lisp庫衝突時是有用的.

注意: 不要啟用此選項, 如果在你係統中 SCIM-Bridge 的版本低於 0.4.13,
否則 SCIM 不能接受你的輸入.")

(scim-set-variable-doc
 'scim-common-function-key-list
 "這個列表指定SCIM在直接插入模式和預編輯模式接管的按鍵.
還有, 你可以使用函數 `scim-define-common-key' 添加/刪除元素.
注意: 不要設置前綴按鍵在此選項, 例如 ESC 或 C-X.
如果你這樣做, 操作Emacs可能會變得不可能.")

(scim-set-variable-doc
 'scim-preedit-function-key-list
 "這個列表指定SCIM在預編輯區域存在時接管的按鍵.
你可以使用函數 `scim-define-preedit-key' 添加/刪除元素.")

(scim-set-variable-doc
 'scim-use-kana-ro-key
 "如果你使用日本 106 鍵盤和日本假名輸入法,
開啟這個選項 (non-nil) 使輸入假名字符 `ろ' 時不需要按住 shift 鍵.
這個選項可以使用shell命令 `xmodmap' 臨時地修改X窗口係統的鍵盤設置.")

(scim-set-variable-doc
 'scim-simultaneous-pressing-time
 "如果你在 SCIM-Anthy 上使用日本的拇指轉換輸入法,
指定的時間設置 (以秒計) 相當於SCIM-Anthy裡的 `同步按下時間' 設置.
在此時間間隔內的兩個按鍵會被作為一個同步按鍵發送到SCIM."
 '(choice (const :tag "空的" nil)
          (number :tag "間隔 (秒.)" :value 0.1)))

(scim-set-variable-doc
 'scim-undo-by-committed-string
 "如果這個值為空 (nil),
撤銷執行使一些較短的待發字符串鏈接在一起
或者按一定的範圍 (不超過20個字符) 劃分長的待發字符串.
否則撤銷在每一個待發字符串後執行.")

(scim-set-variable-doc
 'scim-clear-preedit-when-unexpected-event
 "如果這個值為非空 (non-nil), 當意想不到的事件發生在預編輯時候,
預編輯區域會被清空.
意想不到的事件是指, 例如, 用鼠標粘貼字符串.")

;; Appearance
(scim-set-group-doc
 'scim-appearance
 "外觀, 候選窗口, 等等.")

(scim-set-face-doc
 'scim-preedit-default-face
 "這個外觀顯示整個預編輯區域.")

(scim-set-face-doc
 'scim-preedit-underline-face
 "整個外觀對應於SCIM圖形設置工具中的 `下劃線' 文本屬性.")

(scim-set-face-doc
 'scim-preedit-highlight-face
 "整個外觀對應於SCIM圖形設置工具中的 `高亮' 文本屬性.")

(scim-set-face-doc
 'scim-preedit-reverse-face
 "整個外觀對應於SCIM圖形設置工具中的 `反轉' 文本屬性.")

(scim-set-variable-doc
 'scim-cursor-color
 "如果這個值是一個字符串, 它指定出 SCIM 開啟時的光標顏色.
如果這個值為一個細胞單元,
它的第一個和第二項元素分彆指定 SCIM 開啟和關閉時的光標顏色.
如果是一個列表,
它的第一, 第二和第三 (如果有的話) 項元素分彆指定 SCIM 開啟, 關閉和禁止時的光標顏色.
如果這個值為空 (nil) 意味著不控製光標的顏色.

注意這個選項需要 SCIM-Bridge 0.4.13 或更高版本."
 ;; ** Don't translate `:value' properties!! **
 '(choice (const :tag "空的" nil)
          (color :tag "紅色" :format "紅色 (%{sample%})\n" :value "red")
          (color :tag "藍色" :format "藍色 (%{sample%})\n" :value "blue")
          (color :tag "綠色" :format "綠色 (%{sample%})\n" :value "limegreen")
          (color :tag "其他" :value "red")
          (cons  :tag "其他 (開 . 關)"
                 (color :format "開: %v (%{sample%})  " :value "red")
                 (color :format "關: %v (%{sample%})\n" :value "blue"))
          (list  :tag "其他 (開 關)"
                 (color :format "開: %v (%{sample%})  " :value "red")
                 (color :format "關: %v (%{sample%})  禁止: none\n"
                        :value "blue"))
          (list  :tag "其他 (開 關 禁止)"
                 (color :format "開: %v (%{sample%})  " :value "red")
                 (color :format "關: %v (%{sample%})\n" :value "blue")
                 (color :format "禁止: %v (%{sample%})\n" :value "limegreen"))))

(scim-set-variable-doc
 'scim-isearch-cursor-type
 "這個選項指定當 `isearch-mode' 激活時所應用的光標形狀.
如果是一個整數0, 這個選項不會被激活並使光標形狀不會被改變.
詳細看 `光標類型'."
 '(choice (const :tag "默認 (0)" 0)
          (const :tag "使用框架參數" t)
          (const :tag "不顯示" nil)
          (const :tag "填充方塊" box)
          (const :tag "空心方塊" hollow)
          (const :tag "垂直條" bar)
          (cons :tag "垂直條 (指定寬度)"
                (const :format "" bar)
                (integer :tag "寬度" :value 1))
          (const :tag "水平條" hbar)
          (cons :tag "水平條 (指定高度)"
                (const :format "" hbar)
                (integer :tag "高度" :value 1))))

(scim-set-variable-doc
 'scim-cursor-type-for-candidate
 "這個選項指定預編輯窗口顯示候選變換時應用的光標形狀.
如果是一個整數0, 這個選項不會被激活並使光標形狀不會被改變.
詳細看 `光標類型'."
 '(choice (const :tag "默認 (0)" 0)
          (const :tag "使用框架參數" t)
          (const :tag "不顯示" nil)
          (const :tag "填充方塊" box)
          (const :tag "空心方塊" hollow)
          (const :tag "垂直條" bar)
          (cons :tag "垂直條 (指定寬度)"
                (const :format "" bar)
                (integer :tag "寬度" :value 1))
          (const :tag "水平條" hbar)
          (cons :tag "水平條 (指定高度)"
                (const :format "" hbar)
                (integer :tag "高度" :value 1))))

(scim-set-variable-doc
 'scim-put-cursor-on-candidate
 "如果這個值為非空 (non-nil), 當預編輯區域顯示候選轉換時,
光標放在選擇段的位置, 否則光標放在預編輯區域的末尾.")

(scim-set-variable-doc
 'scim-adjust-window-x-position
 "這個選項指定是否對候選窗口的位置進行調整以縱向排列內置候選和候選窗口.
如果這個值為 `gnome', 會使用 GNOME 桌面環境的字體大小進行調整.
否則, 如果該值是作為一個整數, 指定從正常位置的偏移的像素數量.
這個值不適合候選窗口總是顯示的輸入法, 比如SCIM拚音輸入法.
因為當光標在屏幕底部時, 窗口會隱藏光標."
 '(choice (const :tag "使用GNOME的字體大小" gnome)
          (integer :tag "指定像素數量" :value 24)
          (const :tag "關閉" nil)))

(scim-set-variable-doc
 'scim-adjust-window-y-position
 "如果這個值為非空 (non-nil), 會使用shell命令 `xwininfo'
調整候選窗口的垂直位置到到光標的底部.
否則, 不進行調整, 因此窗口可能會顯示在精確位置的下面一點.")

(scim-set-variable-doc
 'scim-prediction-window-position
 "(隻用於日本輸入法) 這個值以 (位置 . 調整) 的形式給出.
如果 `位置' 的值為非空 (non-nil), 預想的窗口會在預編輯區域的開頭顯示.
如果 `調整' 的值為非空 (non-nil), 橫向調整的位置和
`scim-adjust-window-x-position' 相同."
 '(cons
   (choice :tag "位置"
           (const :tag "預編輯區域的末尾" nil)
           (const :tag "預編輯區域的開頭" t))
   (choice :tag "調整"
           (const :tag "和轉換窗口一樣" t)
           (const :tag "關閉" nil))))

(scim-set-variable-doc
 'scim-mode-line-string
 "這個變量指定一個當 `scim-mode' 激活時出現在模式欄上的字符串, 其他情況不顯示.
這個字符串應該是一個以空格開頭的簡短字符串並描述 `scim-mode'.")

;; Advanced settings
(scim-set-group-doc
 'scim-expert
 "高級設置")

(scim-set-variable-doc
 'scim-focus-update-interval
 "窗口聚焦是以秒為周期進行檢查.
當SCIM關閉或輸入聚焦到其他應用程序時, 用 `scim-focus-update-interval-long'
給出的一個較慢的時間周期來替代.

注意當你係統裡 SCIM-Bridge 的版本低於 0.4.13 或你的窗口管理器不支持
`_NET_ACTIVE_WINDOW' 特性時這個值不能使用.
在這種情況, 任何時候都會使用`scim-focus-update-interval-long'.")

(scim-set-variable-doc
 'scim-focus-update-interval-long
 "這個值可能會替代 `scim-focus-update-interval' 並作為一個緩慢的時間周期來監測輸入聚焦.

詳情查看 `scim-focus-update-interval'.")

(scim-set-variable-doc
 'scim-kana-ro-x-keysym
 "當日本假名 RO 按鍵被使用時, 這個選項指定使用在X窗口係統中 KeySym 的替代名字.
這個程序設置反斜杠的 KeySym 替代名字以區分 yen-mark 按鍵.")

(scim-set-variable-doc
 'scim-kana-ro-key-symbol
 "當日本假名 RO 按鍵被使用時, 這個選項指定事件對應於 `scim-kana-ro-x-keysym'
給出的 KeySym 替代符號. 這個程序設置反斜杠的 KeySym 替代名字以區分 yen-mark 按鍵."
 '(choice (symbol)
          (const :tag "空的" nil)))

(scim-set-variable-doc
 'scim-bridge-timeout
 "指定從SCIM接受數據的最大等待時間.
浮點數形式用於表示秒, 整數形式用於表示毫秒.")

(scim-set-variable-doc
 'scim-config-file
 "SCIM 配置文件的名稱, 用於探測 SCIM 設置的改變.")

(scim-set-variable-doc
 'scim-meta-key-exists
 "如果鍵盤存在 mata 修飾鍵, 設置這個值為 t.
當自動檢測不順利時, 請在 `scim-bridge.el' 加載前手動設置這個值.")

(scim-set-variable-doc
 'scim-tmp-buffer-name
 "這個是和正在代理進行通信的緩存名字.")

(scim-set-variable-doc
 'scim-incompatible-mode-hooks
 "當這個鉤子運行, `scim-mode-map' 變為無效.")

(scim-set-variable-doc
 'scim-undo-command-list
 "當預編輯區域存在時這些命令無法使用.")

;; Functions
(scim-set-function-doc
 'scim-set-group-doc
 "改變 GROUP 的文檔字符串為 STRING.
如果字符串為空 (nil), 文檔字符串保留原來的.")

(scim-set-function-doc
 'scim-set-variable-doc
 "改變 VARIABLE 的文檔字符串為 STRING.
如果字符串為空 (nil), 文檔字符串保留原來的.
如果 CUSTOM-TYPE 為非空 (non-nil), 它設置為 VARIABLE 的 `custom-type' 屬性,
相當於 `defcustom' 中的 `:type' 關鍵字.")

(scim-set-function-doc
 'scim-set-face-doc
 "改變 FACE 的文檔字符串為 STRING.
如果字符串為空 (nil), 文檔字符串保留原來的.")

(scim-set-function-doc
 'scim-define-common-key
 "指定SCIM隨時接管的按鍵事件.
如果 HANDLE 為非空 (non-nil), SCIM按給出的按鍵處理按鍵事件.
當 KEY 作為一個數組時, 它並不表示按鍵序列, 而是單一按鍵的多個定義.
必須調用函數 `scim-update-key-bindings' 或重新啟動 `scim-mode'
才能使這些設置生效.")

(scim-set-function-doc
 'scim-define-preedit-key
 "指定於編輯時SCIM接管的按鍵事件.
如果 HANDLE 為非空 (non-nil), SCIM按給出的按鍵處理按鍵事件.
當 KEY 作為一個數組時, 它並不表示按鍵序列, 而是單一按鍵的多個定義.
必須調用函數 `scim-update-key-bindings' 或重新啟動 `scim-mode'
才能使這些設置生效.")

(scim-set-function-doc
 'scim-reset-imcontext-statuses
 "重新設置每個緩存中保存輸入狀態的變量以糾正不適當的光標顏色.
這個函數可能會在剛使用 SCIM 圖形設置工具後調用.")

(scim-set-function-doc
 'scim-get-frame-extents
 "以 (左邊 右邊 頂部 底部) 的形式返回框架邊緣的像素寬度.
這裡 `頂部' 是指定框架標題欄的高度.")

(scim-set-function-doc
 'scim-frame-header-height
 "返回菜單欄和工具欄的總像素高度.
這個函數返回的值並不是那麼精確的.")

(scim-set-function-doc
 'scim-real-frame-header-height
 "返回菜單欄和工具欄的總的像素高度.
這個函數返回的值非常精確, 但是這個函數比 `scim-frame-header-height' 要慢很多.")

(scim-set-function-doc
 'scim-compute-pixel-position
 "以 (X軸 . Y軸) 的形式返回屏幕的像素位置.
這個值顯示字符左上角的坐標.")

(scim-set-function-doc
 'scim-get-gnome-font-size
 "返回GNOME環境中應用字體的像素大小.
設置屏幕分辨率 (點/英寸) 並能夠使用shell命令 `gconftool-2' 是必需的.
如果不是這樣, 這個函數返回零.")

(scim-set-function-doc
 'scim-get-active-window-id
 "返回窗口係統前台窗口的 ID.
也就是輸入聚焦的窗口.")

(scim-set-function-doc
 'scim-enable-isearch
 "使SCIM可以和 `isearch-mode' 使用.")

(scim-set-function-doc
 'scim-disable-isearch
 "使SCIM不可以和 `isearch-mode' 使用.")

(scim-set-function-doc
 'scim-mode
 "切換SCIM主模式 (scim-mode).
如果可選參數 ARG 是正數, 開啟 `scim-mode',
否則, 關閉它.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define functions useful only for Traditional Chinese
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings

;; Functions

;;  (No such functions)

(provide 'scim-bridge-zh-tr)

;;;
;;; scim-bridge-zh-tr.el ends here
