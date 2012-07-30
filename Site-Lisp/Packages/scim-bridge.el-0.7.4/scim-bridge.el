;;; scim-bridge.el

;; Copyright (C) 2008, 2009 S. Irie

;; Author: S. Irie
;; Maintainer: S. Irie
;; Keywords: Input Method, i18n

(defconst scim-mode-version "0.7.4")

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

;; This program is SCIM-Bridge client for GNU Emacs. It is, however,
;; not part of official SCIM-Bridge.

;;
;; Installation:
;;
;; First, save this file as scim-bridge.el and byte-compile in
;; a directory that is listed in load-path.
;;
;; Put the following in your .emacs file:
;;
;;   (require 'scim-bridge)
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
;;   (require 'scim-bridge)
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

;;; History:
;; 2009-01-29  S. Irie
;;         * Add support for table.el
;;         * Available for yasnippet latest version (v0.5.9)
;;         * Correct self-insert-command emulation
;;         * Bug fixes
;;         * Modify description of installation
;;         * Version 0.7.4
;;
;; 2008-12-28  S. Irie
;;         * Cooperate with VI emulators (vi-mode, vip-mode, viper-mode)
;;         * Enhance IRC clients support
;;           - Don't clear buffer-undo-list when start of preediting
;;           - Add support for some clients (rcirc, Circe)
;;         * Cursor color can be specified for SCIM disabled state
;;         * Re-implement support for Japanese thumb shift typing method
;;         * Add option about cursor shape on isearch-mode
;;         * Change specification of `scim-cursor-type-for-candidate'
;;         * Bug fixes
;;         * version 0.7.3
;;
;; 2008-12-06  S. Irie
;;         * Add support for incremental search mode
;;         * Add dynamic adjustment of input focus observation cycle
;;         * Add option for using minimum keymap
;;         * Add auto-restarting mechanism
;;         * Delete embedded perl script for UNIX domain socket connection
;;         * Bug fixes
;;         * Version 0.7.2
;;
;; 2008-10-20  S. Irie
;;         * Add option about behavior in minibuffer
;;         * Bug fixes
;;         * Version 0.7.1
;;
;; 2008-10-04  S. Irie
;;         * Add options about cursor color, shape, and location
;;         * Add functions for lcalization
;;         * Bug fixes
;;         * Version 0.7.0
;;
;; 2008-09-08  S. Irie
;;         * Change default value of `scim-mode-local' into t
;;         * Disable keymap in ebrowse-tree-mode
;;         * Available for ERC (IRC Client)
;;         * Bug fixes
;;         * Version 0.6.9
;;
;; 2008-09-05  S. Irie
;;         * Add treatment for read-only text
;;         * Bug fixes
;;         * Version 0.6.8
;;
;; 2008-07-26  S. Irie
;;         * Comment out debug codes
;;         * Some unimportant changes
;;         * Version 0.6.7
;;
;; 2008-06-12  S. Irie
;;         * Available for Xming multi-window mode
;;         * Version 0.6.6
;;
;; 2008-06-05  S. Irie
;;         * Change default value of `scim-common-function-key-list'
;;         * Bug fixes
;;         * Version 0.6.5
;;
;; 2008-06-01  S. Irie
;;         * Add/modify documentation strings
;;         * Version 0.6.4
;;
;; 2008-05-24  S. Irie
;;         * Solve kana-RO key problem
;;         * Bug fix
;;         * Version 0.6.3
;;
;; 2008-05-22  S. Irie
;;         * Modify treatment of kana-RO key
;;         * Bug fix
;;         * Version 0.6.2
;;
;; 2008-05-20  S. Irie
;;         * Bug fix
;;         * Version 0.6.1
;;
;; 2008-05-18  S. Irie
;;         * Manage meta-to-alt mapping
;;         * Bug fix
;;         * Version 0.6.0
;;
;; 2008-05-15  S. Irie
;;         * Experimental first release
;;         * Version 0.5.0
;;
;; 2008-05-12  S. Irie
;;         * Version 0.4.0
;;
;; 2008-05-08  S. Irie
;;         * Version 0.3.0
;;
;; 2008-05-06  S. Irie
;;         * Version 0.2.0
;;
;; 2008-04-20  S. Irie
;;         * Version 0.1.0

;; ToDo:

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; User settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defgroup scim nil
  "The Smart Common Input Method platform"
  :prefix "scim-"
  :group 'editing :group 'wp)

;; Basic settings
(defgroup scim-basic nil
  "Settings of operation, such as mode management and keyboard"
  :group 'scim)

(defcustom scim-mode-local t
  "If the value is non-nil, IMContexts are registered for each buffer
so that the input method of buffers can be toggled individually.
Otherwise, the input method is globally toggled."
  :type 'boolean
  :group 'scim-basic)

(defcustom scim-imcontext-temporary-for-minibuffer t
  "If non-nil, an one-time IMContext is used for a minibuffer so that
the minibuffer always starts with SCIM's input status off. This option
is effective only when the option `scim-mode-local' is active (non-nil)."
  :type 'boolean
  :group 'scim-basic)

(defun scim-customize-isearch (var value)
  (set var value)
  (if (and (fboundp 'scim-setup-isearch)
           scim-mode)
      (scim-setup-isearch)))

(defcustom scim-use-in-isearch-window t
  "If non-nil, SCIM can be used with isearch-mode. Otherwise, it can't.

Note that this option requires SCIM-Bridge version 0.4.13 or later."
  :set 'scim-customize-isearch
  :type 'boolean
  :group 'scim-basic)

(defun scim-customize-key (var value)
  (set var value)
  (if (and (fboundp 'scim-update-key-bindings)
           scim-mode)
      (scim-update-key-bindings var)))

(defcustom scim-use-minimum-keymap t
  "If non-nil, printable character events are not handled when SCIM is
off. This option is useful for avoiding conflict with other Emacs-Lisp
libraries.

NOTICE: Don't activate this option if SCIM-Bridge version in your system
is older than 0.4.13, otherwise SCIM cannot receive your inputs."
  :set 'scim-customize-key
  :type 'boolean
  :group 'scim-basic)

(defcustom scim-common-function-key-list
  '((control ".")
    (control ",")
    (control "<")
    (control ">")
    (control "/")
    (control " ")
    (shift " ")
    (control alt left)
    (control alt right)
    (control alt up)
    (control alt down)
    (zenkaku-hankaku)
    (henkan)
    (shift henkan)
    (muhenkan)
    (hiragana-katakana)
    (alt romaji)
    (f6)
    (f7)
    (f8)
    (shift f8)
    (f9)
    (f10)
    (f11)
    (f12)
    (kp-space)
    (kp-equal)
    (kp-multiply)
    (kp-add)
    (kp-separator)
    (kp-subtract)
    (kp-decimal)
    (kp-divide)
    (kp-0)
    (kp-1)
    (kp-2)
    (kp-3)
    (kp-4)
    (kp-5)
    (kp-6)
    (kp-7)
    (kp-8)
    (kp-9))
  "This list indicates which keystrokes SCIM takes over at both direct
insert mode and preediting mode. You can also add/remove the elements
using the function `scim-define-common-key'.
NOTICE: Don't set prefix keys in this option, such as ESC and C-x.
If you do so, operating Emacs might become impossible."
  :set 'scim-customize-key
  :type '(repeat (list :format "%v"
                       (set :format "%v"
                            :inline t
                            (const :format "M- " meta)
                            (const :format "C- " control)
                            (const :format "S- " shift)
                            (const :format "H- " hyper)
                            (const :format "s- " super)
                            (const :format "A- " alt))
                       (restricted-sexp :format "%v"
                                        :match-alternatives
                                        (symbolp stringp))))
  :group 'scim-basic)

(defcustom scim-preedit-function-key-list
  '((escape)
    (left)
    (right)
    (up)
    (down)
    (home)
    (end)
    (prior)
    (next)
    (return)
    (shift left)
    (shift right)
    (shift up)
    (shift down)
    (shift return)
    (tab)
    (iso-lefttab)
    (shift tab)
    (shift iso-lefttab)
    (backtab)
    (backspace)
    (delete)
    (kp-enter)
    (kp-tab))
  "This list indicates which keystrokes SCIM takes over when the
preediting area exists. You can also add/remove the elements using
the function `scim-define-preedit-key'."
  :set 'scim-customize-key
  :type '(repeat (list :format "%v"
                       (set :format "%v"
                            :inline t
                            (const :format "M- " meta)
                            (const :format "C- " control)
                            (const :format "S- " shift)
                            (const :format "H- " hyper)
                            (const :format "s- " super)
                            (const :format "A- " alt))
                       (restricted-sexp :format "%v"
                                        :match-alternatives
                                        (symbolp stringp))))
  :group 'scim-basic)

(defcustom scim-use-kana-ro-key nil
  "If you use Japanese kana typing method with jp-106 keyboard, turn
on (non-nil) this option to input a kana character `ろ' without pushing
the shift key.
 This option is made effectual by temporarily modifying the X-window
system's keyboard configurations with a shell command `xmodmap'."
  :set 'scim-customize-key
  :type 'boolean
  :group 'scim-basic)

(defcustom scim-simultaneous-pressing-time nil
  "If you use Japanese thumb shift typing method on SCIM-Anthy,
specify the time interval (in seconds) which is corresponding to
`simultaneous pressing time' setting of SCIM-Anthy. Two keystrokes
within this time interval are sent to SCIM as a simultaneous keystroke."
  :type '(choice (const :tag "none" nil)
                 (number :tag "interval (sec.)" :value 0.1))
  :group 'scim-basic)

(define-obsolete-variable-alias
  'scim-key-release-delay 'scim-simultaneous-pressing-time
  "scim-bridge.el version 0.7.3")

(defcustom scim-undo-by-committed-string nil
  "If the value is nil, undo is performed bringing some short
committed strings together or dividing the long committed string
within the range which does not exceed 20 characters. Otherwise, undo
is executed every committed string."
  :type 'boolean
  :group 'scim-basic)

(defcustom scim-clear-preedit-when-unexpected-event nil
  "If the value is non-nil, the preediting area is cleared in the
situations that the unexpected event happens during preediting.
The unexpected event is, for example, that the string is pasted
with the mouse."
  :type 'boolean
  :group 'scim-basic)

;; Appearance
(defgroup scim-appearance nil
  "Faces, candidate window, etc."
  :group 'scim)

(defface scim-preedit-default-face
                                        ;  nil
  '((t :inherit underline))
  "This face indicates the whole of the preediting area."
  :group 'scim-appearance)

(defface scim-preedit-underline-face
  '((t :inherit underline))
  "This face corresponds to the text attribute `Underline' in SCIM
GUI Setup Utility."
  :group 'scim-appearance)

(defface scim-preedit-highlight-face
                                        ;  '((t :inherit (scim-preedit-underline-face highlight)))
  '((t :inherit highlight))
  "This face corresponds to the text attribute `Highlight' in SCIM
GUI Setup Utility."
  :group 'scim-appearance)

(defface scim-preedit-reverse-face
                                        ;  '((t :inherit scim-preedit-underline-face :inverse-video t))
  '((t :inverse-video t))
  "This face corresponds to the text attribute `Reverse' in SCIM
GUI Setup Utility."
  :group 'scim-appearance)

(defun scim-customize-cursor-color (var value)
  (set var value)
  (if (and (fboundp 'scim-set-cursor-color)
           scim-mode)
      (scim-set-cursor-color)))

(defcustom scim-cursor-color
  nil
  "If the value is a string, it specifies the cursor color applied
when SCIM is on. If a cons cell, its car and cdr are the cursor colors
which indicate that SCIM is on and off, respectively. If a list, the
first, second and third (if any) elements correspond to that SCIM is
on, off and disabled, respectively. The value nil means that the cursor
color is not controlled at all.

Note that this option requires SCIM-Bridge version 0.4.13 or later."
  :set 'scim-customize-cursor-color
  :type '(choice (const :tag "none (nil)" nil)
                 (color :tag "red" :format "red (%{sample%})\n" :value "red")
                 (color :tag "blue" :format "blue (%{sample%})\n" :value "blue")
                 (color :tag "green" :format "green (%{sample%})\n" :value "limegreen")
                 (color :tag "other" :value "red")
                 (cons  :tag "other (ON . OFF)"
                        (color :format "ON: %v (%{sample%})  " :value "red")
                        (color :format "OFF: %v (%{sample%})\n" :value "blue"))
                 (list  :tag "other (ON OFF)"
                        (color :format "ON: %v (%{sample%})  " :value "red")
                        (color :format "OFF: %v (%{sample%})  DISABLED: none\n"
                               :value "blue"))
                 (list  :tag "other (ON OFF DISABLED)"
                        (color :format "ON: %v (%{sample%})  " :value "red")
                        (color :format "OFF: %v (%{sample%})\n" :value "blue")
                        (color :format "DISABLED: %v (%{sample%})\n"
                               :value "limegreen")))
  :group 'scim-appearance)

(defcustom scim-isearch-cursor-type
  0
  "This option specifies the cursor shape which is applied when
isearch-mode is active. If an integer 0, this option is not active so
that the cursor shape is not changed.
See `cursor-type'."
  :type '(choice (const :tag "default (0)" 0)
                 (const :tag "use frame parameter" t)
                 (const :tag "don't display" nil)
                 (const :tag "filled box" box)
                 (const :tag "hollow box" hollow)
                 (const :tag "vertical bar" bar)
                 (cons :tag "vertical bar (specify width)"
                       (const :format "" bar)
                       (integer :tag "width" :value 1))
                 (const :tag "horizontal bar" hbar)
                 (cons :tag "horizontal bar (specify height)"
                       (const :format "" hbar)
                       (integer :tag "height" :value 1)))
  :group 'scim-appearance)

(defcustom scim-cursor-type-for-candidate
  0
  "This option specifies the cursor shape which is applied when the
preediting area shows conversion candidates. If an integer 0, this
option is not active so that the cursor shape is not changed.
See `cursor-type'."
  :type '(choice (const :tag "default (0)" 0)
                 (const :tag "use frame parameter" t)
                 (const :tag "don't display" nil)
                 (const :tag "filled box" box)
                 (const :tag "hollow box" hollow)
                 (const :tag "vertical bar" bar)
                 (cons :tag "vertical bar (specify width)"
                       (const :format "" bar)
                       (integer :tag "width" :value 1))
                 (const :tag "horizontal bar" hbar)
                 (cons :tag "horizontal bar (specify height)"
                       (const :format "" hbar)
                       (integer :tag "height" :value 1)))
  :group 'scim-appearance)

(defcustom scim-put-cursor-on-candidate
  nil
  "When the preediting area shows conversion candidates, the cursor
is put on the selected segment if this option is non-nil. Otherwise,
the cursor is put to the tail of the preediting area."
  :type 'boolean
  :group 'scim-appearance)

(defcustom scim-adjust-window-x-position
                                        ;  'gnome
  nil
  "This option specifies whether the position of candidate window
is adjusted so that the inline candidate and the candidates in that
window may just line up in the vertical direction. If the value is
`gnome', the adjustment will be done using the font size setting of
GNOME desktop environment. Otherwise, if the value is given as an
integer, that indicates the amount of the gap from normal position
by the number of pixels.
 This is not suitable for input method of the type to which the
candidate window is always displayed such as SCIM-pinyin (chinese),
because there is a possibility that the window hides the cursor when
the cursor is on the bottom of screen."
  :type '(choice (const :tag "use GNOME's font size" gnome)
                 (integer :tag "specify by pixel number" :value 24)
                 (const :tag "off" nil))
  :group 'scim-appearance)

(defcustom scim-adjust-window-y-position
  t
  "If the value is non-nil, the vertical position of candidate window
is adjusted to the bottom of cursor by using a shell command `xwininfo'.
Otherwise, the adjustment isn't done and therefore the window might
be displayed a little below from the exact location."
  :type 'boolean
  :group 'scim-appearance)

(defcustom scim-prediction-window-position
  '(nil . nil)
  "(For Japanese IM only) The value should be given as (POS . ADJ).
If POS is non-nil, the forecast window is displayed under the head
of the preediting area. If the value of ADJ is non-nil, the horizontal
position of it is adjusted same as `scim-adjust-window-x-position'."
  :type '(cons
          (choice :tag "Position"
                  (const :tag "Tail of preediting area" nil)
                  (const :tag "Head of preediting area" t))
          (choice :tag "Adjustment"
                  (const :tag "same as conversion window" t)
                  (const :tag "off" nil)))
  :group 'scim-appearance)

(defcustom scim-mode-line-string " SCIM"
  "This variable specify a string that appears in the mode line
when scim-mode is active, and not otherwise. This string should be
a short string which starts with a space and represents scim-mode."
  :type 'string
  :group 'scim-appearance)

;; Advanced settings
(defgroup scim-expert nil
  "Advanced settings"
  :group 'scim)

(defcustom scim-focus-update-interval 0.3
  "The window focus is checked with this cycle measured in seconds.
When SCIM is off or input focus is in the other application, the slower
time cycle given by `scim-focus-update-interval-long' is used instead.

Note that this value is not used if SCIM-Bridge version in your system
is older than 0.4.13 or your window manager does not support a property
`_NET_ACTIVE_WINDOW'. In that case, `scim-focus-update-interval-long'
is used at all times."
  :type 'number
  :group 'scim-expert)

(defcustom scim-focus-update-interval-long 1.0
  "This value might be used as a slow time cycle for the observation
of input focus instead of `scim-focus-update-interval'.

See `scim-focus-update-interval' for details."
  :type 'number
  :group 'scim-expert)

(defcustom scim-kana-ro-x-keysym "F24"
  "When Japanese kana-RO key is used, this option specifies the
substitute KeySym name used in X window system for the key. This
program sets the substitute KeySym for backslash key to distinguish
it from yen-mark key."
  :set 'scim-customize-key
  :type 'string
  :group 'scim-expert)

(defcustom scim-kana-ro-key-symbol 'f24
  "When Japanese kana-RO key is used, this option specifies the event
corresponding to the substitute KeySym given in `scim-kana-ro-x-keysym'
as a symbol. This program sets the substitute KeySym for backslash key
to distinguish it from yen-mark key."
  :set 'scim-customize-key
  :type '(choice (symbol)
                 (const :tag "none" nil))
  :group 'scim-expert)

(defcustom scim-bridge-timeout 3.0
  "Specify the maximum waiting time for data reception from SCIM.
A floating point number means the number of seconds, otherwise an integer
the milliseconds."
  :type 'number
  :group 'scim-expert)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; System settings and constants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar scim-debug nil)
(defvar scim-log-buffer "*scim-bridge-log*")

                                        ;(defvar scim-bridge-socket-path "/tmp/scim-bridge-0.3.0.socket-1000@localhost:0.0")
(defvar scim-bridge-compat-version "0.3.0")
(defvar scim-bridge-socket-dir "/tmp/")
(defvar scim-bridge-socket-name "socket")
(defvar scim-bridge-name "scim-bridge")
(defvar scim-bridge-host-name "localhost")
(defvar scim-bridge-x-display-name
  (let* ((name (getenv "DISPLAY"))
         (display (substring name (string-match ":[0-9]+" name)))
         (screen (and (not (string-match "\\.[0-9]+$" display)) ".0")))
    (concat display screen)))
(defvar scim-bridge-socket-path
  (concat scim-bridge-socket-dir scim-bridge-name "-"
          scim-bridge-compat-version "." scim-bridge-socket-name "-"
          (number-to-string (user-uid)) "@"
          scim-bridge-host-name scim-bridge-x-display-name))

(defvar scim-config-file "~/.scim/config"
  "The name of SCIM's configuration file, which is used to detect
the change of SCIM settings.")

(defvar scim-meta-key-exists
  (string< "" (shell-command-to-string "xmodmap -pke | grep '= Meta'"))
  "t is set in this variable if there is mata modifier key in the
keyboard. When automatic detection doesn't go well, please set the
value manually before scim-bridge.el is loaded.")

(defvar scim-tmp-buffer-name " *scim-bridge*"
  "This is working buffer name used for communicating with the agent.")

(defvar scim-incompatible-mode-hooks
  '(ediff-mode-hook ebrowse-tree-mode-hook w3m-mode-hook)
  "When these hooks run, scim-mode-map become inactive.")

(defvar scim-undo-command-list
  '(undo undo-only redo)
  "These commands are made unusable when the preediting area exists.")

(defvar scim-reply-alist
  '(
    ;; Status
    ("imengine_status_changed"      . scim-imengine-status-changed)
    ("imcontext_registered"     . scim-imcontext-registered)
    ("preedit_mode_changed"     . scim-preedit-mode-changed)
    ("focus_changed"            . scim-focus-changed)
    ("cursor_location_changed"      . scim-cursor-location-changed)
    ("key_event_handled"        . scim-key-event-handled)
    ("imcontext_deregister"     . scim-imcontext-deregister)
    ("imcontext_reseted"        . scim-imcontext-reseted)
    ;; Request
    ("forward_key_event"        . scim-forward-key-event)
    ("update_preedit"           . scim-update-preedit)
    ("set_preedit_shown"        . scim-set-preedit-shown)
    ("set_preedit_cursor_position"  . scim-set-preedit-cursor-position)
    ("set_preedit_string"       . scim-set-preedit-string)
    ("set_preedit_attributes"       . scim-set-preedit-attributes)
    ("set_commit_string"        . scim-set-commit-string)
    ("commit_string"            . scim-commit-string)
    ("get_surrounding_text"     . scim-get-surrounding-text)
    ("delete_surrounding_text"      . scim-delete-surrounding-text)
    ("replace_surrounding_text"     . scim-replace-surrounding-text)
    ("beep"             . scim-beep)
    ))

(defvar scim-modifier-alist
  `(
    ;; Keyboard
    (shift . "shift")
    (control . "control")
    (,(if scim-meta-key-exists 'alt 'meta) . "alt")
    (meta . "meta")
                                        ;    (super . "hyper")
    (super . "super")
    (hyper . "hyper")
    ;;
    (caps-lock . "caps_lock")
    (num-lock . "num_lock")
    (kana-RO . "kana_ro")
    ;; Mouse
                                        ;    (up . "up")
                                        ;    (down . "down")
                                        ;    (drag . "drag")
                                        ;    (click . "click")
                                        ;    (double . "double")
                                        ;    (triple . "triple")
    ))

(defvar scim-alt-modifier-alist
  '(
    (hiragana-katakana . romaji)
    (zenkaku-hankaku . kanji)
    (henkan . mode-switch)
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key code table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar scim-keycode-alist
  '(
    ;; *** Function keys ***********************************************
    (backspace . ?\xff08)
    (tab . ?\xff09)
    (linefeed . ?\xff0a)
    (clear . ?\xff0b)
    (return . ?\xff0d)
    (pause . ?\xff13)
                                        ;    (scroll-lock . ?\xff14)
                                        ;    (sys-req . ?\xff15)
    (escape . ?\xff1b)
    (delete . ?\xffff)
    ;; *** International & multi-key character composition *************
                                        ;    (multi-key . ?\xff20)
                                        ;    (codeinput . ?\xff37)
                                        ;    (singlecandidate . ?\xff3c)
                                        ;    (multiplecandidate . ?\xff3d)
                                        ;    (previouscandidate . ?\xff3e)
    ;; Japanese keyboard support ***************************************
    (kanji . ?\xff21)
    (muhenkan . ?\xff22)
                                        ;    (henkan-mode . ?\xff23)
    (henkan . ?\xff23)
    (romaji . ?\xff24)
    (hiragana . ?\xff25)
    (katakana . ?\xff26)
    (hiragana-katakana . ?\xff27)
    (zenkaku . ?\xff28)
    (hankaku . ?\xff29)
    (zenkaku-hankaku . ?\xff2a)
    (touroku . ?\xff2b)
    (massyo . ?\xff2c)
    (kana-lock . ?\xff2d)
    (kana-shift . ?\xff2e)
    (eisu-shift . ?\xff2f)
    (eisu-toggle . ?\xff30)
                                        ;    (kanji-bangou . ?\xff37)
                                        ;    (zen-koho . ?\xff3d)
                                        ;    (mae-koho . ?\xff3e)
    ;; *** Cursor control & motion *************************************
    (home . ?\xff50)
    (left . ?\xff51)
    (up . ?\xff52)
    (right . ?\xff53)
    (down . ?\xff54)
    (prior . ?\xff55)
                                        ;    (page-up . ?\xff55)
    (next . ?\xff56)
                                        ;    (page-down . ?\xff56)
    (end . ?\xff57)
    (begin . ?\xff58)
    ;; *** Misc Functions **********************************************
    (select . ?\xff60)
    (print . ?\xff61)
    (execute . ?\xff62)
    (insert . ?\xff63)
    (undo . ?\xff65)
    (redo . ?\xff66)
    (menu . ?\xff67)
    (find . ?\xff68)
    (cancel . ?\xff69)
    (help . ?\xff6a)
    (break . ?\xff6b)
    (mode-switch . ?\xff7e)     ; This key cannot be recognized to Emacs.
                                        ;    (num-lock . ?\xff7f)
    ;; *** Keypad ******************************************************
    (kp-space . ?\xff80)
    (kp-tab . ?\xff89)
    (kp-enter . ?\xff8d)
    (kp-f1 . ?\xff91)
    (kp-f2 . ?\xff92)
    (kp-f3 . ?\xff93)
    (kp-f4 . ?\xff94)
    (kp-home . ?\xff95)
    (kp-left . ?\xff96)
    (kp-up . ?\xff97)
    (kp-right . ?\xff98)
    (kp-down . ?\xff99)
    (kp-prior . ?\xff9a)
                                        ;    (kp-page-up . ?\xff9a)
    (kp-next . ?\xff9b)
                                        ;    (kp-page-down . ?\xff9b)
    (kp-end . ?\xff9c)
    (kp-begin . ?\xff9d)
    (kp-insert . ?\xff9e)
    (kp-delete . ?\xff9f)
    (kp-equal . ?\xffbd)
    (kp-multiply . ?\xffaa)
    (kp-add . ?\xffab)
    (kp-separator . ?\xffac)
    (kp-subtract . ?\xffad)
    (kp-decimal . ?\xffae)
    (kp-divide . ?\xffaf)
    (kp-0 . ?\xffb0)
    (kp-1 . ?\xffb1)
    (kp-2 . ?\xffb2)
    (kp-3 . ?\xffb3)
    (kp-4 . ?\xffb4)
    (kp-5 . ?\xffb5)
    (kp-6 . ?\xffb6)
    (kp-7 . ?\xffb7)
    (kp-8 . ?\xffb8)
    (kp-9 . ?\xffb9)
    ;; *** Auxilliary functions ****************************************
    (f1 . ?\xffbe)
    (f2 . ?\xffbf)
    (f3 . ?\xffc0)
    (f4 . ?\xffc1)
    (f5 . ?\xffc2)
    (f6 . ?\xffc3)
    (f7 . ?\xffc4)
    (f8 . ?\xffc5)
    (f9 . ?\xffc6)
    (f10 . ?\xffc7)
    (f11 . ?\xffc8)
    (f12 . ?\xffc9)
    (f13 . ?\xffca)
    (f14 . ?\xffcb)
    (f15 . ?\xffcc)
    (f16 . ?\xffcd)
    (f17 . ?\xffce)
    (f18 . ?\xffcf)
    (f19 . ?\xffd0)
    (f20 . ?\xffd1)
    (f21 . ?\xffd2)
    (f22 . ?\xffd3)
    (f23 . ?\xffd4)
    (f24 . ?\xffd5)
    (f25 . ?\xffd6)
    (f26 . ?\xffd7)
    (f27 . ?\xffd8)
    (f28 . ?\xffd9)
    (f29 . ?\xffda)
    (f30 . ?\xffdb)
    (f31 . ?\xffdc)
    (f32 . ?\xffdd)
    (f33 . ?\xffde)
    (f34 . ?\xffdf)
    (f35 . ?\xffe0)
    ;; *** Modifier keys ***********************************************
                                        ;    (shift-l . ?\xffe1)
                                        ;    (shift-r . ?\xffe2)
                                        ;    (control-l . ?\xffe3)
                                        ;    (control-r . ?\xffe4)
                                        ;    (caps-lock . ?\xffe5)
    (capslock . ?\xffe5)
                                        ;    (shift-lock . ?\xffe6)
                                        ;    (meta-l . ?\xffe7)
                                        ;    (meta-r . ?\xffe8)
                                        ;    (alt-l . ?\xffe9)
                                        ;    (alt-r . ?\xffea)
                                        ;    (super-l . ?\xffeb)
                                        ;    (super-r . ?\xffec)
                                        ;    (hyper-l . ?\xffed)
                                        ;    (hyper-r . ?\xffee)
    ;; *** ISO 9995 function and modifier keys *************************
                                        ;    (iso-lock . ?\xfe01)
                                        ;    (iso-level2-latch . ?\xfe02)
                                        ;    (iso-level3-shift . ?\xfe03)
                                        ;    (iso-level3-latch . ?\xfe04)
                                        ;    (iso-level3-lock . ?\xfe05)
                                        ;    (iso-group-shift . ?\xff7e)
                                        ;    (iso-group-latch . ?\xfe06)
                                        ;    (iso-group-lock . ?\xfe07)
                                        ;    (iso-next-group . ?\xfe08)
                                        ;    (iso-next-group-lock . ?\xfe09)
                                        ;    (iso-prev-group . ?\xfe0a)
                                        ;    (iso-prev-group-lock . ?\xfe0b)
                                        ;    (iso-first-group . ?\xfe0c)
                                        ;    (iso-first-group-lock . ?\xfe0d)
                                        ;    (iso-last-group . ?\xfe0e)
                                        ;    (iso-last-group-lock . ?\xfe0f)
                                        ;    (iso-left-tab . ?\xfe20)
    (iso-lefttab . ?\xfe20)
    (iso-move-line-up . ?\xfe21)
    (iso-move-line-down . ?\xfe22)
    (iso-partial-line-up . ?\xfe23)
    (iso-partial-line-down . ?\xfe24)
    (iso-partial-space-left . ?\xfe25)
    (iso-partial-space-right . ?\xfe26)
    (iso-set-margin-left . ?\xfe27)
    (iso-set-margin-right . ?\xfe28)
    (iso-release-margin-left . ?\xfe29)
    (iso-release-margin-right . ?\xfe2a)
    (iso-release-both-margins . ?\xfe2b)
    (iso-fast-cursor-left . ?\xfe2c)
    (iso-fast-cursor-right . ?\xfe2d)
    (iso-fast-cursor-up . ?\xfe2e)
    (iso-fast-cursor-down . ?\xfe2f)
    (iso-continuous-underline . ?\xfe30)
    (iso-discontinuous-underline . ?\xfe31)
    (iso-emphasize . ?\xfe32)
    (iso-center-object . ?\xfe33)
    (iso-enter . ?\xfe34)
    ;; *** Lispy accent keys *******************************************
    (dead-grave . ?\xfe50)
    (dead-acute . ?\xfe51)
    (dead-circumflex . ?\xfe52)
    (dead-tilde . ?\xfe53)
    (dead-macron . ?\xfe54)
    (dead-breve . ?\xfe55)
    (dead-abovedot . ?\xfe56)
    (dead-diaeresis . ?\xfe57)
    (dead-abovering . ?\xfe58)
    (dead-doubleacute . ?\xfe59)
    (dead-caron . ?\xfe5a)
    (dead-cedilla . ?\xfe5b)
    (dead-ogonek . ?\xfe5c)
    (dead-iota . ?\xfe5d)
    (dead-voiced-sound . ?\xfe5e)
    (dead-semivoiced-sound . ?\xfe5f)
    (dead-belowdot . ?\xfe60)
    (dead-hook . ?\xfe61)
    (dead-horn . ?\xfe62)
    ;; *** Katakana ****************************************************
    (overline . ?\x47e)
    (kana-fullstop . ?\x4a1)
    (kana-openingbracket . ?\x4a2)
    (kana-closingbracket . ?\x4a3)
    (kana-comma . ?\x4a4)
    (kana-conjunctive . ?\x4a5)
                                        ;    (kana-middledot . ?\x4a5)
    (kana-WO . ?\x4a6)
    (kana-a . ?\x4a7)
    (kana-i . ?\x4a8)
    (kana-u . ?\x4a9)
    (kana-e . ?\x4aa)
    (kana-o . ?\x4ab)
    (kana-ya . ?\x4ac)
    (kana-yu . ?\x4ad)
    (kana-yo . ?\x4ae)
    (kana-tsu . ?\x4af)
                                        ;    (kana-tu . ?\x4af)
    (prolongedsound . ?\x4b0)
    (kana-A . ?\x4b1)
    (kana-I . ?\x4b2)
    (kana-U . ?\x4b3)
    (kana-E . ?\x4b4)
    (kana-O . ?\x4b5)
    (kana-KA . ?\x4b6)
    (kana-KI . ?\x4b7)
    (kana-KU . ?\x4b8)
    (kana-KE . ?\x4b9)
    (kana-KO . ?\x4ba)
    (kana-SA . ?\x4bb)
    (kana-SHI . ?\x4bc)
    (kana-SU . ?\x4bd)
    (kana-SE . ?\x4be)
    (kana-SO . ?\x4bf)
    (kana-TA . ?\x4c0)
    (kana-CHI . ?\x4c1)
                                        ;    (kana-TI . ?\x4c1)
    (kana-TSU . ?\x4c2)
                                        ;    (kana-TU . ?\x4c2)
    (kana-TE . ?\x4c3)
    (kana-TO . ?\x4c4)
    (kana-NA . ?\x4c5)
    (kana-NI . ?\x4c6)
    (kana-NU . ?\x4c7)
    (kana-NE . ?\x4c8)
    (kana-NO . ?\x4c9)
    (kana-HA . ?\x4ca)
    (kana-HI . ?\x4cb)
    (kana-FU . ?\x4cc)
                                        ;    (kana-HU . ?\x4cc)
    (kana-HE . ?\x4cd)
    (kana-HO . ?\x4ce)
    (kana-MA . ?\x4cf)
    (kana-MI . ?\x4d0)
    (kana-MU . ?\x4d1)
    (kana-ME . ?\x4d2)
    (kana-MO . ?\x4d3)
    (kana-YA . ?\x4d4)
    (kana-YU . ?\x4d5)
    (kana-YO . ?\x4d6)
    (kana-RA . ?\x4d7)
    (kana-RI . ?\x4d8)
    (kana-RU . ?\x4d9)
    (kana-RE . ?\x4da)
    (kana-RO . ?\x4db)
    (kana-WA . ?\x4dc)
    (kana-N . ?\x4dd)
    (voicedsound . ?\x4de)
    (semivoicedsound . ?\x4df)
                                        ;    (kana-switch . ?\xFF7E)
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Definition of variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode management
(defcustom scim-mode nil
  "Toggle scim-mode.
Setting this variable directly does not take effect;
use either \\[customize] or the function `scim-mode'."
  :set 'custom-set-minor-mode
  :initialize 'custom-initialize-default
  :version "22.1"
  :type 'boolean
  :group 'scim
  :require 'scim-bridge)

;; Hook variables
(defvar scim-set-commit-string-hook nil)
(defvar scim-commit-string-hook nil)
(defvar scim-preedit-show-hook nil)

;; Manage key bindings
(defvar scim-mode-map nil)
(defvar scim-mode-preedit-map nil)
(defvar scim-mode-common-map nil)
(defvar scim-mode-kana-ro-map nil)
(defvar scim-mode-minimum-map nil)
(defvar scim-mode-map-alist nil)
(defvar scim-mode-map-disabled nil)
(make-variable-buffer-local 'scim-mode-map-disabled)
(defvar scim-mode-map-prev-disabled nil)
(make-variable-buffer-local 'scim-mode-map-prev-disabled)
(put 'scim-mode-map-prev-disabled 'permanent-local t)
(defvar scim-kana-ro-prev-x-keysym nil)
(defvar scim-keyboard-layout nil)
(defvar scim-keymap-overlay nil)

;; Communication & buffer editing
(defvar scim-bridge-socket nil)
(defvar scim-tmp-buffer nil)
(defvar scim-last-command-event nil)
(defvar scim-current-buffer nil)
(defvar scim-selected-frame nil)
(defvar scim-frame-focus nil)
(defvar scim-focus-update-timer nil)
(defvar scim-net-active-window-unsupported nil)
(defvar scim-string-insertion-failed nil)
(defvar scim-config-last-modtime nil)
(defvar scim-last-rejected-event nil)
(defvar scim-last-command nil)

;; Preediting area
(defvar scim-imcontext-id nil)
(defvar scim-imcontext-status nil)
(defvar scim-preediting-p nil)
(defvar scim-preedit-point (make-marker))
(defvar scim-preedit-update nil)
(defvar scim-preedit-shown "")
(defvar scim-preedit-string "")
(defvar scim-preedit-prev-string "")
(defvar scim-preedit-curpos 0)
(defvar scim-preedit-prev-curpos 0)
(defvar scim-preedit-attributes nil)
(defvar scim-preedit-prev-attributes nil)
(defvar scim-preedit-default-attr nil)
(defvar scim-preedit-overlays nil)
(defvar scim-committed-string "")
(defvar scim-frame-extents '(0 0 0 0))
(defvar scim-adjust-window-x-offset 0)
(defvar scim-adjust-window-y-offset 0)
(defvar scim-surrounding-text-modified nil)
(defvar scim-cursor-type-saved 0)
(make-variable-buffer-local 'scim-cursor-type-saved)

;; Incremental search
(defvar scim-isearch-parent-buffer nil)
(defvar scim-isearch-minibuffer nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Definition of functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Miscellaneous
(defun scim-escape-string (str)
  (let* ((tmp (append str nil))
         cur
         (next tmp))
    (while (setq cur (memq ?\\ next))
      (setq next (cdr cur))
      (setcdr cur (cons ?\\ next)))
    (setq next tmp)
    (while (setq cur (memq ?\n next))
      (setq next (cdr cur))
      (setcar cur ?\\)
      (setcdr cur (cons ?n next)))
    (setq next tmp)
    (while (setq cur (memq ?\  next))
      (setq next (cdr cur))
      (setcar cur ?\\)
      (setcdr cur (cons ?s next)))
    (concat tmp)))

(defun scim-construct-command (list)
  (mapconcat (lambda (f) (scim-escape-string f)) list " "))

(defun scim-unescape-string (str)
  (let* ((tmp (append str nil))
         (cur tmp)
         next)
    (while (setq cur (memq ?\\ cur))
      (setq next (cdr cur))
      (setcar cur (car (or (rassq (car next)
                                  '((?\  . ?s)
                                    (?\n . ?n)
                                        ;                   (?\\ . ?\\)
                                    ))
                           next)))
      (setq cur (setcdr cur (cdr next))))
    (concat (delq nil tmp))))

(defun scim-split-commands (commands)
  (mapcar (lambda (line)
            (mapcar 'scim-unescape-string (split-string line " ")))
          (split-string (substring commands 0 -1) "\n")))

(defun scim-decode-event (event)
  ;; Convert Emacs event to scim-bridge command
  (let ((modifiers (mapcar (lambda (mod)
                             (cdr (assq mod scim-modifier-alist)))
                           (event-modifiers event)))
        (key-code (event-basic-type event)))
    (if (numberp key-code)
        (if (and (member "shift" modifiers)
                 (>= key-code ?a)
                 (<= key-code ?z))
            (setq key-code (- key-code 32)))
      (if (member "alt" modifiers)
          (setq key-code
                (or (cdr (assq key-code scim-alt-modifier-alist))
                    key-code)))
      (if (and scim-use-kana-ro-key
               scim-kana-ro-key-symbol
               (eq key-code scim-kana-ro-key-symbol))
          (setq key-code ?\\
                modifiers (cons "kana_ro" modifiers)))
      (setq key-code (or (cdr (assq key-code scim-keycode-alist))
                         key-code)))
    (cons key-code modifiers)))

(defun scim-encode-event (key-code modifiers)
  ;; Convert scim-bridge command to Emacs event
  (setq key-code (string-to-number key-code))
  (let ((bas (or (car (rassq key-code scim-keycode-alist))
                 (if (< key-code 128) key-code)))
        (mods nil))
    (if (member "alt" modifiers)
        (setq bas (or (car (rassq bas scim-alt-modifier-alist))
                      bas)))
    (while modifiers
      (let ((m (car (rassoc (car modifiers) scim-modifier-alist))))
        (if m (cond ((eq m 'caps-lock)
                     nil)               ; Ignore `caps_lock' modifier
                    ((eq m 'num-lock)
                     nil)               ; Ignore `num_lock' modifier
                    ((eq m 'kana-RO)
                     (if (and scim-use-kana-ro-key
                              scim-kana-ro-key-symbol
                              (eq bas ?\\)
                              (not scim-mode-map-prev-disabled))
                         (setq bas scim-kana-ro-key-symbol)))
                    (t (add-to-list 'mods m)))))
      (setq modifiers (cdr modifiers)))
    (if bas (event-convert-list (nconc mods (list bas))))))

(defconst scim-hex-table
  (vconcat (make-vector ?0 0)
           [0 1 2 3 4 5 6 7 8 9]
           (make-vector (- ?A ?9 1) 0)
           [10 11 12 13 14 15]
           (make-vector (- ?a ?F 1) 0)
           [10 11 12 13 14 15]
           (make-vector (- 127 ?f) 0)))

(defun scim-hexstr-to-number (string)
  (let ((len (length string))
        (ret 0) (pos 0))
    (while (< (setq ret (+ (* ret 16)
                           (aref scim-hex-table (aref string pos)))
                    pos (1+ pos))
              len))
    ret))

                                        ;(defun scim-hexstr-to-number (string &optional length)
                                        ;  (let ((pos (1- (or length (length string)))))
                                        ;    (+ (if (= pos 0)
                                        ;      0
                                        ;    (* 16 (scim-hexstr-to-number string pos)))
                                        ;       (aref scim-hex-table (aref string pos)))))

(defun scim-twos-complement (string)
  (let ((num (string-to-number string)))
    (if (< num 2147483648.0)
        (round num)
      (round (- num 4294967296.0)))))

(defun scim-null-command ()
  (interactive)
                                        ;#  (if scim-debug (scim-message "dummy event"))
  (when (interactive-p)
    (setq this-command last-command)
    (setq unread-command-events
          (delq 'scim-dummy-event unread-command-events))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Localization
(defun scim-set-group-doc (group string)
  "Change the documentation string of GROUP into STRING.
If STRING is empty or nil, the documentation string is left original."
  (if (> (length string) 0)
      (put group 'group-documentation string)))

(defun scim-set-variable-doc (variable string &optional custom-type)
  "Change the documentation string of VARIABLE into STRING.
If STRING is empty or nil, the documentation string is left original.
If CUSTOM-TYPE is non-nil, it is set to the `custom-type' property of
VARIABLE, which corresponds to the :type keyword in `defcustom'."
  (if (> (length string) 0)
      (put variable 'variable-documentation string))
  (if custom-type
      (put variable 'custom-type custom-type)))

(defun scim-set-face-doc (face string)
  "Change the documentation string of FACE into STRING.
If STRING is empty or nil, the documentation string is left original."
  (if (> (length string) 0)
      (put face 'face-documentation string)))

(defun scim-set-function-doc (function string)
  "Change the documentation string of FUNCTION into STRING.
If STRING is empty or nil, the documentation string is left original."
  (if (> (length string) 0)
      (let ((func (symbol-function function)))
        (if (byte-code-function-p func)
            (let ((new-func (append func nil)))
              (setcar (nthcdr 4 new-func) string)
              (fset function (apply 'make-byte-code new-func)))
          (setcar (nthcdr 2 func) string)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Messages & Log
(defmacro scim-message (format-string &rest args)
  `(if (not scim-debug)
       (message (concat "SCIM: " ,format-string) ,@args)
     (let ((log-str (format ,format-string ,@args)))
       (save-excursion
         (set-buffer (get-buffer-create scim-log-buffer))
         (goto-char (point-max))
         (insert (concat (format log-str) "\n"))))))

(defmacro scim-show-undo-list (format-string &rest args)
  `(progn
     (scim-message ,format-string ,@args)
     (if (not (listp buffer-undo-list))
         (scim-message "undo list (disabled): %s" buffer-undo-list)
       (scim-message " top: %s" (car buffer-undo-list))
       (scim-message " 2nd: %s" (car (cdr buffer-undo-list)))
       (scim-message " 3rd: %s" (car (cdr (cdr buffer-undo-list))))
       (scim-message " 4th: %s" (car (cdr (cdr (cdr buffer-undo-list))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Control buffer-undo-list
(defun scim-insert-and-modify-undo-list (str)
  (let* ((prev-list (if (car-safe buffer-undo-list)
                        buffer-undo-list
                      (cdr-safe buffer-undo-list)))
         (prev (car-safe prev-list))
         (consp-prev (and (consp prev)
                          (integerp (car prev))
                          (integerp (cdr prev))))
         (consecutivep (and consp-prev
                            (= (cdr prev) (point))
                            (not (= (preceding-char) ?\n))
                            (<= (+ (cdr prev) (length str))
                                (+ (car prev) 20))))) ; max 20 chars
                                        ;#    (if scim-debug (scim-show-undo-list "previous undo list"))
    (when (and consp-prev
               (integerp (car (cdr prev-list))))
                                        ;#      (if scim-debug (scim-show-undo-list "get rid of point setting entry"))
      (setcdr prev-list (cdr (cdr prev-list))))
    (insert str)
                                        ;#    (if scim-debug (scim-show-undo-list "insert string: %S" str))
    (when (integerp (car (cdr-safe buffer-undo-list)))
                                        ;#      (if scim-debug (scim-show-undo-list "get rid of point setting entry"))
      (setcdr buffer-undo-list (cdr (cdr buffer-undo-list))))
    (if (and consecutivep
             (eq (cdr (cdr buffer-undo-list)) prev-list))
        (when (eq scim-last-command 'self-insert-command)
                                        ;#    (if scim-debug (scim-show-undo-list "unify consecutive insertion entries"))
          (setcar (car buffer-undo-list) (car (car prev-list)))
          (setcdr buffer-undo-list (cdr prev-list)))
      (when (and (> (length str) 20)
                 (listp buffer-undo-list)) ; Undo enabled?
        (let ((beg (car (car buffer-undo-list)))
              (end (cdr (car buffer-undo-list)))
              (new-list (cdr buffer-undo-list)))
                                        ;#    (if scim-debug (scim-show-undo-list "divide long insertion entry"))
          (while (> (- end beg) 20)
            (setq new-list (cons nil (cons (cons beg (+ beg 20)) new-list))
                  beg (+ beg 20)))
          (setq buffer-undo-list (cons (cons beg end) new-list)))))))

;; Advices for undo commands
(mapc '(lambda (command)
         (eval
          `(defadvice ,command
             (around ,(intern (concat "scim-inhibit-" (symbol-name command))) ())
             (if scim-preediting-p
                 (error "SCIM: `%s' cannot be used while preediting!" ',command)
               ad-do-it))))
      scim-undo-command-list)

(defun scim-activate-advices-undo (enable)
  (if enable
      (ad-enable-regexp "^scim-inhibit-")
    (ad-disable-regexp "^scim-inhibit-"))
  (ad-activate-regexp "^scim-inhibit-"))

;; Advices for `yasnippet.el'
(mapc '(lambda (command)
         (eval
          `(defadvice ,command
             (around ,(intern (concat "scim-inhibit-" (symbol-name command))) ())
             (unless scim-preediting-p
               ad-do-it))))
      '(yas/field-undo-before-hook
        yas/check-cleanup-snippet
        yas/field-undo-after-hook))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Control keyboard
(defun scim-set-mode-map-alist ()
  (setq scim-mode-map-alist
        (list (cons 'scim-mode scim-mode-map)
              (cons 'scim-preediting-p scim-mode-preedit-map))))

(defun scim-set-keymap-parent ()
  (set-keymap-parent scim-mode-map
                     (cond
                      (scim-mode-map-prev-disabled
                       nil)
                      ((or (not scim-use-minimum-keymap)
                           scim-imcontext-status)
                       scim-mode-common-map)
                      (t
                       scim-mode-minimum-map))))

(defun scim-enable-kana-ro-key (&optional keysym)
  (unless keysym (setq keysym scim-kana-ro-x-keysym))
                                        ;#  (if scim-debug (scim-message "enable Kana-RO key: %s" keysym))
  (shell-command-to-string
   (concat "xmodmap -pke | sed -n 's/= backslash underscore/= "
           keysym " underscore/p' | xmodmap -"))
  (setq scim-kana-ro-prev-x-keysym keysym))

(defun scim-disable-kana-ro-key (&optional keysym)
  (unless keysym (setq keysym scim-kana-ro-prev-x-keysym))
  (when keysym
                                        ;#    (if scim-debug (scim-message "disable Kana-RO key: %s" keysym))
    (shell-command-to-string
     (concat "xmodmap -pke | sed -n 's/= " keysym
             " underscore/= backslash underscore/p' | xmodmap -"))
    (setq scim-kana-ro-prev-x-keysym nil)))

(defun scim-get-keyboard-layout ()
  (let ((kbd (shell-command-to-string
              "xprop -root _XKB_RULES_NAMES | sed -n 's/.* = \"[^\"]*\", *\"\\([^\"]*\\)\".*/\\1/p'")))
    (unless (string= kbd "") (intern (substring kbd 0 -1)))))

(defun scim-update-kana-ro-key (&optional inhibit delayed)
  (when (eq scim-keyboard-layout 'jp106)
    (if (and (not inhibit)
             scim-use-kana-ro-key
             scim-kana-ro-x-keysym
             scim-frame-focus
             (not scim-mode-map-prev-disabled)
             (or (not scim-use-minimum-keymap) scim-imcontext-status))
        (if delayed
            (let ((cycle (if scim-net-active-window-unsupported
                             scim-focus-update-interval-long
                           scim-focus-update-interval)))
              (run-at-time (+ cycle 0.1) nil 'scim-enable-kana-ro-key))
          (scim-enable-kana-ro-key))
      (scim-disable-kana-ro-key))))

(defun scim-switch-keymap (enable)
  (if (and (not enable)
           scim-preediting-p)
      (scim-abort-preedit))
  (setq scim-mode-map-prev-disabled (not enable))
  (scim-update-cursor-color)
  (scim-set-keymap-parent)
  (if (and scim-use-kana-ro-key
           scim-kana-ro-x-keysym
           scim-frame-focus
           (or (not scim-use-minimum-keymap) scim-imcontext-status))
      (scim-update-kana-ro-key)))

(defun scim-enable-keymap ()
  (interactive)
  (if scim-mode
      (scim-switch-keymap t))
  (setq scim-mode-map-disabled nil))

(defun scim-disable-keymap ()
  (interactive)
  (if scim-mode
      (scim-switch-keymap nil))
  (setq scim-mode-map-disabled t))

(defun scim-make-keymap-internal (keys &optional parent &rest ranges)
  (let ((map (if ranges (make-keymap) (make-sparse-keymap))))
    (if parent (set-keymap-parent map parent))
    (while ranges
      (let ((i (caar ranges))
            (max (cdar ranges)))
        (while (<= i max)
          (define-key map (char-to-string i) 'scim-handle-event)
          (setq i (1+ i))))
      (setq ranges (cdr ranges)))
    (while keys
      (let* ((key (reverse (car keys)))
             (bas (car key))
             (mods (cdr key)))
        (if (stringp bas)
            (setq bas (string-to-char bas)))
        (when (memq 'alt mods)
          (unless scim-meta-key-exists
            (setq mods (cons 'meta (delq 'alt mods))))
          (setq bas (or (car (rassq bas scim-alt-modifier-alist))
                        bas)))
        (define-key map (vector (nconc mods (list bas))) 'scim-handle-event)
        (setq keys (cdr keys))))
    map))

(defun scim-combine-modifiers (base modifiers)
  (if modifiers
      (apply 'nconc
             (mapcar
              (lambda (k) (list (cons (car modifiers) k) k))
              (scim-combine-modifiers base (cdr modifiers))))
    (list (list base))))

(defun scim-make-minimum-map ()
  (scim-make-keymap-internal scim-common-function-key-list))

(defun scim-make-kana-ro-map ()
  (scim-make-keymap-internal (if (and scim-use-kana-ro-key
                                      scim-kana-ro-key-symbol)
                                 (scim-combine-modifiers
                                  scim-kana-ro-key-symbol
                                  '(meta control hyper super alt)))
                             scim-mode-minimum-map))

(defun scim-make-common-map ()
  (scim-make-keymap-internal nil
                             scim-mode-kana-ro-map
                             '(32 . 126)))

(defun scim-make-preedit-map ()
  (scim-make-keymap-internal scim-preedit-function-key-list
                             nil
                             '(0 . 26) '(28 . 31)))

(defun scim-update-key-bindings (&optional symbol)
  (when (and scim-frame-focus
             (not scim-mode-map-prev-disabled)
             (or (null symbol)
                 (and (eq symbol 'scim-use-kana-ro-key)
                      scim-kana-ro-x-keysym
                      (or (not scim-use-minimum-keymap) scim-imcontext-status))
                 (and (eq symbol 'scim-kana-ro-x-keysym)
                      scim-use-kana-ro-key
                      (or (not scim-use-minimum-keymap) scim-imcontext-status))
                 (and (eq symbol 'scim-use-minimum-keymap)
                      (not scim-imcontext-status)
                      scim-use-kana-ro-key
                      scim-kana-ro-x-keysym)))
    (when (memq symbol '(nil scim-kana-ro-x-keysym))
      (scim-update-kana-ro-key t))
    (scim-update-kana-ro-key))
  (when (null symbol)
                                        ;#    (if scim-debug (scim-message "update scim-mode-minimum-map"))
    (if (keymapp scim-mode-minimum-map)
        (setcdr scim-mode-minimum-map (cdr (scim-make-minimum-map)))
      (setq scim-mode-minimum-map (scim-make-minimum-map))))
  (when (memq symbol '(nil scim-use-kana-ro-key scim-kana-ro-key-symbol))
                                        ;#    (if scim-debug (scim-message "update scim-mode-kana-ro-map"))
    (if (keymapp scim-mode-kana-ro-map)
        (setcdr scim-mode-kana-ro-map (cdr (scim-make-kana-ro-map)))
      (setq scim-mode-kana-ro-map (scim-make-kana-ro-map))))
  (when (memq symbol '(nil scim-common-function-key-list))
                                        ;#    (if scim-debug (scim-message "update scim-mode-common-map"))
    (if (keymapp scim-mode-common-map)
        (setcdr scim-mode-common-map (cdr (scim-make-common-map)))
      (setq scim-mode-common-map (scim-make-common-map))))
  (when (memq symbol '(nil scim-use-minimum-keymap))
                                        ;#    (if scim-debug (scim-message "update scim-mode-map"))
    (unless (keymapp scim-mode-map)
      (setq scim-mode-map (make-sparse-keymap)))
    (define-key scim-mode-map [scim-receive-event] 'scim-bridge-receive)
    (define-key scim-mode-map [scim-dummy-event] 'scim-null-command)
    (scim-set-keymap-parent))
  (when (memq symbol '(nil scim-preedit-function-key-list))
                                        ;#    (if scim-debug (scim-message "update scim-mode-preedit-map"))
    (if (keymapp scim-mode-preedit-map)
        (setcdr scim-mode-preedit-map (cdr (scim-make-preedit-map)))
      (setq scim-mode-preedit-map (scim-make-preedit-map)))))

(defun scim-define-key (symbol keys handle)
  ;; If keys is given as an array, it doesn't indicate key sequence,
  ;; but multiple definitions of single keystroke.
  (let ((keys-list (if (arrayp keys)
                       (listify-key-sequence keys)
                     (list keys))))
    (while keys-list
      (let ((key (car keys-list)))
        (if (listp key)
            (let* ((n (1- (length key)))
                   (bas (nth n key)))
              ;; If the key event is specified by a list and the last
              ;; element is given as a string, the code number for the first
              ;; character of the string is used for an event basic type.
              (when (stringp bas)
                (setq key (copy-sequence key))
                (setcar (nthcdr n key) (string-to-char bas)))
              (setq key (event-convert-list key))))
        ;; In Emacs 22, the function `event-modifiers' cannot return the
        ;; correct value until the symbol is parsed.
        (key-binding (vector key))
        ;; It is necessary to call a function `event-basic-type' after
        ;; `event-modifiers' because `event-basic-type' uses the symbol
        ;; property `event-symbol-elements' added by `event-modifiers'
        ;; when event is given as a symbol.
        (let ((modifiers (event-modifiers key))
              (key-code (event-basic-type key)))
          (if (integerp key-code)
              (setq key-code (char-to-string key-code)
                    modifiers (reverse modifiers)))
          (setq key (append modifiers (list key-code))))
        (if handle
            (add-to-list symbol key)
          (set symbol (delete key (symbol-value symbol)))))
      (setq keys-list (cdr keys-list)))
    (symbol-value symbol)))             ; Return value

(defun scim-define-common-key (key handle)
  "Specify which key events SCIM anytime takes over. If HANDLE
is non-nil, SCIM handles the key events given by KEY. When KEY is
given as an array, it doesn't indicate key sequence, but multiple
definitions of single keystroke.
 It is necessary to call a function `scim-update-key-bindings' or
restart scim-mode so that this settings may become effective."
  (scim-define-key 'scim-common-function-key-list key handle))

(defun scim-define-preedit-key (key handle)
  "Specify which key events SCIM takes over when preediting. If
HANDLE is non-nil, SCIM handles the key events given by KEY. When
KEY is given as an array, it doesn't indicate key sequence, but
multiple definitions of single keystroke.
 It is necessary to call a function `scim-update-key-bindings' or
restart scim-mode so that this settings may become effective."
  (scim-define-key 'scim-preedit-function-key-list key handle))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Control display
(defun scim-update-mode-line ()
  (force-mode-line-update)
  scim-mode)                            ; Return value

(defun scim-set-cursor-color (&optional single-frame)
  (let ((color (cond
                ((or (null scim-cursor-color)
                     (null scim-imcontext-id))
                 nil)
                ((stringp scim-cursor-color)
                 (if scim-imcontext-status
                     scim-cursor-color))
                ((consp scim-cursor-color)
                 (let ((tail (cdr scim-cursor-color)))
                   (cond
                    ((stringp tail)
                     (if scim-imcontext-status
                         (car scim-cursor-color)
                       tail))
                    ((consp tail)
                     (if scim-mode-map-prev-disabled
                         (cadr tail)
                       (if scim-imcontext-status
                           (car scim-cursor-color)
                         (car tail)))))))))
        (viper (and (boundp 'viper-mode)
                    viper-mode
                    (eq (with-no-warnings viper-current-state) 'insert-state)))
        (orig-frame (selected-frame)))
                                        ;#    (if scim-debug (scim-message "set cursor color: %s" color))
    (condition-case err
        (while (progn
                 (unless single-frame
                   (select-frame (next-frame nil t)))
                 (let ((color (or color
                                  (frame-parameter nil 'foreground-color))))
                   (when (or (eq (window-buffer (frame-selected-window))
                                 scim-current-buffer)
                             (not scim-mode))
                     (if viper
                         (with-no-warnings
                           (setq viper-insert-state-cursor-color color)
                           (viper-set-cursor-color-according-to-state))
                       (set-cursor-color color))))
                 (not (eq (selected-frame) orig-frame))))
      (error
       (select-frame orig-frame)
       (scim-message "Failed to set cursor color %s" err)))))

(defun scim-update-cursor-color (&optional single-frame)
  (if (and scim-cursor-color
           (eq (selected-frame) scim-selected-frame))
      (scim-set-cursor-color single-frame)))

(defun scim-after-make-frame-function (frame)
  (save-current-buffer
    (let ((old-frame (selected-frame)))
      (unwind-protect
          (progn
            (select-frame frame)
            (set-buffer (window-buffer (frame-selected-window)))
            (let ((scim-selected-frame frame))
              (scim-update-cursor-color t)))
        (select-frame old-frame)))))

(defun scim-reset-imcontext-statuses ()
  "Reset entirely the variables which keep the IMContext statuses
of each buffer in order to correct impropriety of the cursor color.
This function might be invoked just after using SCIM GUI Setup Utility."
  (if scim-mode-local
      (let ((buffers (buffer-list)))
        (save-current-buffer
          (while buffers
            (set-buffer (car buffers))
            (if (local-variable-p 'scim-imcontext-status)
                (setq scim-imcontext-status nil))
            (setq buffers (cdr buffers)))))
    (setq-default scim-imcontext-status nil))
  (scim-update-cursor-color))

                                        ;(defun scim-title-bar-height ()
                                        ;  "Return the pixel hight of title bar of selected frame."
                                        ;  (let* ((window-id (frame-parameter nil 'outer-window-id))
                                        ;    (line (shell-command-to-string
                                        ;       (concat "xprop -id " window-id " _NET_FRAME_EXTENTS"))))
                                        ;    (string-to-number (substring line
                                        ;                (string-match "[0-9]+,[ 0-9]+$" line)
                                        ;                (string-match ",[ 0-9]+$" line)))))

(defun scim-get-frame-extents ()
  "Return the pixel width of frame edges as (left right top bottom).
Here, `top' also indicates the hight of frame title bar."
                                        ;#  (if scim-debug (scim-message "get frame extents"))
  (let* ((window-id (frame-parameter nil 'outer-window-id))
         (line (shell-command-to-string
                (concat "xprop -id " window-id " _NET_FRAME_EXTENTS")))
         (start (string-match "[0-9]" line)))
    (if start
        (mapcar 'string-to-number
                (split-string (substring line start -1) ","))
      ;; `_NET_FRAME_EXTENTS' not supported
      (let* ((line (shell-command-to-string
                    (concat "xwininfo -id " window-id
                            " | grep 'Relative upper-left'")))
             (x (string-to-number
                 (substring line (+ (string-match "X:" line) 3))))
             (y (string-to-number
                 (substring line (+ (string-match "Y:" line) 3)))))
        (list x x y 0)))))

(defun scim-save-frame-extents ()
  (setq scim-frame-extents (if (frame-parameter nil 'parent-id)
                               ;; no display effect
                               (scim-get-frame-extents)
                             ;; with Compiz fusion effects
                             '(0 0 0 0))))

(defun scim-frame-header-height ()
  "Return the total of pixel height of menu-bar and tool-bar.
The value that this function returns is not so accurate."
  (- (frame-pixel-height)
     (* (frame-height) (frame-char-height))
     scim-adjust-window-y-offset))

(defun scim-real-frame-header-height ()
  "Return the total of pixel height of menu-bar and tool-bar.
The value that this function returns is very exact, but this function
is quite slower than `scim-frame-header-height'."
                                        ;#  (if scim-debug (scim-message "get frame header height"))
  (let* ((window-id (frame-parameter nil 'window-id))
         (line (shell-command-to-string
                (concat "xwininfo -id " window-id
                        " | grep 'Relative upper-left Y:'"))))
    (string-to-number
     (substring line (string-match "[0-9]+$" line)))))

(defun scim-set-window-y-offset ()
  (setq scim-adjust-window-y-offset
        (or (if scim-adjust-window-y-position
                (let* ((scim-adjust-window-y-offset 0)
                       (gap (- (scim-frame-header-height)
                               (scim-real-frame-header-height))))
                  (if (< gap (frame-char-height)) gap)))
            0)))

(defun scim-compute-pixel-position ()
  "Return the screen pxel position of point as (X . Y).
Its values show the coordinates of lower left corner of the character."
                                        ;#;  (if scim-debug (scim-message "current-buffer: %s  pos: %d" (current-buffer) (point)))
  (let ((x-y (or (posn-x-y (posn-at-point))
                 '(0 . 0))))
                                        ;#;    (if scim-debug (scim-message "(x . y): %s" x-y))
    (cons (+ (frame-parameter nil 'left)
             (car scim-frame-extents)
             (car (window-inside-pixel-edges))
             (car x-y))
          (+ (frame-parameter nil 'top)
             (nth 2 scim-frame-extents)
             (scim-frame-header-height)
             (car (cdr (window-pixel-edges)))
             (cdr x-y)
             (frame-char-height)))))

(defun scim-get-gnome-font-size ()
  "Return the pixel size of application font in the GNOME desktop
environment. It is necessary to set the screen resolution (dots per
inch) and to be able to use a shell command `gconftool-2'. If not,
this function returns zero."
  (if (string= (shell-command-to-string "which gconftool-2") "")
      0
    (let ((font (shell-command-to-string
                 "gconftool-2 -g /desktop/gnome/interface/font_name"))
          (dpi (shell-command-to-string
                "gconftool-2 -g /desktop/gnome/font_rendering/dpi")))
      (/ (* (string-to-number
             (substring font (string-match "[0-9]+$" font) -1))
            (string-to-number dpi))
         72))))

(defun scim-set-window-x-offset ()
  (setq scim-adjust-window-x-offset
        (cond ((eq scim-adjust-window-x-position 'gnome)
               (+ (scim-get-gnome-font-size) 4))
              ((integerp scim-adjust-window-x-position)
               scim-adjust-window-x-position)
              (t 0))))

(defun scim-get-active-window-id ()
  "Return the number of the window-system window which is foreground,
i.e. input focus is in this window."
  (if scim-net-active-window-unsupported
      (string-to-number
       (shell-command-to-string
        "xwininfo -root -children -int | grep -v '\"scim-panel-gtk\"\\|\"tomoe\"\\|\"nagisa\"\\|(has no name)' | grep ' children:$' -A 1 | tail -n 1"))
    (let* ((line (shell-command-to-string "xprop -root _NET_ACTIVE_WINDOW"))
           (pos (string-match "[0-9a-fA-F]+$" line)))
      (if pos
          (scim-hexstr-to-number (substring line pos -1))
        (scim-message "Active window ID cannot be obtained by `xprop'. Instead, `xwininfo' is used.")
        (setq scim-net-active-window-unsupported t)
        (scim-get-active-window-id)))))

(defun scim-config-file-timestamp ()
  (let ((time (nth 5 (file-attributes scim-config-file))))
    (+ (* (car time) 65536) (cadr time))))

(defun scim-check-frame-focus (&optional focus-in)
  (let ((window-id (string-to-number
                    (frame-parameter nil 'outer-window-id)))
        (active-win (scim-get-active-window-id))
        (stat-toggled (or (not scim-frame-focus) focus-in)))
    (when (eq (eq window-id active-win) stat-toggled)
      (if stat-toggled
          (when (and (not scim-frame-focus)
                     scim-config-last-modtime
                     (> (scim-config-file-timestamp) scim-config-last-modtime))
                                        ;#      (if scim-debug (scim-message "SCIM's settings changed"))
            (scim-reset-imcontext-statuses))
        (setq scim-config-last-modtime (scim-config-file-timestamp)))
      (setq scim-frame-focus stat-toggled)
                                        ;#      (if scim-debug (scim-message "change focus: %s" (and scim-frame-focus (current-buffer))))
                                        ;#      (if scim-debug (scim-message "scim-current-buffer: %s" scim-current-buffer))
      (when (and (stringp scim-imcontext-id)
                 (eq (current-buffer) scim-current-buffer))
        (when (and scim-use-kana-ro-key
                   scim-kana-ro-x-keysym)
          (scim-update-kana-ro-key nil t))
        (let ((preediting-p scim-preediting-p))
          (scim-change-focus scim-frame-focus) ; Send
          (unless preediting-p
            (scim-bridge-receive)))     ; Receive
        (when scim-frame-focus
          (scim-save-frame-extents)
          (scim-set-window-x-offset)
          (scim-set-window-y-offset)))
      (unless focus-in
        ;; Set dummy event as a trigger of `post-command-hook'
        (setq unread-command-events
              (cons 'scim-dummy-event unread-command-events))))))

(defun scim-cancel-focus-update-timer ()
  (when scim-focus-update-timer
    (cancel-timer scim-focus-update-timer)
    (setq scim-focus-update-timer nil)))

(defun scim-start-focus-observation ()
  (let ((cycle (if (or scim-net-active-window-unsupported
                       scim-mode-map-prev-disabled
                       (not scim-imcontext-status)
                       (not scim-frame-focus))
                   scim-focus-update-interval-long
                 scim-focus-update-interval)))
    (scim-cancel-focus-update-timer)
    (setq scim-focus-update-timer
          (run-at-time cycle cycle 'scim-check-frame-focus))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Manipulate preediting area
(defun scim-check-rgb-color (string)
  (and (eq (length string) 7)
       (string-match "^#[0-9A-Fa-f]+$" string)))

(defun scim-select-face-by-attr (attr)
  (cdr (assoc attr
              '(("underline" . scim-preedit-underline-face)
                ("highlight" . scim-preedit-highlight-face)
                ("reverse" . scim-preedit-reverse-face)))))

(defun scim-remove-preedit (&optional abort)
  (remove-hook 'before-change-functions 'scim-before-change-function)
  (unless (or (string= scim-preedit-prev-string "")
              abort)
    (let ((pos scim-preedit-point)
          (inhibit-read-only t)
          (inhibit-modification-hooks t))
      (condition-case err
          (progn
            (if (consp buffer-undo-list)
                ;; `buffer-undo-list' contains undo information
                (progn
                  (let ((undo-in-progress t))
                    (setq buffer-undo-list (primitive-undo 2 buffer-undo-list)))
                  ;; Restore modification flag of yasnippet field at cursor position
                  (mapc (lambda (overlay)
                          (when (overlay-get overlay 'yas/modified?)
                            (overlay-put
                             overlay 'yas/modified?
                             (overlay-get overlay 'scim-saved-yas/modified?))))
                        (overlays-at pos)))
              ;; Undo disabled or `buffer-undo-list' is empty
              (let (buffer-undo-list)
                (delete-region pos (+ pos (length scim-preedit-prev-string)))))
            (undo-boundary)
            (goto-char pos)
            ;; Invoke function bound to `point-entered' text property
            (let ((func (get-text-property pos 'point-entered)))
              (when func
                (funcall func))))
        (error
         (scim-message "Failed to delete preediting text %s" err)))))
  (mapc 'delete-overlay scim-preedit-overlays)
  (when (local-variable-p 'scim-cursor-type-saved)
    (if (eq scim-cursor-type-saved 1)
        (kill-local-variable 'cursor-type)
      (setq cursor-type scim-cursor-type-saved))
    (kill-local-variable 'scim-cursor-type-saved))
  (setq scim-preedit-prev-string ""
        scim-preedit-prev-curpos 0
        scim-preedit-prev-attributes nil
        scim-preedit-overlays nil)
  (set-marker scim-preedit-point nil)
  (when scim-keymap-overlay
    (delete-overlay scim-keymap-overlay)
    (setq scim-keymap-overlay nil))
  (setq scim-preediting-p nil))

(defun scim-cleanup-preedit (&optional abort)
  (scim-remove-preedit abort)
                                        ;#  (if scim-debug (scim-message "cleanup preedit"))
  (setq scim-preedit-update nil
        scim-preedit-shown ""
        scim-preedit-string ""
        scim-preedit-curpos 0
        scim-preedit-attributes nil
        scim-committed-string ""))

(defun scim-show-preedit (&optional resume)
  (setq scim-preedit-update nil)
  (if resume (setq scim-surrounding-text-modified t))
  (let* ((str scim-preedit-string)
         (attrs scim-preedit-attributes)
         (empty (or (string= scim-preedit-shown "FALSE")
                    (string= str ""))))
    (cond
     ;; isearch-mode
     ((and scim-isearch-minibuffer
           scim-surrounding-text-modified
           (not empty))
                                        ;#      (if scim-debug (scim-message "preediting text not shown"))
      (add-to-list 'unread-command-events 'scim-resume-preedit))
     ;; IMContext is empty or invisible
     (empty
      (scim-cleanup-preedit))
     ;; IMContext contains preedit string
     (resume
      (setq scim-preedit-update t))
     ((not (and scim-preediting-p
                (string= str scim-preedit-prev-string)
                (= scim-preedit-curpos scim-preedit-prev-curpos)
                (equal attrs scim-preedit-prev-attributes)))
      (if scim-preediting-p
          (scim-remove-preedit)
        (scim-set-window-y-offset)
        (unless scim-surrounding-text-modified
                                        ;#    (if scim-debug (scim-message "cleanup base attribute"))
          (setq scim-preedit-default-attr nil)))
      ;; Put String
      (setq scim-preediting-p (current-buffer))
      (setq scim-keymap-overlay (make-overlay (point-min) (1+ (point-max)) nil nil t))
      (overlay-put scim-keymap-overlay 'keymap scim-mode-preedit-map)
      (overlay-put scim-keymap-overlay 'priority 100) ; override yasnippet's keymap
      (set-marker scim-preedit-point (point))
                                        ;#;      (if scim-debug (scim-message "current cursor position: %d" scim-preedit-point))
      (mapc (lambda (overlay)
              (when (overlay-get overlay 'yas/modified?)
                (overlay-put overlay 'scim-saved-yas/modified? t)))
            (overlays-at scim-preedit-point))
      (undo-boundary)
      (condition-case err
          (insert str)
        (text-read-only
         (scim-message "Failed to insert preediting text %s" err)
         (scim-cleanup-preedit)
         (let ((scim-string-insertion-failed nil))
           (scim-reset-imcontext))
         (setq str ""
               scim-string-insertion-failed t)))
      (undo-boundary)
      (unless (string= str "")
        (setq scim-preedit-prev-string str
              scim-preedit-prev-curpos scim-preedit-curpos
              scim-preedit-prev-attributes attrs)
        ;; Set attributes
                                        ;#; (if scim-debug (scim-message "attributes: %s" attrs))
        (let* ((max (length str))
               (ol (make-overlay scim-preedit-point
                                 (+ scim-preedit-point max)))
               (flat-attr nil))
          (overlay-put ol 'face 'scim-preedit-default-face)
          (overlay-put ol 'priority 0)
          (setq scim-preedit-overlays (list ol))
          (while attrs
            (let* ((beg (string-to-number (car attrs)))
                   (end (string-to-number
                         (car (setq attrs (cdr attrs)))))
                   (type (car (setq attrs (cdr attrs))))
                   (value (car (setq attrs (cdr attrs))))
                   fc pr)
                                        ;#;       (if scim-debug (scim-message "beg: %d  end: %d  type: %s  val: %s" begin end type value))
              (setq attrs (cdr attrs))
              (if (cond ((and (string= type "foreground")
                              (scim-check-rgb-color value))
                         (setq fc (list :foreground value)
                               pr 50))
                        ((and (string= type "background")
                              (scim-check-rgb-color value))
                         (setq fc (list :background value)
                               pr 50))
                        ((and (string= type "decoreate")
                              (setq fc (scim-select-face-by-attr value)))
                         (setq pr 100)))
                  (let ((ol (make-overlay (+ scim-preedit-point beg)
                                          (+ scim-preedit-point end))))
                    (overlay-put ol 'face fc)
                    (overlay-put ol 'priority pr)
                    (setq scim-preedit-overlays
                          (cons ol scim-preedit-overlays))
                    (setq flat-attr (if (and (listp flat-attr)
                                             (eq beg 0) (eq end max))
                                        (cons fc flat-attr)
                                      t)))
                (scim-message "Unable to set attribute \"%s %s\"." type value))))
          ;; This modification hook must be registered as a global hook because
          ;; local hooks might be reset when major mode is changed.
          (add-hook 'before-change-functions 'scim-before-change-function)
          (setq flat-attr (or flat-attr
                              'none)
                scim-preedit-default-attr (or scim-preedit-default-attr
                                              flat-attr))
                                        ;#    (if scim-debug (scim-message "default attr: %s" scim-preedit-default-attr))
                                        ;#    (if scim-debug (scim-message "current attr: %s" flat-attr))
          (if (or (eq flat-attr t)
                  (not (equal flat-attr scim-preedit-default-attr)))
              ;; When conversion candidate is shown
              (progn
                (unless (or (eq scim-cursor-type-for-candidate 0)
                            (local-variable-p 'scim-cursor-type-saved))
                  (setq scim-cursor-type-saved
                        (or (and (local-variable-p 'cursor-type) cursor-type)
                            1)))        ; 1 means that global value has been used
                (if scim-put-cursor-on-candidate
                    (goto-char (+ scim-preedit-point scim-preedit-curpos)))
                (scim-set-cursor-location))
            ;; When the string is preedited or prediction window is shown
            (goto-char (+ scim-preedit-point scim-preedit-curpos))
            (if (car scim-prediction-window-position)
                (setq scim-preedit-curpos 0))
            (if (cdr scim-prediction-window-position)
                (scim-set-cursor-location)
              (let ((scim-adjust-window-x-offset 0))
                (scim-set-cursor-location)))))
        (run-hooks 'scim-preedit-show-hook))
      ))))

(defun scim-do-update-preedit ()
  (when scim-preedit-update
                                        ;#    (if scim-debug (scim-message "preedit-update  win-buf: %s  cur-buf: %s  cmd-buf: %s  str: \"%s\"" (window-buffer) (current-buffer) scim-current-buffer scim-preedit-string))
    (scim-show-preedit)
    (unless scim-string-insertion-failed
      (scim-preedit-updated))))

(defun scim-abort-preedit ()
  (when scim-preediting-p
    (save-excursion
      (scim-cleanup-preedit (not scim-clear-preedit-when-unexpected-event)))
    (scim-reset-imcontext)))

(defun scim-before-change-function (&optional beg end)
  (when (eq (current-buffer) scim-current-buffer)
                                        ;#    (if scim-debug (scim-message "buffer will be modified (beg:%s  end:%s)" beg end))
                                        ;#    (if scim-debug (scim-message "cursor positon: %s" (point)))
    (unless (and (memq major-mode '(erc-mode
                                    rcirc-mode
                                    circe-server-mode
                                    circe-channel-mode))
                 (memq this-command '(nil scim-handle-event)))
      (scim-abort-preedit))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Manage buffer switching
(defun scim-check-current-buffer ()
                                        ;#;  (if scim-debug (scim-message "check current buffer"))
  (scim-cancel-focus-update-timer)
  (setq scim-last-rejected-event nil)
  (with-current-buffer (window-buffer)
    (let ((buffer (current-buffer)))
      ;; Switch IMContext between global and local
      (when (eq (local-variable-p 'scim-imcontext-id)
                (not scim-mode-local))
        (if (eq buffer scim-current-buffer)
            (scim-deregister-imcontext)
          (let ((scim-current-buffer buffer))
            (scim-deregister-imcontext))))
      ;; Change focus if buffer is switched to another
      (unless (eq buffer scim-current-buffer)
        ;; Focus out
                                        ;#  (if scim-debug (scim-message "buffer was changed from %s to %s" scim-current-buffer buffer))
        (when (buffer-live-p scim-current-buffer)
          (with-current-buffer scim-current-buffer
            (when (stringp scim-imcontext-id)
              (when scim-frame-focus
                (scim-change-focus nil) ; Send
                (scim-bridge-receive))  ; Receive
              (if scim-preediting-p
                  ;; Cleenup preedit if focus change become timeout
                  (scim-abort-preedit)))))
        (setq scim-frame-focus nil
              scim-current-buffer buffer)
        ;; Check whether buffer is already registered
        (unless (or scim-imcontext-id
                    (and (not (minibufferp buffer))
                         (eq (aref (buffer-name buffer) 0) ?\ ))) ; Buffer invisible?
                                        ;#    (if scim-debug (scim-message "new buffer was detected: %s" buffer))
          (scim-register-imcontext))
        ;; Focus in if window is active
        (when (stringp scim-imcontext-id)
          (scim-check-frame-focus t))
        (scim-set-keymap-parent)
        (scim-update-cursor-color)))
    ;; Disable keymap if buffer is read-only, explicitly disabled, or vi-mode.
    (if (eq (and (or buffer-read-only
                     scim-mode-map-disabled
                     (eq major-mode 'vi-mode)
                     (and (boundp 'vip-current-mode)
                          (eq vip-current-mode 'vi-mode))
                     (and (boundp 'viper-current-state)
                          (eq viper-current-state 'vi-state)))
                 (not (and isearch-mode
                           scim-use-kana-ro-key
                           scim-kana-ro-x-keysym)))
            (not scim-mode-map-prev-disabled))
        (scim-switch-keymap scim-mode-map-prev-disabled))
    ;; Set/restore cursor shape
    (when (local-variable-p 'scim-cursor-type-saved)
      (cond
       (scim-preediting-p
        (setq cursor-type scim-cursor-type-for-candidate))
       (isearch-mode
        (setq cursor-type scim-isearch-cursor-type))
       (t
        (if (eq scim-cursor-type-saved 1)
            (kill-local-variable 'cursor-type)
          (setq cursor-type scim-cursor-type-saved))
        (kill-local-variable 'scim-cursor-type-saved))))
    ;; Check selected frame
    (unless (eq (selected-frame) scim-selected-frame)
      (setq scim-selected-frame (selected-frame))
      (scim-update-cursor-color)))
  (scim-start-focus-observation))

(defun scim-kill-buffer-function ()
  (if (local-variable-p 'scim-imcontext-id)
      (scim-deregister-imcontext)
    (if (eq scim-current-buffer (current-buffer))
        (setq scim-current-buffer nil))))

(defun scim-exit-minibuffer-function ()
  (if (and scim-imcontext-temporary-for-minibuffer
           scim-mode-local)
      (scim-deregister-imcontext)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Communication with agent through an UNIX domain socket
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Disconnect
(defun scim-bridge-disconnect ()
  (let ((proc scim-bridge-socket))
    (setq scim-bridge-socket nil)
    (if (processp proc) (set-process-sentinel proc nil))
    (when (buffer-live-p scim-tmp-buffer)
      (with-current-buffer scim-tmp-buffer
        (remove-hook 'after-change-functions 'scim-bridge-set-receive-event t))
      (kill-buffer scim-tmp-buffer))
    (setq scim-tmp-buffer nil)
    (when (processp proc)
      (delete-process proc)
                                        ;#      (if scim-debug (scim-message "process: %s  status: %s" proc (process-status proc)))
      )))

(defun scim-bridge-process-sentinel (proc stat)
                                        ;#  (if scim-debug (scim-message "process: %s  status: %s" proc (substring stat 0 -1)))
  (scim-mode-quit)
  (when (scim-mode-on)                  ; Try to restart
    (scim-check-current-buffer)
    (scim-update-cursor-color)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Connect
(defun scim-bridge-connect-internal ()
  (unless (file-exists-p scim-bridge-socket-path)
    (scim-message "Launch SCIM-Bridge..."))
  (call-process-shell-command scim-bridge-name nil 0 nil "--noexit")
  (let ((i 0)
        proc error)
    (while (and (not (processp proc))
                (< i 10))               ; Try connection 10 times at maximum
      (sleep-for (* 0.1 i))
      (setq proc (condition-case err
                     (make-network-process
                      :name scim-bridge-name
                      :service scim-bridge-socket-path
                      :buffer scim-tmp-buffer-name
                      :family 'local :server nil :noquery t)
                   (error
                    (setq error err)
                    nil))
            i (1+ i)))
    (unless (processp proc)
      (scim-message "%s" error))
    proc))

(defun scim-bridge-connect ()
  (if (and (processp scim-bridge-socket)
           (not (assq (process-status scim-bridge-socket) '(open run))))
      (scim-bridge-disconnect))
  (unless (and (processp scim-bridge-socket)
               (assq (process-status scim-bridge-socket) '(open run)))
    (let ((proc (scim-bridge-connect-internal)))
      (setq scim-bridge-socket proc)
      (when (processp proc)
                                        ;#  (if scim-debug (scim-message "process: %s  status: %s" proc (process-status proc)))
        ;; `process-kill-without-query' is an obsolete function (as of Emacs 22.1)
                                        ;   (process-kill-without-query proc)
        (set-process-query-on-exit-flag proc nil)
        (set-process-coding-system proc 'utf-8 'utf-8)
        (set-process-sentinel proc 'scim-bridge-process-sentinel)
        (with-current-buffer scim-tmp-buffer-name
          (setq scim-tmp-buffer (current-buffer))
                                        ;#    (if scim-debug (scim-message "temp buffer: %s" scim-tmp-buffer))
          (unless scim-debug (buffer-disable-undo))
          (erase-buffer)
          ;; `make-local-hook' is an obsolete function (as of Emacs 21.1)
                                        ;     (make-local-hook 'after-change-functions)
          (add-hook 'after-change-functions
                    'scim-bridge-set-receive-event nil t))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Communicate with agent
(defun scim-bridge-receive ()
  (interactive)
  (when (interactive-p)
    (unless (eq last-command 'scim-handle-event)
      (setq scim-string-insertion-failed nil))
    (setq this-command last-command))
  (let ((repl nil))
    (with-current-buffer scim-tmp-buffer
      (let ((inhibit-modification-hooks t)
            (sec (and (floatp scim-bridge-timeout) scim-bridge-timeout))
            (msec (and (integerp scim-bridge-timeout) scim-bridge-timeout)))
        (when (= (point-max) 1)
          (accept-process-output scim-bridge-socket sec msec t))
        (when (and (> (point-max) 1)
                   (/= (char-before (point-max)) ?\n))
                                        ;#    (if scim-debug (scim-message "retry data reception"))
          (accept-process-output scim-bridge-socket sec msec t))
        (setq repl (buffer-string))
        (erase-buffer)
                                        ;#  (if scim-debug (scim-message "recv:\n%s" repl))
        (setq unread-command-events
              (delq 'scim-receive-event
                    (delq 'scim-dummy-event unread-command-events)))))
    (if (string= repl "")
        (scim-message "Data reception became timeout.")
      (when (buffer-live-p scim-current-buffer)
        (with-current-buffer scim-current-buffer
                                        ;#    (if scim-debug (scim-message "this-command: %s" this-command))
                                        ;#    (if scim-debug (scim-message "last-command: %s" last-command))
                                        ;#    (if scim-debug (scim-message "scim-last-command-event: %s" scim-last-command-event))
                                        ;#    (if scim-debug (scim-message "before-change-functions: %s" before-change-functions))
          (scim-parse-reply (scim-split-commands repl)))))))

(defun scim-bridge-send-only (command)
  (with-current-buffer scim-tmp-buffer
    (let ((inhibit-modification-hooks t))
      (erase-buffer)))
                                        ;#  (if scim-debug (scim-message "process: %s  status: %s" scim-bridge-socket (process-status scim-bridge-socket)))
                                        ;#  (if scim-debug (scim-message "send: %S" command))
  (condition-case err
      (process-send-string scim-bridge-socket (concat command "\n"))
    (error
     (scim-message "Couldn't send command to agent %s" err))))

(defun scim-bridge-send-receive (command)
  (scim-bridge-send-only command)
  (scim-bridge-receive))

(defun scim-bridge-set-receive-event (beg &optional end lng)
                                        ;#  (if scim-debug (scim-message "passively receive"))
  (setq unread-command-events
        (cons 'scim-receive-event unread-command-events)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Send command to agent
(defun scim-register-imcontext ()
  (unless scim-imcontext-id
    (when scim-mode-local
      (make-local-variable 'scim-imcontext-id)
      (put 'scim-imcontext-id 'permanent-local t)
      (make-local-variable 'scim-imcontext-status)
      (put 'scim-imcontext-status 'permanent-local t))
    (setq scim-imcontext-id 'RQ)
    (let ((scim-current-buffer (current-buffer)))
      (scim-bridge-send-receive "register_imcontext"))
    (unless (stringp scim-imcontext-id)
      (scim-message "Couldn't register imcontext.")
      (scim-imcontext-deregister))))

(defun scim-deregister-imcontext ()     ;(id)
  (if (stringp scim-imcontext-id)
      (progn
        (if scim-frame-focus (scim-change-focus nil))
        (scim-bridge-send-receive
         (concat "deregister_imcontext " scim-imcontext-id)))
    (if (local-variable-p 'scim-imcontext-id)
        (progn
          (kill-local-variable 'scim-imcontext-id)
          (kill-local-variable 'scim-imcontext-status))
      (setq-default scim-imcontext-id nil)
      (setq-default scim-imcontext-status nil))
    (if (eq scim-current-buffer (current-buffer))
        (setq scim-current-buffer nil))))

(defun scim-reset-imcontext ()     ;(id)
                                        ;#;  (if scim-debug (scim-message "buffer: %s" (current-buffer)))
  (scim-bridge-send-receive
   (concat "reset_imcontext " scim-imcontext-id)))

(defun scim-set-preedit-mode ()         ;(id mode)
  (scim-bridge-send-receive
   (concat "set_preedit_mode " scim-imcontext-id " embedded")))

(defun scim-change-focus (focus-in)     ;(id focus-in)
                                        ;  (unless (equal (buffer-name) "aaa.el") ; Debug code -- DON'T UNCOMMENT!!
  (scim-bridge-send-only                ; Result is not received in this function
   (concat "change_focus " scim-imcontext-id
           (if focus-in " true" " false"))))
                                        ;  ) ; Debug code

(defun scim-set-cursor-location ()      ;(id x y)
  (let* ((pixpos (save-excursion
                   (goto-char (+ scim-preedit-point scim-preedit-curpos))
                   (scim-compute-pixel-position)))
         (x (number-to-string
             (max (- (car pixpos) scim-adjust-window-x-offset) 1)))
         (y (number-to-string (cdr pixpos))))
                                        ;#    (if scim-debug (scim-message "cursor position: (%s, %s)" x y))
    (scim-bridge-send-only
     (concat "set_cursor_location " scim-imcontext-id " " x " " y))))

(defun scim-handle-key-event (key-code key-pressed modifiers) ;(id key-code key-pressed &rest modifiers)
  (scim-bridge-send-receive
   (scim-construct-command
    (append (list "handle_key_event"
                  scim-imcontext-id key-code key-pressed)
            modifiers))))

(defun scim-preedit-updated ()
  (scim-bridge-send-only "preedit_updated"))

(defun scim-string-commited ()
  (scim-bridge-send-only "string_commited"))

(defun scim-surrounding-text-gotten (retval cursor-position string)
  (scim-bridge-send-receive
   (scim-construct-command
    (cons "surrounding_text_gotten"
          (if retval
              (list "true" (number-to-string cursor-position) string)
            (list "false"))))))

(defun scim-surrounding-text-deleted (retval)
  (scim-bridge-send-receive
   (concat "surrounding_text_deleted " (if retval "true" "false"))))

(defun scim-surrounding-text-replaced (retval)
  (scim-bridge-send-receive
   (concat "surrounding_text_replaced " (if retval "true" "false"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Process commands from agent to clients
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun scim-imengine-status-changed (id enabled)
  (if (not (string= id scim-imcontext-id))
      (scim-message "IMContext ID (%s) is mismatched." id)
    (let ((status (equal enabled "TRUE")))
      (setq scim-imcontext-status status)
      (scim-update-cursor-color)
      (scim-set-keymap-parent)
      (when (and scim-use-kana-ro-key
                 scim-kana-ro-x-keysym
                 scim-use-minimum-keymap)
        (scim-update-kana-ro-key)))))

(defun scim-preedit-mode-changed ()
  t)

(defun scim-imcontext-registered (id)
  ;; Initialize IMContext
                                        ;#  (if scim-debug (scim-message "imcontext registered (id: %s  buf: %s)" id (if scim-mode-local (current-buffer) "global")))
  (setq scim-imcontext-id id
        scim-preedit-prev-string ""
        scim-preedit-overlays nil)
  (scim-cleanup-preedit)
  (scim-set-preedit-mode))

(defun scim-imcontext-deregister ()
                                        ;#  (if scim-debug (scim-message "imcontext deregistered (id: %s  buf: %s)" scim-imcontext-id (if (local-variable-p 'scim-imcontext-id) (current-buffer) "global")))
  (if (local-variable-p 'scim-imcontext-id)
      (progn
        (kill-local-variable 'scim-imcontext-id)
        (kill-local-variable 'scim-imcontext-status))
    (setq-default scim-imcontext-id nil)
    (setq-default scim-imcontext-status nil))
  (setq scim-current-buffer nil))

(defun scim-imcontext-reseted (id)
  t)

(defun scim-cursor-location-changed ()
  t)

(defun scim-key-event-handled (consumed)
  (if (or (string= consumed "true")
          (null scim-last-command-event))
      ;; If key event is handled
      (when scim-last-command-event
        ;; Send cursor location for displaying SCIM-Ruby history window
        (when (and (not scim-preedit-update)
                   (string= scim-preedit-prev-string "")
                   (string= scim-preedit-string ""))
          (let ((scim-preedit-point (point))
                (scim-adjust-window-x-offset 0))
            (scim-set-cursor-location)))
        (setq scim-last-command-event nil))
    ;; If key event is ignored
    (let* ((vec (vector scim-last-command-event))
           (event (or (and (boundp 'local-function-key-map)
                           (lookup-key local-function-key-map vec))
                      (lookup-key function-key-map vec)))
           keybind)
      (setq event (or (and (arrayp event)
                           (aref event 0))
                      scim-last-command-event))
      (let ((scim-mode-map-alist nil))  ; Disable keymap temporarily
        (if scim-keymap-overlay
            (overlay-put scim-keymap-overlay 'keymap nil))
        (setq keybind (key-binding (vector event)))
        (if (and (null keybind)
                 (integerp event)
                 (memq 'shift (event-modifiers event)))
            ;; Reset the 25th bit corresponding to the shift key
            (setq event (logand event (lognot ?\x2000000))
                  keybind (key-binding (vector event))))
        (if scim-keymap-overlay
            (overlay-put scim-keymap-overlay 'keymap scim-mode-preedit-map)))
                                        ;#      (if scim-debug (scim-message "event: --> %s --> %s" scim-last-command-event event))
      (if (or (eq scim-last-command-event scim-last-rejected-event)
              (eq keybind this-command)
              isearch-mode)
          (progn
            (scim-message "%s is undefined"
                          (single-key-description scim-last-command-event))
            (if isearch-mode
                (isearch-done)))
        (if (memq keybind '(self-insert-command
                            *table--cell-self-insert-command))
            ;; Self-insert command
            (progn
              (scim-do-update-preedit)
                                        ;#        (if scim-debug (scim-message "execute command: %s" keybind))
              (setq scim-last-rejected-event scim-last-command-event
                    scim-last-command-event nil
                    last-command-event event
                    last-command scim-last-command
                    this-command keybind)
              (unwind-protect
                  (if (and (eq keybind 'self-insert-command)
                           (eq scim-last-command 'self-insert-command))
                      (scim-insert-and-modify-undo-list (char-to-string event))
                    (command-execute keybind)
                    (if (eq keybind '*table--cell-self-insert-command)
                        (with-no-warnings
                          (table--finish-delayed-tasks))))
                (setq scim-last-rejected-event nil)))
          ;; The other commands
                                        ;#    (if scim-debug (scim-message "event rejected: %s" scim-last-command-event))
          (if scim-keymap-overlay
              (overlay-put scim-keymap-overlay 'keymap nil))
          (setq scim-mode-map-alist nil
                this-command scim-last-command
                unread-command-events
                (cons scim-last-command-event unread-command-events))
          (remove-hook 'post-command-hook 'scim-check-current-buffer)
          (add-hook 'pre-command-hook 'scim-rejected-event-command-pre-function)))))
  (setq scim-last-rejected-event scim-last-command-event
        scim-last-command-event nil))

(defun scim-rejected-event-command-pre-function ()
  (add-hook 'post-command-hook 'scim-check-current-buffer)
  (remove-hook 'pre-command-hook 'scim-rejected-event-command-pre-function)
  (if scim-keymap-overlay
      (overlay-put scim-keymap-overlay 'keymap scim-mode-preedit-map))
  (scim-set-mode-map-alist))

(defun scim-update-preedit (id)
  (if (not (string= id scim-imcontext-id))
      (scim-message "IMContext ID (%s) is mismatched." id)
    (setq scim-preedit-update t)))

(defun scim-set-preedit-string (id string)
  (if (not (string= id scim-imcontext-id))
      (scim-message "IMContext ID (%s) is mismatched." id)
    (setq scim-preedit-string string)))

(defun scim-set-preedit-attributes (id &rest attrs)
  (if (not (string= id scim-imcontext-id))
      (scim-message "IMContext ID (%s) is mismatched." id)
    (setq scim-preedit-attributes attrs)))

(defun scim-set-preedit-cursor-position (id position)
  (if (not (string= id scim-imcontext-id))
      (scim-message "IMContext ID (%s) is mismatched." id)
                                        ;#    (if scim-debug (scim-message "cursor position: %s" position))
    (setq scim-preedit-curpos (string-to-number position))))

(defun scim-set-preedit-shown (id shown)
  (if (not (string= id scim-imcontext-id))
      (scim-message "IMContext ID (%s) is mismatched." id)
    (setq scim-preedit-shown shown)))

(defun scim-set-commit-string (id string)
  (if (not (string= id scim-imcontext-id))
      (scim-message "IMContext ID (%s) is mismatched." id)
                                        ;#    (if scim-debug (scim-message "commit string: %s" string))
    (setq scim-committed-string string)
    (run-hooks 'scim-set-commit-string-hook)))

(defun scim-*table--cell-insert (string)
  (with-no-warnings
    (table--finish-delayed-tasks)
    (table-recognize-cell 'force)
    (eval (macroexpand                  ; Avoid byte-compile warnings for `table-with-cache-buffer'
           '(table-with-cache-buffer
             (insert string)
             (table--untabify (point-min) (point-max))
             (table--fill-region (point-min) (point-max))
             (setq table-inhibit-auto-fill-paragraph t))))
    (table--finish-delayed-tasks)))

(defun scim-commit-string (id)
  (cond
   ((not (string= id scim-imcontext-id))
    (scim-message "IMContext ID (%s) is mismatched." id))
   (isearch-mode
    (isearch-process-search-string scim-committed-string scim-committed-string)
    (scim-string-commited))
   (buffer-read-only
    (scim-message "Buffer is read-only: %S" (current-buffer)))
   ((not scim-string-insertion-failed)
    (scim-remove-preedit)
    (condition-case err
        (progn
          (cond
           ((and (boundp 'table-mode-indicator)
                 table-mode-indicator)
            (scim-*table--cell-insert scim-committed-string))
           (scim-undo-by-committed-string
            (insert scim-committed-string))
           (t
            (scim-insert-and-modify-undo-list scim-committed-string)))
          (setq scim-last-command 'self-insert-command)
          (scim-string-commited)
          (run-hooks 'scim-commit-string-hook))
      (text-read-only
       (scim-message "Failed to commit string %s" err)
       (setq scim-string-insertion-failed t)))
    (scim-show-preedit t))))

(defun scim-forward-key-event (id key-code key-pressed &rest modifiers)
  (let ((event (scim-encode-event key-code modifiers)))
    (if event
        (if (string= key-pressed "TRUE")
            (setq unread-command-events (cons event unread-command-events)))
      (if (not (string= id scim-imcontext-id))
          (scim-message "IMContext ID (%s) is mismatched." id)
        (scim-handle-key-event key-code key-pressed modifiers)))))

(defun scim-get-surrounding-text (id before-max after-max)
  (if (not (string= id scim-imcontext-id))
      (scim-message "IMContext ID (%s) is mismatched." id)
    (let* ((len-before (scim-twos-complement before-max))
           (len-after (scim-twos-complement after-max))
           (end-before (if scim-preediting-p
                           scim-preedit-point
                         (point)))
           (beg-after (if scim-preediting-p
                          (+ end-before (length scim-preedit-prev-string))
                        end-before))
           (beg-before (if (>= len-before 0)
                           (max (- end-before len-before) (point-min))
                         (line-beginning-position)))
           (end-after (if (>= len-after 0)
                          (min (+ beg-after len-after) (point-max))
                        (line-end-position)))
           (str-before (buffer-substring-no-properties beg-before end-before))
           (str-after (buffer-substring-no-properties beg-after end-after))
           (string (concat str-before str-after))
           (cursor (length str-before))
           (retval (> (length string) 0)))
                                        ;#      (if scim-debug (scim-message "val: %s  str: %s  pos: %d" retval string cursor))
      (scim-surrounding-text-gotten retval cursor string))))

(defun scim-*table--cell-delete-region (beg end)
  (push-mark beg t t)
  (goto-char end)
  (call-interactively '*table--cell-delete-region))

(defun scim-delete-surrounding-text (id offset length)
  (cond
   ((not (string= id scim-imcontext-id))
    (scim-message "IMContext ID (%s) is mismatched." id))
   (buffer-read-only
    (scim-message "Buffer is read-only: %S" (current-buffer)))
   ((not scim-string-insertion-failed)
                                        ;#    (if scim-debug (scim-message "delete surrounding text"))
    (scim-remove-preedit)
    (let* ((pos (point))
           (beg (+ pos (scim-twos-complement offset)))
           (end (+ beg (string-to-number length)))
           (retval t))
      (condition-case err
          (cond
           ((and (boundp 'table-mode-indicator)
                 table-mode-indicator)
            (scim-*table--cell-delete-region beg end))
           (t
            (delete-region beg end)))
        (text-read-only
         (scim-message "Failed to delete surrounding text %s" err)
         (setq retval nil
               scim-string-insertion-failed t)))
      (scim-show-preedit t)
      (scim-surrounding-text-deleted retval)))))

(defun scim-replace-surrounding-text (id corsor-index string)
  (cond
   ((not (string= id scim-imcontext-id))
    (scim-message "IMContext ID (%s) is mismatched." id))
   (buffer-read-only
    (scim-message "Buffer is read-only: %S" (current-buffer)))
   ((not scim-string-insertion-failed)
                                        ;#    (if scim-debug (scim-message "replace surrounding text"))
    (scim-remove-preedit)
    (let* ((pos (point))
           (beg (- pos (scim-twos-complement corsor-index)))
           (end (+ beg (length string)))
           (retval t))
      (condition-case err
          (cond
           ((and (boundp 'table-mode-indicator)
                 table-mode-indicator)
            (scim-*table--cell-delete-region beg end)
            (scim-*table--cell-insert string))
           (t
            (delete-region beg end)
            (goto-char beg)
            (insert string)))
        (text-read-only
         (scim-message "Failed to replace surrounding text %s" err)
         (setq retval nil
               scim-string-insertion-failed t)))
      (goto-char pos)
      (scim-show-preedit t)
      (scim-surrounding-text-replaced retval)))))

(defun scim-focus-changed ()
  t)

(defun scim-beep (id)
  (ding t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Execute commands replied from agent
(defun scim-parse-reply (cmdlist)
  (while cmdlist
    (let* ((args (car cmdlist))
           (cmd (cdr (assoc (car args) scim-reply-alist))))
      (if cmd
          (progn
                                        ;#      (if scim-debug (scim-message "execute: %s" args))
            (apply cmd (cdr args)))
        (scim-message "Unknown command received from agent: %s" (car args))
        ))
    (setq cmdlist (cdr cmdlist)))
  (scim-do-update-preedit))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Process key events
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun scim-wait-following-key-event (prev-event key-code modifiers)
  (let ((event (read-event nil nil scim-simultaneous-pressing-time)))
    (scim-handle-key-event key-code "true" modifiers)
    (when (and event
               (not scim-string-insertion-failed))
      (if (or (eq event prev-event)
              (not (eq (key-binding (vector event)) 'scim-handle-event)))
          (setq unread-command-events (cons event unread-command-events))
        (let ((scim-simultaneous-pressing-time nil))
          (undo-boundary)
          (setq this-command 'scim-handle-event)
          (scim-dispatch-key-event event))))))

(defun scim-dispatch-key-event (event)
  (let* ((elist (scim-decode-event event))
         (key-code (car elist))
         (modifiers (cdr elist)))
    (when (numberp key-code)
      (unless scim-frame-focus (scim-check-frame-focus t))
      (scim-check-current-buffer))
                                        ;#;    (if scim-debug (scim-message "event: %s" elist))
                                        ;#    (if scim-debug (scim-message "event: %s" event))
    (when (member "kana_ro" modifiers)
      (setq event (event-convert-list
                   (append (event-modifiers event) (list key-code))))
                                        ;#      (if scim-debug (scim-message "event: --> %s" event))
      (unless (eq (key-binding (vector event)) 'scim-handle-event)
        (setq key-code nil
              unread-command-events (cons event unread-command-events))))
    (when key-code
      (setq scim-last-command-event event
            scim-surrounding-text-modified nil)
      (if (and (stringp scim-imcontext-id)
               (numberp key-code))
          ;; Send a key event to agent
          (let ((key-code (number-to-string key-code)))
            (setq scim-string-insertion-failed nil)
            (if (and scim-simultaneous-pressing-time
                     scim-imcontext-status)
                ;; Thumb shift typing method
                (scim-wait-following-key-event event key-code modifiers)
              (scim-handle-key-event key-code "true" modifiers))
            (unless scim-string-insertion-failed
              (scim-handle-key-event key-code "false" modifiers)))
        ;; IMContext is not registered or key event is not recognized
        (scim-key-event-handled "false"))))
  ;; Repair post-command-hook
  (unless (memq 'scim-rejected-event-command-pre-function
                (default-value 'pre-command-hook))
    (when (and (local-variable-p 'post-command-hook)
               (not (memq t post-command-hook)))
      (if post-command-hook
          (add-to-list 'post-command-hook t t)
        (kill-local-variable 'post-command-hook)))
    (unless (memq 'scim-check-current-buffer
                  (default-value 'post-command-hook))
                                        ;#      (if scim-debug (scim-message "`post-command-hook' was reset. now add the hook again."))
      (add-hook 'post-command-hook 'scim-check-current-buffer))))

(defun scim-handle-event (&optional arg)
  (interactive "*p")
  (unless (eq last-command 'scim-handle-event)
    (setq scim-last-command last-command))
  (scim-dispatch-key-event last-command-event))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup incremental search
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Internal functions
(defun scim-isearch-start ()
  (if scim-preediting-p
      (scim-abort-preedit))
  (unless (or (eq scim-isearch-cursor-type 0)
              (local-variable-p 'scim-cursor-type-saved))
    (setq scim-cursor-type-saved
          (or (and (local-variable-p 'cursor-type) cursor-type)
              1))))                     ; 1 means that global value has been used

(defun scim-isearch-check-preedit ()
  (unless scim-preediting-p
    (with-current-buffer scim-isearch-minibuffer
      (exit-minibuffer))))

(defun scim-isearch-read-string-post-function ()
                                        ;#  (if scim-debug (scim-message "isearch: exit SCIM input"))
  (remove-hook 'post-command-hook 'scim-isearch-check-preedit)
  (remove-hook 'minibuffer-exit-hook 'scim-isearch-read-string-post-function t)
  (scim-isearch-start)
  (when (and scim-mode-local
             (local-variable-p 'scim-imcontext-id)
             (stringp scim-imcontext-id))
    (let ((status scim-imcontext-status))
      (with-current-buffer scim-isearch-parent-buffer
        (setq scim-imcontext-status status)))
    (kill-local-variable 'scim-imcontext-id)
    (kill-local-variable 'scim-imcontext-status)))

(defun scim-isearch-read-string-pre-function ()
                                        ;#  (if scim-debug (scim-message "isearch: start SCIM input"))
  (remove-hook 'post-command-hook 'scim-isearch-read-string-pre-function)
  (add-hook 'post-command-hook 'scim-isearch-check-preedit t)
  (add-hook 'minibuffer-exit-hook 'scim-isearch-read-string-post-function nil t)
  (when (and scim-mode-local
             (with-current-buffer scim-isearch-parent-buffer
               (stringp scim-imcontext-id)))
    (make-local-variable 'scim-imcontext-id)
    (make-local-variable 'scim-imcontext-status)
    (setq scim-imcontext-id (with-current-buffer scim-isearch-parent-buffer
                              scim-imcontext-id)
          scim-imcontext-status (with-current-buffer scim-isearch-parent-buffer
                                  scim-imcontext-status)))
  (scim-show-preedit)
  (setq scim-isearch-minibuffer (current-buffer)
        scim-current-buffer (current-buffer)))

(defun scim-isearch-process-search-characters (last-char)
  (let ((overriding-terminal-local-map nil)
        (prompt (isearch-message-prefix))
        (minibuffer-local-map (with-no-warnings isearch-minibuffer-local-map))
        (current-input-method nil)
        (scim-imcontext-temporary-for-minibuffer nil)
        (scim-isearch-parent-buffer (current-buffer))
        (scim-isearch-minibuffer nil)
        scim-current-buffer
        str junk-hist)
    (add-hook 'post-command-hook 'scim-isearch-read-string-pre-function)
    (if (eq (car unread-command-events) 'scim-resume-preedit)
        (setq unread-command-events (cdr unread-command-events))
      (setq unread-command-events (cons last-char unread-command-events)))
    (setq str (read-string prompt isearch-string 'junk-hist nil t)
          isearch-string ""
          isearch-message "")
                                        ;#    (if scim-debug (scim-message "isearch-string: %s" str))
    (if (and str (> (length str) 0))
        (let ((unread-command-events nil))
          (isearch-process-search-string str str))
      (isearch-update))
    (if (eq (car unread-command-events) 'scim-resume-preedit)
        (if (string= scim-preedit-string "")
            (setq unread-command-events (cdr unread-command-events))
          (setq unread-command-events (cons ?a unread-command-events))))))

(defun scim-isearch-other-control-char ()
  (if (and scim-use-kana-ro-key
           (eq (event-basic-type last-command-event) scim-kana-ro-key-symbol))
      (setq unread-command-events
            (if scim-imcontext-status
                (append (list ?a 'scim-resume-preedit last-command-event)
                        unread-command-events)
              (cons (event-convert-list
                     (append (event-modifiers last-command-event) (list ?\\)))
                    unread-command-events)))
    (funcall (lookup-key scim-mode-map (this-command-keys)))
    (if isearch-mode
        (isearch-update))))

;; Advices for `isearch.el'
(defadvice isearch-printing-char
  (around scim-isearch-printing-char ())
  (if scim-imcontext-status
      (let ((current-input-method "SCIM"))
        ad-do-it)
    ad-do-it))

(defadvice isearch-other-control-char
  (around scim-isearch-other-control-char ())
  (if (and scim-mode
           (lookup-key scim-mode-map (this-command-keys)))
      (scim-isearch-other-control-char)
    ad-do-it))

(defadvice isearch-message-prefix
  (around scim-isearch-message-prefix ())
  (if (and scim-imcontext-status
           (not nonincremental)
           (not (eq this-command 'isearch-edit-string)))
      (let ((current-input-method "SCIM")
            (current-input-method-title "SCIM"))
        ad-do-it)
    ad-do-it))

;; Advices for `isearch-x.el'
(defadvice isearch-toggle-specified-input-method
  (around scim-isearch-toggle-specified-input-method ())
  (if scim-imcontext-status
      (isearch-update)
    ad-do-it))

(defadvice isearch-toggle-input-method
  (around scim-isearch-toggle-input-method ())
  (if scim-imcontext-status
      (isearch-update)
    ad-do-it))

(defadvice isearch-process-search-multibyte-characters
  (around scim-isearch-process-search-characters ())
  (if (and (string= current-input-method "SCIM")
           (eq this-command 'isearch-printing-char))
      (scim-isearch-process-search-characters last-char)
    ad-do-it))

;; Commands and functions
(defun scim-enable-isearch ()
  "Make SCIM usable with isearch-mode."
  (interactive)
  (add-hook 'isearch-mode-hook 'scim-isearch-start)
  (ad-enable-regexp "^scim-isearch-")
  (ad-activate-regexp "^scim-isearch-"))

(defun scim-disable-isearch ()
  "Make SCIM not usable with isearch-mode."
  (interactive)
  (remove-hook 'isearch-mode-hook 'scim-isearch-start)
  (ad-disable-regexp "^scim-isearch-")
  (ad-activate-regexp "^scim-isearch-"))

(defun scim-setup-isearch ()
  (if scim-use-in-isearch-window
      (scim-enable-isearch)
    (scim-disable-isearch)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Switch minor mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun scim-cleanup-variables ()
  (let ((buffers (buffer-list)))
    (save-current-buffer
      (while buffers
        (set-buffer (car buffers))
        (kill-local-variable 'scim-imcontext-id)
        (kill-local-variable 'scim-imcontext-status)
        (kill-local-variable 'scim-mode-map-prev-disabled)
        (setq buffers (cdr buffers)))))
  (setq-default scim-imcontext-id nil)
  (setq-default scim-imcontext-status nil)
  (setq-default scim-mode-map-prev-disabled nil)
  (setq scim-current-buffer nil
        scim-preediting-p nil
        scim-last-rejected-event nil
        scim-last-command nil
        scim-preedit-default-attr nil
        scim-config-last-modtime nil
        scim-net-active-window-unsupported nil))

(defun scim-mode-on ()
  (interactive)
  (if (not window-system)
      (scim-mode-quit)
    (if scim-bridge-socket (scim-mode-off)) ; Restart scim-mode
    (unwind-protect
        (scim-bridge-connect)
      (if (not (and scim-bridge-socket
                    (memq (process-status scim-bridge-socket)
                          '(open run))))
          ;; Connection failed
          (scim-mode-quit)
        ;; Turn on minor mode
        (setq-default scim-mode t)
        (scim-cleanup-variables)
        (setq scim-selected-frame (selected-frame))
        (scim-activate-advices-undo t)
        (scim-setup-isearch)
        ;; Initialize key bindings
        (setq scim-keyboard-layout (scim-get-keyboard-layout))
        (scim-update-key-bindings)
        (scim-set-mode-map-alist)
        (add-to-ordered-list
         'emulation-mode-map-alists 'scim-mode-map-alist 50)
                                        ;   (global-set-key [scim-receive-event] 'scim-bridge-receive)
                                        ;   (global-set-key [scim-dummy-event] 'scim-null-command)
        ;; Setup hooks
        (add-hook 'minibuffer-exit-hook 'scim-exit-minibuffer-function)
        (mapc (lambda (hook)
                (add-hook hook 'scim-disable-keymap))
              scim-incompatible-mode-hooks)
        (add-hook 'post-command-hook 'scim-check-current-buffer)
                                        ;#  (if scim-debug (scim-message "post-command-hook: %s" post-command-hook))
        (add-hook 'after-make-frame-functions 'scim-after-make-frame-function)
        (add-hook 'kill-buffer-hook 'scim-kill-buffer-function)
        (add-hook 'kill-emacs-hook 'scim-mode-off)))
    (scim-update-mode-line)))

(defun scim-mode-quit ()
  (remove-hook 'kill-emacs-hook 'scim-mode-off)
  (remove-hook 'kill-buffer-hook 'scim-kill-buffer-function)
  (remove-hook 'after-make-frame-functions 'scim-after-make-frame-function)
  (remove-hook 'post-command-hook 'scim-check-current-buffer)
  (mapc (lambda (hook)
          (remove-hook hook 'scim-disable-keymap))
        scim-incompatible-mode-hooks)
  (remove-hook 'minibuffer-exit-hook 'scim-exit-minibuffer-function)
  (setq emulation-mode-map-alists
        (delq 'scim-mode-map-alist emulation-mode-map-alists))
                                        ;  (global-unset-key [scim-receive-event])
                                        ;  (global-unset-key [scim-dummy-event])
  (scim-update-kana-ro-key t)
  (scim-activate-advices-undo nil)
  (scim-disable-isearch)
  (scim-cancel-focus-update-timer)
  (scim-cleanup-preedit)
  (scim-bridge-disconnect)
  (setq-default scim-mode nil)
  (scim-cleanup-variables)
  (scim-update-cursor-color)
  (scim-update-mode-line))

(defun scim-mode-off ()
  (interactive)
  (when (and (stringp scim-imcontext-id)
             scim-frame-focus)
    (scim-change-focus nil)
    (setq scim-frame-focus nil))
  ;; Deregister IMContext IDs
  (let ((buffers (buffer-list)))
    (save-current-buffer
      (while buffers
        (let ((scim-current-buffer (car buffers)))
          (set-buffer scim-current-buffer)
          (when (local-variable-p 'scim-imcontext-id)
            (scim-deregister-imcontext)))
        (setq buffers (cdr buffers)))))
  (scim-deregister-imcontext)
  ;; Turn off minor mode
  (scim-mode-quit))

(defun scim-update-mode ()
  (if scim-mode
      (scim-mode-on)
    (scim-mode-off)))

(defun scim-mode (&optional arg)
  "Toggle SCIM minor mode (scim-mode).
With optional argument ARG, turn scim-mode on if ARG is
positive, otherwise turn it off."
  (interactive "P")
  (if (not (or window-system scim-mode))
      (prog1 nil
        (scim-message "scim-mode needs Emacs to run as X application."))
    (setq-default scim-mode
                  (if (null arg)
                      (not scim-mode)
                    (> (prefix-numeric-value arg) 0)))
    (scim-update-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Setup minor-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; minor-mode-alist
(unless (assq 'scim-mode minor-mode-alist)
  (setq minor-mode-alist
        (cons '(scim-mode scim-mode-line-string) minor-mode-alist)))

;; minor-mode-map-alist
;;  scim-mode doesn't use `minor-mode-map-alist' but
;;  `emulation-mode-map-alists', and it is not set yet because
;;  `scim-mode-map' will be generated dynamically.

;; mode-line-mode-menu
(define-key mode-line-mode-menu [scim-mode]
  `(menu-item ,(purecopy "Smart Common Input Method (SCIM)") scim-mode
              :help "Support the input of various languages"
              :button (:toggle . (bound-and-true-p scim-mode))))

(provide 'scim-bridge)

;;;
;;; scim-bridge.el ends here
