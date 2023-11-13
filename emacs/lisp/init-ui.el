;; 主题

;;(use-package gruvbox-theme
;;  :init (load-theme 'gruvbox-dark-soft t))

;;(load-theme 'doom-tokyo-night t)

;; (use-package smart-mode-line
;;  :init
;;  (setq sml/no-confirm-load-theme t
;;	sml/theme 'respectful)
;;  (sml/setup))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package doom-modeline
  :ensure t
  :custom ((doom-modeline-height 15))
  :hook (after-init . doom-modeline-mode))

(use-package all-the-icons)


(use-package doom-themes
  :config
  (load-theme 'doom-Iosvkem t))
;; (setq doom-theme 'doom-acario-dark)

(setq display-line-numbers-type 'relative)
;; (global-display-line-numbers-mode t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(provide 'init-ui)
