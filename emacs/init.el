;;; init.el --- settings for packages

;;; Commentary:
;;; Code:


(add-to-list 'load-path
	     (expand-file-name (concat user-emacs-directory "lisp"))) ;; ~/.emacs.d/

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-startup)
(require 'init-elpa)
(require 'init-ui)
(require 'init-kbd)
(require 'init-package)
(require 'init-time-show-up)
(require 'init-org)
(require 'init-lsp)
(require 'language-mode)
(require 'init-const)
(require 'init-fontface)
(require 'projects-sql)


;;(add-to-list 'load-path "~/.emacs.d/manual-installed/lsp-bridge")
;;(require 'lsp-bridge)
;;(global-lsp-bridge-mode)
;;;
