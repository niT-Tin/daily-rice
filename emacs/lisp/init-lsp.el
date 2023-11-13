;;; init-lsp.el --- settings for lsp

;;; Commentary:
;;; Code:


(defun efs/lsp-mode-setup()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands lsp
  :init
  (defun lsp-save-actions ()
    "LSP actions before save."
    (add-hook 'before-save-hook #'lsp-organize-imports t t)
	(add-hook 'before-save-hook #'lsp-format-buffer t t))
  :hook ((lsp-mode . #'lsp-enable-which-key-integration)
         (lsp-mode . #'lsp-save-actions)
	 (lsp-mode . efs/lsp-mode-setup)
         ((c-mode
           c++-mode
           go-mode
           java-mode
	   ts-mode
           js-mode
	   sql-mode
           python-mode
           rust-mode
           web-mode) . lsp))
  :config
  (setq lsp-auto-guess-root t
	    lsp-headerline-breadcrumb-enable t
	    lsp-keymap-prefix "C-c l"
	    lsp-log-io nil)
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  :custom (lsp-headerline-breadcrumb-enable nil)
  )


(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-use-webkit nil)
  (setq lsp-ui-doc-delay 0)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-position 'at-point)
  (setq lsp-eldoc-enable-hover nil) ;; Disable eldoc displays in minibuffer
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-sideline-show-diagnostics nil)
  (setq lsp-ui-sideline-ignore-duplicate t)
  (setq lsp-ui-flycheck-enable t)
  (setq lsp-lens-enable t)
  (lsp-ui-doc-show))

;;(add-hook 'prog-mode-hook 'lsp)

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)


;;(add-hook 'java-mode-hook #'lsp)

(provide 'init-lsp)
;;;
