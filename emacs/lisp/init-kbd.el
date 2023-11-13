
(setq x-select-enable-clipboard t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; (define-key  (kbd "C-q M-q") 'restart-emacs)

(define-key emacs-lisp-mode-map (kbd "C-x M-t") 'counsel-load-theme)

(provide 'init-kbd)
