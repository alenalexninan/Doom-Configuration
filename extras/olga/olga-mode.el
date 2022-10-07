;;; ~/.doom.d/extra/olga/olga-mode.el -*- lexical-binding: t; -*-
;; Copyright (C) 2011-2018  Free Software Foundation, Inc.

;; Author: Alen Alex Ninan <alenishere@gmail.com>
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
;; Import
;; ---------------------------------------------------------------------------
(eval-when-compile
  (require 'cl-lib))

(require 'comint)
(require 'newcomment)
(require 'rx)
(eval-when-compile
  ;; Silence compilation warning about `compilation-error-regexp-alist' defined
  ;; in compile.el.
  (require 'compile))



;; user definable variables
;;----------------------------------------------------------------------------

(defgroup olga nil
  "Support for the OLGA text inputs"
  :group 'languages
  :prefix "ol-")

(defcustom ol-command "python"
  "*Shell command used to start Python interpreter."
  :type 'string
  :group 'olga)

(defcustom ol-command-args '("-i")
  "*List of string arguments to be used when starting a Python shell."
  :type '(repeat string)
  :group 'olga)

(defcustom ol-version "7.3.5"
  "*List of string arguments to be used when starting a Python shell."
  :type 'string
  :group 'olga)

(defcustom ol-executable "7.3.5"
  "*List of string arguments to be used when starting a Python shell."
  :type 'string
  :group 'olga)

;; No more user defined variables
;; ---------------------------------------------------------------------------
;; ;; define several category of keywords
;;              (x-keywords '("CASE" "OPTIONS" "FILES" "DTCONTROL" "INTEGRATION" "TREND" "PROFILE" "RESTART" "WATEROPTIONS" "PROFILEDATA" "TRENDDATA" "OUTPUTDATA" "MATERIAL" "WALL" "CONNECTION" "SHUTIN" "HYDRATECURVE" "SOURCE" "WELL" "VALVE" "TRANSMITTER" "POSITION" "GEOMETRY" "PIPE" "HEATTRANSFER" "PARAMETERS" "BRANCH" "TUNING"))
;;              ;; (x-types '("float" "integer" "key" "list" "rotation" "string" "vector"))
;;              (x-constants '("ACTIVE" "AGENT" "ALL_SIDES" "ATTACH_BACK"))
;;              (x-events '("at_rot_target" "at_target" "attach"))
;;              (x-functions '("NETWORKCOMPONENT" "ENDNETWORKCOMPONENT"))

;;              ;; generate regex string for each category of keywords
;;              (x-functions-regexp (regexp-opt x-functions 'words))
;;              (x-keywords-regexp (regexp-opt x-keywords 'words))
;;              ;; (x-types-regexp (regexp-opt x-types 'words))
;;              (x-constants-regexp (regexp-opt x-constants 'words))
;;              (x-events-regexp (regexp-opt x-events 'words))


;;         `
;;           (,x-functions-regexp . font-lock-function-name-face)
;;           ;; (,x-types-regexp . font-lock-type-face)
;;           (,x-constants-regexp . font-lock-constant-face)
;;           (,x-events-regexp . font-lock-builtin-face)
;;           (,x-keywords-regexp . font-lock-keyword-face)
;;           ;; note: order above matters, because once colored, that part won't change.
;;           ;; in general, put longer words first
;;; Keywords
(setq ol-font-lock-keywords
      (let* (
             ;; define several category of keywords
             (x-keywords '("CASE" "OPTIONS" "FILES" "DTCONTROL" "INTEGRATION" "TREND" "PROFILE" "RESTART"
                           "WATEROPTIONS" "PROFILEDATA" "TRENDDATA" "OUTPUTDATA" "MATERIAL" "WALL" "CONNECTION"
                           "SHUTIN" "HYDRATECURVE" "SOURCE" "WELL" "VALVE" "TRANSMITTER" "POSITION" "GEOMETRY"
                           "PIPE" "HEATTRANSFER" "PARAMETERS" "BRANCH" "TUNING"))
             (x-types '("float" "integer" "key" "list" "rotation" "string" "vector"))
             (x-constants '("ACTIVE" "AGENT" "ALL_SIDES" "ATTACH_BACK"))
             (x-events '("at_rot_target" "at_target" "attach"))
             (x-functions '("llAbs" "llAcos" "llAddToLandBanList" "llAddToLandPassList"))

             ;; Regex definition
             ;; ----------------
             (x-keywords-regexp (regexp-opt x-keywords 'words))
             (x-types-regexp (regexp-opt x-types 'words))
             (x-constants-regexp (regexp-opt x-constants 'words))
             (x-events-regexp (regexp-opt x-events 'words))
             (x-functions-regexp (regexp-opt x-functions 'words)))

        `(
          (,x-types-regexp . font-lock-type-face)
          (,x-constants-regexp . font-lock-constant-face)
          (,x-events-regexp . font-lock-builtin-face)
          (,x-functions-regexp . font-lock-function-name-face)
          (,x-keywords-regexp . font-lock-keyword-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))

;;; Syntax completion
;; ----------------------------------------------------------------------------

;;;  Syntax checker
;; ----------------------------------------------------------------------------

;;; Org mode functions
;; ----------------------------------------------------------------------------

;;; Code folding
;; ----------------------------------------------------------------------------

;;; Syntax table
;; ----------------------------------------------------------------------------
(defvar ol-mode-syntax-table nil "Syntax table for `olga-mode'.")
(setq ol-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; python style comment: “! …”
        (modify-syntax-entry ?\! "<" synTable)
        (modify-syntax-entry ?\n ">" synTable)
        synTable))



;;; Derived mode definition
;; -----------------------------------------------------------------------------
(define-derived-mode olga-mode prog-mode "OLGA mode"
  "major mode for editing OLGA language code."
  (setq font-lock-defaults '(ol-font-lock-keywords))
  (set-syntax-table ol-mode-syntax-table)
  ;; Comment dwim
  (setq-local comment-start "\! ")
  (setq-local comment-end "")
  )

(provide 'olga-mode)
;;; olga-mode.el ends here
