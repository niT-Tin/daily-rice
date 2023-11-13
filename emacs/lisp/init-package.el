;;; init-package.el --- settings for packages

;;; Commentary:
;;; Code:

;; 重启emacs
(use-package restart-emacs)

;; 启动时间统计
(use-package benchmark-init
  :init (benchmark-init/activate)
  :hook (after-init . benchmark-init/deactivate))


;; 添加快捷命令
;; (use-package crux
;;  :bind ("C-c k" . crux-smart-kill-line))


(use-package hungry-delete
  :bind (("C-c DEL" . hungry-delete-backward))
  :bind (("C-c d" . hungry-delete-forward)))

(use-package drag-stuff
  :bind (("M-p" . drag-stuff-up)
	 ("M-n" . drag-stuff-down)))
;; 强化搜索三剑客
(use-package ivy
  :defer 1
  :demand
  :hook (after-init . ivy-mode)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
	ivy-initial-inputs-alist nil
	ivy-count-format "%d/%d "
	enable-recursice-minibuffers t
	ivy-re-builders-alist '((t . ivy--regex-ignore-order))))


(use-package counsel
  :after (ivy)
  :bind (("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("C-c f" . counsel-recentf)
	 ("C-c g" . counsel-git)))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
	 ("C-r" . swiper-isearch-backward))
  :config (setq swiper-action-recenter t
		swiper-include-line-number-in-search t))
;; 补全包
(use-package company
  :after lsp-mode
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selections))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  ;; :config
  ;; (setq company-dabbrev-code-everywhere t
  ;; 	company-dabbrev-code-modes t
  ;; 	company-dabbrev-code-other-buffers 'all
  ;; 	company-dabbrev-downcase t
  ;; 	company-dabbrev-ignore-case t
  ;; 	company-dabbrev-other-buffers 'all
  ;; 	company-require-match nil
  ;; 	company-minimum-prefix-length 2
  ;; 	company-show-numbers t
  ;; 	company-tooltip-limit 20
  ;; 	company-idle-delay 0
  ;; 	company-echo-delay 0
  ;; 	company-tooltip-offset-display 'scrollbar
  ;; 	company-begin-commands '(self-insert-command))
  ;; (push '(company-semantic :with company-yasnippet) company-backends)
  :hook (prog-mode . company-mode))

(yas-global-mode 1)



;; 语法检查
 (use-package flycheck
  ;; 开启全局检查模式
  ;;  :hook (after-init . global-flycheck-mode))
  ;; 在编程语言下开启
   :hook (prog-mode . flycheck-mode))

;; 添加快捷命令
(use-package crux
  :bind (("C-a" . crux-move-beginning-of-line)
	 ("C-c ^" . crux-top-join-line)
	 ("C-x ," . crux-find-user-init-file)
	 ("C-S-d" . crux-duplicate-current-line-or-region)
	 ("C-S-k" . crux-smart-kill-line)))

;; 快捷键查询
(use-package which-key
  :defer nil
  :config (which-key-mode))

;; MiniBuffer
;;(use-package ivy-posframe
;;  :init
;;  (setq ivy-posframe-display-functions-alist
;;	'((swiper . ivy-posframe-display-at-frame-center)
;;	  (complete-symbol . ivy-posframe-display-at-point)
;;	  (counsel-M-x . ivy-posframe-display-at-frame-center)
;;	  (counsel-find-file . ivy-posframe-display-at-frame-center)
;;	  (ivy-switch-buffer . ivy-posframe-display-at-frame-center)
;;	  (t . ivy-posframe-display-at-frame-center)))
;;  (ivy-posframe-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; 窗口其切换
(use-package ace-window
  :bind (("M-o" . ace-window)))


(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(use-package general
 :config
 (general-evil-setup t)
 (general-create-definer rune/leader-keys
 			  :keymaps '(normal insert visual emacs)
 			  :prefix "SPC"
			  :global-prefix "M-SPC")
 (rune/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")))

(defun rune/evil-hook ()
  (dolist (m '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circe-server-mode
		  circe-chat-mode
		  circe-query-mode
		  sauron-mode
		  term-mode))
    (add-to-list 'evil-emacs-state-modes m)))
(use-package evil
   :init
   (setq evil-want-integration t)
   (setq evil-want-keybinding nil)
   (setq evil-want-C-u-scroll t)
   (setq evil-want-C-i-jump nil)
   :hook (evil-mode . rune/evil-hook)
   :config
   (evil-mode 1)
   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
;;   (define-key evil-insert-state-map (kbd "jk") 'evil-normal-state)
   (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
   (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
   (evil-set-initial-state 'messages-buffer-mode 'normal)
   (evil-set-initial-state 'dashboard-mode 'normal))
;; 已经写进源码evil-vars.el并重新编译
;; (setq evil-toggle-key "C-`")

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  )

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))


(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

;; 加载主机shell环境变量，需要时打开，不需要时注释掉，因为太慢了
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/projects")
    (setq projectile-project-search-path '("~/projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package magit
  :custom

  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package evil-surround)
;; (global-evil-surround-mode 1)

(use-package paren
  :config
  (set-face-attribute 'show-paren-match-expression nil :background "#363e4a")
  (show-paren-mode 1))

(use-package vterm
  :after evil-collection
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000)
  (advice-add 'evil-collection-vterm-insert :before #'vterm-reset-cursor-point))

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(provide 'init-package)
;;;

