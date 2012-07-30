;;; scim-bridge-ja.el

;; Copyright (C) 2008, 2009 S. Irie

;; Author: S. Irie
;; Maintainer: S. Irie
;; Keywords: Input Method, i18n

(defconst scim-bridge-ja-version "0.7.4")

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

;; SCIM (Smart Common Input Method) は 30以上の言語 (CJK と多くの
;; ヨーロッパ言語) をサポートする POSIX スタイルのオペレーティングシステム
;; (Linux や BSD) のためのインプットメソッド (IM) プラットフォームです。

;; scim-brifge.el はEmacs のための SCIM-Bridge クライアントです。
;; ただし、これは公式の SCIM-Bridge の一部ではありません。

;; このプログラムをロードすることによって、 scim-bridge.el で定義される変数
;; および関数の説明文字列が日本語で書かれたものに差し替えられ、また日本語入力
;; のためのいくつかの便利なコマンドが使用できるようになります。

;;
;; Installation:
;;
;; 初めに、このファイル (scim-bridge-ja.el) 及び scim-bridge.el を
;; パスの通ったディレクトリに保存し、バイトコンパイルして下さい。
;;
;; 以下の行を .emacs ファイルに追加します。
;;
;;   (require 'scim-bridge-ja)
;;
;; Emacs を起動するときは、コマンドラインから以下のように打ち込んで下さい。
;;
;;   XMODIFIERS=@im=none emacs
;;
;; 起動したら、scim-mode を ON にします。
;;
;;   M-x scim-mode
;;
;;
;; .emacs ファイルの設定例です。
;;
;;   (require 'scim-bridge-ja)
;;   ;; .emacs 読込み後、 scim-mode を自動的に ON にする
;;   (add-hook 'after-init-hook 'scim-mode-on)
;;   ;; C-SPC は Set Mark に使う
;;   (scim-define-common-key ?\C-\  nil)
;;   ;; C-/ は Undo に使う
;;   (scim-define-common-key ?\C-/ nil)
;;   ;; SCIMの状態によってカーソル色を変化させる
;;   (setq scim-cursor-color '("red" "blue" "limegreen"))
;;
;; 以下は日本語入力向けの設定です。.emacs ファイルに追加します。
;;
;;   ;; C-j で半角英数モードをトグルする
;;   (scim-define-common-key ?\C-j t)
;;   ;; SCIM-Anthy 使用時に、copy-region-as-kill しなくても再変換できるようにする
;;   (scim-define-common-key 'S-henkan nil)
;;   (global-set-key [S-henkan] 'scim-anthy-reconvert-region)
;;   ;; SCIM がオフのままローマ字入力してしまった時に、プリエディットに入れ直す
;;   (global-set-key [C-henkan] 'scim-transfer-romaji-into-preedit)
;;
;;
;; 注意：このプログラムは GNU Emacs 22 以降のバージョンで動作します。
;; また、端末エミュレータ上では動作しません。
;;

;; History:
;; 2009-01-29  S. Irie
;;         * Add support for table.el
;;         * Modify description of installation
;;         * Version 0.7.4
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
;; 2008-10-04  S. Irie
;;         * Revised Entirely
;;         * Add/modify translations
;;         * Version 0.7.0
;;
;; 2008-09-08  S. Irie
;;         * Modify translation
;;         * Version 0.6.9
;;
;; 2008-09-05  S. Irie
;;         * Version 0.6.8
;;
;; 2008-07-26  S. Irie
;;         * Some unimportant changes
;;         * Version 0.6.7
;;
;; 2008-06-12  S. Irie
;;         * Add/modify translations
;;         * Version 0.6.6
;;
;; 2008-06-05  S. Irie
;;         * Change specification for `scim-transfer-romaji-into-preedit'
;;         * Version 0.6.5
;;
;; 2008-06-01  S. Irie
;;         * Add some convenient commands for Japanese IM
;;         * Bug fix
;;         * Version 0.6.4
;;
;; 2008-05-24  S. Irie
;;         * Add translations
;;         * Bug fix
;;         * Version 0.6.3
;;
;; 2008-05-22  S. Irie
;;         * Modify description of kana-RO key
;;         * Version 0.6.2
;;
;; 2008-05-20  S. Irie
;;         * Add/modify translations
;;         * Version 0.6.1
;;
;; 2008-05-18  S. Irie
;;         * Experimental first release
;;         * Version 0.6.0
;;
;; 2008-05-15  S. Irie
;;         * Version 0.5.0

;; ToDo:

;;; Code:

(require 'scim-bridge)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Apply translations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(scim-set-group-doc
 'scim
 "洗練された多言語入力プラットフォーム")

(scim-set-variable-doc
 'scim-mode
 "scim-mode の ON/OFF を切り替えます。
この変数に値を直接代入しても正しい動作はしませんので、
 \\[customize] あるいは関数 `scim-mode' を用いてください。")

;; Basic settings
(scim-set-group-doc
 'scim-basic
 "基本的な入力方法の設定（モードの切り替え、キーボードなど）")

(scim-set-variable-doc
 'scim-mode-local
 "この値が nil 以外ならば、入力のモードを各バッファごとに切り替えること
ができるように、IMコンテクストが各々のバッファについて登録されます。そうで
なければ、入力のモードはグローバルに切り替えられます。")

(scim-set-variable-doc
 'scim-imcontext-temporary-for-minibuffer
 "nil 以外ならば、ミニバッファにおける入力では一時的なIMコンテクストが
用いられるので、常に SCIM がオフの状態で入力が開始されます。このオプション
は、`scim-mode-local' が活性 (non-nil) である場合のみ有効です。")

(scim-set-variable-doc
 'scim-use-in-isearch-window
 "nil 以外ならば、isearch-mode で SCIM が使用できます。そうでなければ、
使用できません。

注意：このオプションは SCIM-Bridge の バージョン 0.4.13 以降を必要とします。")

(scim-set-variable-doc
 'scim-use-minimum-keymap
 "nil 以外ならば、SCIM がオフの時に印字可能文字のキーイベントは SCIM では
処理されません。このオプションは他の Emacs Lisp ライブラリとの衝突を回避する
のに役立ちます。

注意：もし SCIM-Bridge のバージョンが 0.4.13 よりも古いなら、このオプション
を活性化しないでください。さもないと、SCIM はキー入力を受け取れません。")

(scim-set-variable-doc
 'scim-common-function-key-list
 "直接入力時及びプリエディット時において、SCIM がどのキーイベントを
受けとるかを表すリストです。このリストへの要素の追加・削除は、関数
`scim-define-common-key' を用いて行うこともできます。
注意：このオプションでは ESC や C-x などのプレフィックスキーを設定しないで
ください。もし設定すると、Emacs が操作不能になるかもしれません。")

(scim-set-variable-doc
 'scim-preedit-function-key-list
 "プリエディット領域が存在する時に、SCIM がどのキーイベントを
受けとるかを表すリストです。このリストへの要素の追加・削除は、関数
`scim-define-preedit-key' を用いて行うこともできます。")

(scim-set-variable-doc
 'scim-use-kana-ro-key
 "もし jp-106 キーボードを用いて日本語のかな入力方式を行うなら、この
オプションをオン(nil 以外)にして、シフトキーを押さなくても仮名文字の「ろ」
を入力できるようにしてください。
　このオプションは、Xウインドウシステムの設定をシェルコマンドの `xmodmap' を
用いて一時的に書き換えることによって有効化されます。")

(scim-set-variable-doc
 'scim-simultaneous-pressing-time
 "もし SCIM-Anthy で日本語の親指シフト入力方式を使用するなら、
SCIM-Anthy の設定における「同時打鍵時間」に相当する時間間隔（秒）を指定して
下さい。この時間内の2つのキー入力は、同時キー入力として SCIM に送られます。"
 '(choice (const :tag "なし" nil)
	  (number :tag "間隔（秒）"
		  :value 0.1)))

(scim-set-variable-doc
 'scim-undo-by-committed-string
 "この値が nil ならば、アンドゥを行うときに短い確定済み文字列が20文字を
越えない範囲で連結され、逆に長い確定済み文字列は20文字ごとに分割されます。
値が nil 以外であれば、アンドゥは確定した文字列ごとに行われます。")

(scim-set-variable-doc
 'scim-clear-preedit-when-unexpected-event
 "この値が nil 以外ならば、プリエディット中に予期せぬイベントが発生した
場合に、プリエディット領域が消去されます。予期せぬイベントとは、例えばマウス
を使った文字列の貼り付けなどです。")

;; Appearance
(scim-set-group-doc
 'scim-appearance
 "外観の設定（フェイス、変換候補ウインドウなど）")

(scim-set-face-doc
 'scim-preedit-default-face
 "このフェイスはプリエディット領域の全体を表します。")

(scim-set-face-doc
 'scim-preedit-underline-face
 "SCIM GUIセットアップユーティリティにおけるテキスト属性「下線」に対応する
フェイスです。")

(scim-set-face-doc
 'scim-preedit-highlight-face
 "SCIM GUIセットアップユーティリティにおけるテキスト属性「強調」に対応する
フェイスです。")

(scim-set-face-doc
 'scim-preedit-reverse-face
 "SCIM GUIセットアップユーティリティにおけるテキスト属性「反転」に対応する
フェイスです。")

(scim-set-variable-doc
 'scim-cursor-color
 "値が文字列ならば、SCIM がオンである時に適用されるカーソル色を表します。
コンスセルならば、その car および cdr はそれぞれ SCIM がオンあるいはオフである
時のカーソル色となります。リストならば、第1要素、第2要素、および第3要素（もし
あれば）はそれぞれ、SCIM がオン、オフ、および無効化の状態に対応します。
値が nil ならば、カーソル色の制御は全く行われません。

注意：このオプションは SCIM-Bridge の バージョン 0.4.13 以降を必要とします。"
 ;; ** Don't translate `:value' properties!! **
 '(choice (const :tag "なし（nil）" nil)
	  (color :tag "赤" :format "赤 (%{sample%})\n" :value "red")
	  (color :tag "青" :format "青 (%{sample%})\n" :value "blue")
	  (color :tag "緑" :format "緑 (%{sample%})\n" :value "limegreen")
	  (color :tag "その他" :value "red")
	  (cons  :tag "その他 (ON . OFF)"
		 (color :format "オン時: %v (%{sample%})  " :value "red")
		 (color :format "オフ時: %v (%{sample%})\n" :value "blue"))
	  (list  :tag "その他 (ON OFF)"
		 (color :format "オン時: %v (%{sample%})  " :value "red")
		 (color :format "オフ時: %v (%{sample%})  無効化時: なし\n"
			:value "blue"))
	  (list  :tag "その他 (ON OFF DISABLED)"
		 (color :format "オン時: %v (%{sample%})  " :value "red")
		 (color :format "オフ時: %v (%{sample%})\n" :value "blue")
		 (color :format "無効化時: %v (%{sample%})\n" :value "limegreen"))))

(scim-set-variable-doc
 'scim-isearch-cursor-type
 "このオプションは isearch-mode の活性化時に適用されるカーソル形状を指定し
ます。値が整数の 0 であると、このオプションは不活性となり、カーソル形状は変え
られません。。
`cursor-type' をご覧下さい。"
 '(choice (const :tag "標準（0）" 0)
	  (const :tag "フレームのパラメータを使用" t)
	  (const :tag "表示しない" nil)
	  (const :tag "塗りつぶされた箱型" box)
	  (const :tag "輪郭だけの箱型" hollow)
	  (const :tag "縦の棒型" bar)
	  (cons :tag "縦の棒型（幅を指定）"
		(const :format "" bar)
		(integer :tag "幅" :value 1))
	  (const :tag "水平の棒型" hbar)
	  (cons :tag "水平の棒型（高さを指定）"
		(const :format "" hbar)
		(integer :tag "高さ" :value 1))))

(scim-set-variable-doc
 'scim-cursor-type-for-candidate
 "このオプションはプリエディット領域に変換候補が表示されている時に適用され
るカーソル形状を指定します。値が整数の 0 であると、このオプションは不活性と
なり、カーソル形状は変えられません。
`cursor-type' をご覧下さい。"
 '(choice (const :tag "標準（0）" 0)
	  (const :tag "フレームのパラメータを使用" t)
	  (const :tag "表示しない" nil)
	  (const :tag "塗りつぶされた箱型" box)
	  (const :tag "輪郭だけの箱型" hollow)
	  (const :tag "縦の棒型" bar)
	  (cons :tag "縦の棒型（幅を指定）"
		(const :format "" bar)
		(integer :tag "幅" :value 1))
	  (const :tag "水平の棒型" hbar)
	  (cons :tag "水平の棒型（高さを指定）"
		(const :format "" hbar)
		(integer :tag "高さ" :value 1))))

(scim-set-variable-doc
 'scim-put-cursor-on-candidate
 "プリエディット領域に変換候補が表示されている時、このオプションが nil
以外ならば選択している文節にカーソルが表示されます。そうでなければ、カーソルは
プリエディット領域の末尾に置かれます。")

(scim-set-variable-doc
 'scim-adjust-window-x-position
 "このオプションは、変換候補ウインドウの位置を、ウインドウ内の変換候補が
プリエディット領域の変換候補と垂直方向に並ぶように調整するかどうかということを
指定します。この値が `gnome' ならば、GNOMEデスクトップ環境でのフォントサイズ
の設定値を用いて調整します。一方、値が整数で与えられると、その数はウインドウを
通常の位置からずらす量をピクセル数で表します。
　このオプションは、候補ウインドウが常時表示されるようなタイプの入力方法、
例えば SCIM-pinyin（中国語）等には適していません。なぜなら、入力位置が
画面の下の方にある時には候補ウインドウがカーソルを覆い隠してしまう可能性が
あるからです。"
 '(choice (const :tag "GNOME のフォント設定を利用" gnome)
	  (integer :tag "ピクセル数を指定" :value 24)
	  (const :tag "off" nil)))

(scim-set-variable-doc
 'scim-adjust-window-y-position
 "この値が nil 以外ならば、変換候補ウインドウの垂直方向の表示位置が、シェル
コマンドの `xwininfo' を利用して調節されます。そうでなければ調整は行われず、
ウインドウが正確な位置よりも少し下にずれるかもしれません。")

(scim-set-variable-doc
 'scim-prediction-window-position
 "(日本語入力時のみ) この変数の値は (POS . ADJ) というコンスセルの形で与
えられます。もし POS の値が が nil 以外ならば、予測候補ウインドウがプリエディ
ット領域の先頭部分の下に表示されます。ADJ の値が nil 以外ならば、水平方向の
位置が変換候補ウインドウと同じように微調整されます。"
 '(cons
   (choice :tag "位置（POS）"
	   (const :tag "プリエディット領域の末尾" nil)
	   (const :tag "プリエディット領域の先頭" t))
   (choice :tag "微調整（ADJ）"
	   (const :tag "変換候補ウインドウと同様にする" t)
	   (const :tag "off" nil))))

(scim-set-variable-doc
 'scim-mode-line-string
 "この変数はscim-modeがアクティブである時にモードラインに表示され、そう
でない時には表示されない文字列を指定します。この文字列は、空白文字で始まり、
scim-modeを表すような短い文字列でなければなりません。")

;; Advanced settings
(scim-set-group-doc
 'scim-expert
 "高度な設定")

(scim-set-variable-doc
 'scim-focus-update-interval
 "ウインドウのフォーカスを監視する周期を秒単位で指定します。
SCIM がオフの時、あるいは入力フォーカスが他のアプリケーションにある時は、
`scim-focus-update-interval-long' で指定されたより遅い時間間隔が代わりに
用いられます。

注意：もし SCIM-Bridge のバージョンが 0.4.13 よりも古いか、お使いのウインドウ
マネージャが `_NET_ACTIVE_WINDOW' プロパティをサポートしていないと、この値は
用いられません。その場合は、常に `scim-focus-update-interval-long' の値が使用
されます。")

(scim-set-variable-doc
 'scim-focus-update-interval-long
 "この値は入力フォーカスの監視のための遅い時間周期として、
`scim-focus-update-interval' の代わりに用いられる事があります。

詳細は `scim-focus-update-interval' をご覧ください。")

(scim-set-variable-doc
 'scim-kana-ro-x-keysym
 "日本語の「ろ」キーが使用される場合、Xウインドウシステムにおいてこのキー
に割り当てる KeySym の名前を指定します。このプログラムはバックスラッシュキー
を円記号(￥)キーと区別するために、バックスラッシュキーに代替の KeySym を設定
します。")

(scim-set-variable-doc
 'scim-kana-ro-key-symbol
 "日本語の「ろ」キーが使用される場合、`scim-kana-ro-x-keysym' によって
このキーに与えられた KeySym に対応するイベントのシンボルを指定します。
このプログラムはバックスラッシュキーを円記号(￥)キーと区別するために、
バックスラッシュキーに代替の KeySym を設定します。"
 '(choice (symbol :tag "シンボル")
	  (const :tag "なし" nil)))

(scim-set-variable-doc
 'scim-bridge-timeout
 "SCIM からのデータ受信のための最大の待ち時間を指定します。浮動小数点の数
ならば秒数を表し、整数ならばミリ秒を表します。")

(scim-set-variable-doc
 'scim-config-file
 "SCIM の設定ファイル名です。これは SCIM の設定が変更されたことを検知する
目的で使用されます。")

(scim-set-variable-doc
 'scim-meta-key-exists
 "キーボードにmetaキーがある場合、この変数には t がセットされます。
自動検出がうまくいかない場合は、scim-bridge.el を読み込む前に手動で設定して
ください。")

(scim-set-variable-doc
 'scim-tmp-buffer-name
 "エージェントと通信するためのワーキングバッファの名前です。")

(scim-set-variable-doc
 'scim-incompatible-mode-hooks
 "これらのフックが実行される時には、scim-mode-map が無効化されます。")

(scim-set-variable-doc
 'scim-undo-command-list
 "これらのコマンドは、プリエディット領域が存在する時に無効化されます。")

;; Functions
(scim-set-function-doc
 'scim-set-group-doc
 "グループ GROUP の説明文字列を STRING で置換します。
もし STRING が空文字列または nil であれば、説明文字列は原文のままとなります。")

(scim-set-function-doc
 'scim-set-variable-doc
 "変数 VARIABLE の説明文字列を STRING で置換します。
もし STRING が空文字列または nil であれば、説明文字列は原文のままとなります。
もし CUSTOM-TYPE が nil でなければ、VARIABLE の `custom-type' プロパティに
設定されます（これは `defcustom' における :type キーワードに対応します）。")

(scim-set-function-doc
 'scim-set-face-doc
 "フェイス FACE の説明文字列を STRING で置換します。
もし STRING が空文字列または nil であれば、説明文字列は原文のままとなります。")

(scim-set-function-doc
 'scim-set-function-doc
 "関数 FUNCTION の説明文字列を STRING で置換します。
もし STRING が空文字列または nil であれば、説明文字列は原文のままとなります。")

(scim-set-function-doc
 'scim-define-common-key
 "どのキーイベントが常時 SCIM へ送られるかを指定します。HANDLE が nil で
なければ、SCIM は KEY で与えられたキーイベントを処理します。KEY が配列として
与えられた場合は、キーシーケンスを表すのではなく、単独のキーストロークの複数
の定義を表します。
この設定を有効にするには、関数 `scim-update-key-bindings' を呼び出すか、
または scim-mode を再起動する必要があります。")

(scim-set-function-doc
 'scim-define-preedit-key
 "どのキーイベントがプリエディット時に SCIM へ送られるかを指定します。
HANDLE が nil でなければ、SCIM は KEY で与えられたキーイベントを処理します。
KEY が配列として与えられた場合は、キーシーケンスを表すのではなく、単独のキー
ストロークの複数の定義を表します。
この設定を有効にするには、関数 `scim-update-key-bindings' を呼び出すか、
または scim-mode を再起動する必要があります。")

(scim-set-function-doc
 'scim-reset-imcontext-statuses
 "カーソル色の誤りを修正するために、各バッファのIMコンテクストの状態を保持して
いる変数を全てリセットします。この関数は、SCIM GUIセットアップユーティリティ
が使用された直後に呼び出されることがあります。")

(scim-set-function-doc
 'scim-get-frame-extents
 "フレームの外縁の幅のピクセル数を (left right top bottom) という形で返し
ます。ここで、`top' はフレームのタイトルバーの高さでもあります。")

(scim-set-function-doc
 'scim-frame-header-height
 "メニューバーとツールバーの高さの合計をピクセル数で返します。この関数の返す
値はあまり正確ではありません。")

(scim-set-function-doc
 'scim-real-frame-header-height
 "メニューバーとツールバーの高さの合計をピクセル数で返します。この関数の返す
値はとても正確ですが、関数 `scim-frame-header-height' と比べてずっと遅いです。")

(scim-set-function-doc
 'scim-compute-pixel-position
 "ポイント位置のスクリーン上のピクセル座標を (X . Y) という形で返します。
この値はその文字の左下隅の座標を示しています。")

(scim-set-function-doc
 'scim-get-gnome-font-size
 "GNOMEデスクトップ環境における、アプリケーションフォントの大きさのピクセル
数を返します。スクリーンの解像度が設定され、かつシェルコマンド `gconftool-2'
が使える必要があります。さもなければ、この関数はゼロを返します。")

(scim-set-function-doc
 'scim-get-active-window-id
 "最前面にある、すなわち入力フォーカスのあるウインドウの、ウインドウシステム
におけるウインドウ番号を返します。")

(scim-set-function-doc
 'scim-enable-isearch
 "SCIM を isearch-mode で使用可能にします。")

(scim-set-function-doc
 'scim-disable-isearch
 "SCIM を isearch-mode で使用できないようにします。")

(scim-set-function-doc
 'scim-mode
 "SCIMマイナーモード (scim-mode) をトグルします。
省略可能な引数 ARG は、正の数ならば scim-mode がオンになり、
そうでなければオフになります。")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define functions useful only for Japanese
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings
(defvar scim-anthy-reconversion-event 'S-henkan
  "この変数には、SCIM-Anthy のキーバインド設定で「再変換」に割り当てられて
いるキーイベントを設定してください。関数 `scim-anthy-reconvert-region'
で使用されます。")

(defvar scim-toggle-input-method-event ?\C-\ 
  "この変数には、SCIM のキーバインド設定で「SCIM 開始」に割り当てられて
いるキーイベントを設定してください。関数 `scim-transfer-romaji-into-preedit'
で使用されます。")

;; Functions
(defun scim-anthy-reconvert-region ()
  "SCIM-Anthy の使用時に、バッファ内の文字列を再変換します。
マークが活性ならばマークとポイントの位置を変換範囲の両端とし、そうでなければ
ポイントの位置にある文節が変換対象となります。再変換のためのキーイベントは、
変数 `scim-anthy-reconversion-event' で指定されます。"
  (interactive "*")
  (when (and (stringp scim-imcontext-id)
	     (not scim-mode-map-prev-disabled))
    (if mark-active
	(call-interactively 'copy-region-as-kill)
      (unless (memq (following-char) (append "。、．，？！）」)]}\n" nil))
	(while (and (forward-word)
		    (string-match "[ぁ-ん][ー・]"
				  (concat (list (preceding-char)
						(following-char)))))))
      (let ((end (point)))
	(while (and (backward-word)
		    (string-match "[ぁ-ん][ー・]"
				  (concat (list (preceding-char)
						(following-char))))))
	(copy-region-as-kill (point) end)))
    (scim-dispatch-key-event scim-anthy-reconversion-event)))

(defun scim-transfer-romaji-into-preedit (end-point)
  "バッファ内の指定位置にあるローマ字の文字列を削除すると同時に、その文字列
をキーイベントキューの先頭に追加し、SCIM をオンにします。この関数を用いると、
バッファ内の文字列をキー入力として SCIM に渡すことができます。
END-POINT は文字列の片端のバッファ内位置を指定します。インタラクティブに呼び
出された場合はポイント位置の値が代入されます。マークが活性であれば、対象となる
文字列はマークと END-POINT の位置を両端とし、そうでなければ END-POINT から
行の先頭に向かってローマ字列の開始位置を検索します。SCIM を切り替えるための
キーイベントは、変数 `scim-toggle-input-method-event' で指定されます。"
  (interactive "d*")
  (unless scim-imcontext-status
    (scim-dispatch-key-event scim-toggle-input-method-event))
  (cond
   (isearch-mode
    (setq unread-command-events
	  (append (list ?a 'scim-resume-preedit)
		  (this-command-keys)
		  unread-command-events)
	  mark-active nil))
   ((and (stringp scim-imcontext-id)
	 (not scim-mode-map-prev-disabled))
    (goto-char end-point)
    (let* ((beg (if mark-active
		    (mark)
		  (skip-chars-backward "a-z-,.!?")
		  (point)))
	   (str (buffer-substring-no-properties beg end-point)))
      (cond
       ((and (boundp 'table-mode-indicator)
	     table-mode-indicator)
	(scim-*table--cell-delete-region beg end-point))
       (t
	(delete-region beg end-point)))
      (setq unread-command-events
	    (append str unread-command-events))))))

(provide 'scim-bridge-ja)

;;;
;;; scim-bridge-ja.el ends here
