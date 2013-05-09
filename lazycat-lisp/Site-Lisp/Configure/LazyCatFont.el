;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 字体设置 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defvar emacs-font-name "DejaVu Sans YuanTi Mono"
(defvar emacs-font-name "文泉驿等宽微米黑"
  "The font name of English.")
(defvar emacs-font-size 12
  "The default font size.")
(if (display-grayscale-p)
    (progn
      (set-frame-font (format "%s-%s" (eval emacs-font-name) (eval emacs-font-size)))
      (set-fontset-font (frame-parameter nil 'font) 'unicode (eval emacs-font-name))))

(provide 'LazyCatFont)
