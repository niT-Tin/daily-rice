;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; (message "in config.el")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "liuzehao"
      user-mail-address "1437070389@qq.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-moonlight)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 15 :weight 'medium))
(setq doom-font (font-spec :family "Cascadia Code PL" :size 16 :weight 'medium))
;;;;(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; (setq rustic-lsp-server 'rust-analyzer)
;; (add-hook 'rust-mode-hook #'racer-mode)
;; (add-hook 'racer-mode-hook #'eldoc-mode)
;;
;;(after! rustic
;;  (setq rustic-lsp-server 'rust-analyzer))

(beacon-mode 1)
(global-evil-surround-mode 1)

(setq minimap-window-location 'right)
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle minimap-mode" "m" #'minimap-mode))

;; centaur-tabs-mode
;; (centaur-tabs-mode t)
(setq doom-themes-treemacs-theme "treemacs-all-the-icons")
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'dired-mode-hook 'treemacs-icons-dired-mode)
(add-hook 'dired-mode-hook 'dired-hide-dotfiles-mode)

(setq gofmt-command "goimports")
;; (add-hook 'before-save-hook 'gofmt)

;; 添加Dired模式下按H隐藏和显示隐藏文件
(evil-define-key 'normal 'dired-mode-map "H" 'dired-hide-dotfiles-mode)

;; 修改lsp-bridge下选择补齐的快捷键
;; (evil-define-key 'insert 'prog-mode-map "\C-n" 'acm-select-next)
;; (evil-define-key 'insert 'prog-mode-map "\C-p" 'acm-select-prev)

(general-evil-setup t)
(general-create-definer rune/leader-keys
 			  :keymaps '(normal insert visual emacs)
 			  :prefix "SPC"
			  :global-prefix "M-SPC")

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))
;; C-u 20 C-x ^
(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

;; 设置lsp-mode，加快lsp速度
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 4096))
;; (setq lsp-log-io nil)
(global-wakatime-mode)

(add-hook 'text-mode-hook 'visual-line-mode)

(dap-mode 1)

;; The modes below are optional

(dap-ui-mode 1)
;; enables mouse hover support
(dap-tooltip-mode 1)
;; use tooltips for mouse hover
;; if it is not enabled `dap-mode' will use the minibuffer.
(tooltip-mode 1)
;; displays floating panel with debug buttons
;; requies emacs 26+
(dap-ui-controls-mode 1)
;; Enabling only some features
(setq dap-auto-configure-features '(sessions locals controls tooltip))

(setq lsp-dart-sdk-dir "/home/liuzehao/applications/dart-sdk")
(setq flutter-sdk-path "/home/liuzehao/applications/flutter")

(require 'dap-cpptools)
;; (setq dap-gdb-lldb-path "/home/liuzehao/.vscode/extensions/webfreak.debug-0.26.0")


(dap-register-debug-template "Rust::GDB Run Configuration"
                             (list :type "gdb"
                                   :request "launch"
                                   :name "GDB::Run"
                           :gdbpath "rust-gdb"
                                   :target nil
                                   :cwd nil))
(require 'dap-gdb-lldb)
(require 'dap-lldb)
(setq ob-mermaid-cli-path "/usr/bin/mmdc")
(org-babel-do-load-languages
    'org-babel-load-languages
    '((mermaid . t)
      (scheme . t)
      (emacs-lisp . t)
      ))

(use-package org-bullets
  :after org
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

 (font-lock-add-keywords 'org-mode
                         '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; 执行org代码块之后展示图片结果(针对mmdc)
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

;; 添加hook,启动java-mode之后自动启动gradle-mode
(add-hook 'java-mode-hook (lambda()(gradle-mode 1)))
;; 命令行获取环境变量
;; (exec-path-from-shell-initialize)

;; (setq lsp-completion-enable t)
;; (add-hook 'lsp-mode-hook #'lsp)
(after! lsp-mode (
setq lsp-lens-enable t
lsp-ui-peek-enable t
lsp-ui-doc-enable nil
lsp-ui-doc-position 'top
lsp-ui-doc-max-height 70
lsp-ui-doc-max-width 150
lsp-ui-sideline-show-diagnostics t
lsp-ui-sideline-show-hover nil
lsp-ui-sideline-show-code-actions t
lsp-ui-sideline-diagnostic-max-lines 20
lsp-ui-sideline-ignore-duplicate t
lsp-ui-sideline-enable t))

(evilem-default-keybindings "SPC")

;; (after! evil-escape
;;   (setq evil-escape-key-sequence "jk")
;;   参考这个作者的回答
;;   https://discourse.doomemacs.org/t/typing-jk-deletes-j-and-returns-to-normal-mode/59/7

;;(add-hook 'lsp-mode-hook (lambda()(tree-sitter-mode 1)))
;;(add-hook 'tree-sitter-mode-hook (lambda()(tree-sitter-hl-mode 1)))
;;
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(semantic-mode 1)
(require 'stickyfunc-enhance)

;; (show-paren-mode 1)
;; (setq show-paren-style 'parenthesis
;;       show-paren-context-when-offscreen 'overlay
;;       blink-matching-paren t
;;       )
      ;; show-paren-context-when-offscreen 'overlay)
;; (require 'quelpa-use-package)
;; (use-package topsy
;;   :quelpa (topsy :fetcher github :repo "alphapapa/topsy.el")
;;   :hook (prog-mode . topsy-mode)
(add-to-list 'load-path (concat user-emacs-directory "lisp/"))

;;(require 'posframe)
;;(add-to-list 'load-path "/home/liuzehao/.emacs.d/lisp/lsp-bridge")
;;(require 'yasnippet)
;;(yas-global-mode 1)
;;(require 'lsp-bridge)
;;(global-lsp-bridge-mode)

;; (require 'topsy)
;; (add-hook 'prog-mode-hook #'topsy-mode)


;; agenda setting
(setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(t)" "|" "DONE(d!)" "DOING(i)")
	  (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)"))
        org-todo-keyword-faces
        '(("DONE" . "PaleGreen")
          ("DOING" . (:foreground "#E06C75" :weight bold))
          ("TODO" . "#ffd551")
          ("READY" . "#7553bd")
          ("WAIT" . "Green")
          )
        org-fontify-done-headline t
)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-agenda-files 
      '(
        "~/Notes/ShouldFinished/sf.org"
        )
      )
(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

;;(after! lsp-mode()
;;     ;; enable log only for debug
;;     lsp-log-io nil
;;
;;     ;; use `evil-matchit' instead
;;     ;; setq lsp-enable-folding nil
;;
;;     ;; handle yasnippet by myself
;;
;;     ;; lsp-enable-snippet nil
;;
;;     ;; use `company-ctags' only.
;;     ;; Please note `company-lsp' is automatically enabled if installed
;;
;;     ;; lsp-completion-enable nil
;;
;;     ;; turn off for better performance
;;
;;     ;; lsp-enable-symbol-highlighting nil
;;
;;     ;; use ffip instead
;;
;;     ;; lsp-enable-links nil
;;
;;     ;; don't scan some files
;;     ;; push "[/\\\\][^/\\\\]*\\.json$" lsp-file-watch-ignored ; json
;;
;;     ;; don't ping LSP lanaguage server too frequently
;;     (defvar lsp-on-touch-time 0)
;;     (defadvice lsp-on-change (around lsp-on-change-hack activate)
;;       ;; don't run `lsp-on-change' too frequently
;;       (when (> (- (float-time (current-time))
;;                   lsp-on-touch-time) 30) ;; 30 seconds
;;         (setq lsp-on-touch-time (float-time (current-time)))
;;         ad-do-it)))

(after! company-mode()
  (company-ctags-auto-setup)
  )

(eval-after-load "org"
  '(require 'ox-gfm nil t))

;; (require 'gif-screencast)

;;(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
;;(require 'eaf)
;;(require 'eaf-airshare)
;;(require 'eaf-browser)
;;(require 'eaf-camera)
;;(require 'eaf-demo)
;;(require 'eaf-file-browser)
;;(require 'eaf-file-manager)
;;(require 'eaf-file-sender)
;;(require 'eaf-image-viewer)
;;(require 'eaf-jupyter)
;;(require 'eaf-markdown-previewer)
;;(require 'eaf-mindmap)
;;(require 'eaf-music-player)
;;(require 'eaf-org-previewer)
;;(require 'eaf-pdf-viewer)
;;(require 'eaf-system-monitor)
;;(require 'eaf-terminal)
;;(require 'eaf-video-player)
;;(require 'eaf-vue-demo)
;;(require 'eaf-netease-cloud-music)
;;(require 'eaf-rss-reader)
;;(require 'eaf-git)
;;(require 'eaf-2048)
