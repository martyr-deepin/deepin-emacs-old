;;; scim-bridge-XX.el

;; Copyright (C) 2008, 2009 S. Irie
;; Copyright (C) YEAR TRANSLATOR

;; Author: S. Irie
;; Maintainer: TRANSLATOR
;; Keywords: Input Method, i18n

(defconst scim-bridge-XX-version "0.7.4")

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

;;   (INTRODUCTION)

;;
;; Installation:
;;
;;   (HOW TO INSTALL)
;;

;; History:
;; YEAR-MM-DD  TRANSLATOR
;;         * First release
;;         * Version 0.7.4
;;
;; 2009-01-27  S. Irie
;;         * Modify description of installation
;;         * Version 0.7.4
;;
;; 2008-12-19  S. Irie
;;         * Add/modify/delete translations
;;         * Version 0.7.3
;;
;; 2008-11-28  S. Irie
;;         * Add/delete entries
;;         * Version 0.7.2
;;
;; 2008-10-14  S. Irie
;;         * Add entries
;;         * Version 0.7.1
;;
;; 2008-10-04  S. Irie
;;         * Template file newly created
;;         * Version 0.7.0

;; ToDo:

;;; Code:

(require 'scim-bridge)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Apply translations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(scim-set-group-doc
 'scim
 "")

(scim-set-variable-doc
 'scim-mode
 "")

;; Basic settings
(scim-set-group-doc
 'scim-basic
 "")

(scim-set-variable-doc
 'scim-mode-local
 "")

(scim-set-variable-doc
 'scim-imcontext-temporary-for-minibuffer
 "")

(scim-set-variable-doc
 'scim-use-in-isearch-window
 "")

(scim-set-variable-doc
 'scim-use-minimum-keymap
 "")

(scim-set-variable-doc
 'scim-common-function-key-list
 "")

(scim-set-variable-doc
 'scim-preedit-function-key-list
 "")

(scim-set-variable-doc
 'scim-use-kana-ro-key
 "")

(scim-set-variable-doc
 'scim-simultaneous-pressing-time
 ""
 '()) ; custom-type

(scim-set-variable-doc
 'scim-undo-by-committed-string
 "")

(scim-set-variable-doc
 'scim-clear-preedit-when-unexpected-event
 "")

;; Appearance
(scim-set-group-doc
 'scim-appearance
 "")

(scim-set-face-doc
 'scim-preedit-default-face
 "")

(scim-set-face-doc
 'scim-preedit-underline-face
 "")

(scim-set-face-doc
 'scim-preedit-highlight-face
 "")

(scim-set-face-doc
 'scim-preedit-reverse-face
 "")

(scim-set-variable-doc
 'scim-cursor-color
 ""
 ;; ** Don't translate `:value' properties!! **
 '()) ; custom-type

(scim-set-variable-doc
 'scim-isearch-cursor-type
 ""
 '()) ; custom-type

(scim-set-variable-doc
 'scim-cursor-type-for-candidate
 ""
 '()) ; custom-type

(scim-set-variable-doc
 'scim-put-cursor-on-candidate
 "")

(scim-set-variable-doc
 'scim-adjust-window-x-position
 ""
 '()) ; custom-type

(scim-set-variable-doc
 'scim-adjust-window-y-position
 "")

(scim-set-variable-doc
 'scim-prediction-window-position
 ""
 '()) ; custom-type

(scim-set-variable-doc
 'scim-mode-line-string
 "")

;; Advanced settings
(scim-set-group-doc
 'scim-expert
 "")

(scim-set-variable-doc
 'scim-focus-update-interval
 "")

(scim-set-variable-doc
 'scim-focus-update-interval-long
 "")

(scim-set-variable-doc
 'scim-kana-ro-x-keysym
 "")

(scim-set-variable-doc
 'scim-kana-ro-key-symbol
 ""
 '()) ; custom-type

(scim-set-variable-doc
 'scim-bridge-timeout
 "")

(scim-set-variable-doc
 'scim-config-file
 "")

(scim-set-variable-doc
 'scim-meta-key-exists
 "")

(scim-set-variable-doc
 'scim-tmp-buffer-name
 "")

(scim-set-variable-doc
 'scim-incompatible-mode-hooks
 "")

(scim-set-variable-doc
 'scim-undo-command-list
 "")

;; Functions
(scim-set-function-doc
 'scim-set-group-doc
 "")

(scim-set-function-doc
 'scim-set-variable-doc
 "")

(scim-set-function-doc
 'scim-set-face-doc
 "")

(scim-set-function-doc
 'scim-set-function-doc
 "")

(scim-set-function-doc
 'scim-define-common-key
 "")

(scim-set-function-doc
 'scim-define-preedit-key
 "")

(scim-set-function-doc
 'scim-reset-imcontext-statuses
 "")

(scim-set-function-doc
 'scim-get-frame-extents
 "")

(scim-set-function-doc
 'scim-frame-header-height
 "")

(scim-set-function-doc
 'scim-real-frame-header-height
 "")

(scim-set-function-doc
 'scim-compute-pixel-position
 "")

(scim-set-function-doc
 'scim-get-gnome-font-size
 "")

(scim-set-function-doc
 'scim-get-active-window-id
 "")

(scim-set-function-doc
 'scim-enable-isearch
 "")

(scim-set-function-doc
 'scim-disable-isearch
 "")

(scim-set-function-doc
 'scim-mode
 "")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define functions useful only for TARGET_LANGUAGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings

;; Functions

;;  (THIS SECTION IS OPTIONAL)

(provide 'scim-bridge-XX)

;;;
;;; scim-bridge-XX.el ends here
