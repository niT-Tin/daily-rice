
;;; Code:

(setq package-archives '(
 			 ("melpa" . "http://melpa.org/packages/")
 			 ("org". "http://orgmode.org/elpa/")
                          ("elpa" . "http://elpa.gnu.org/packages/")
                          ))

;; (setq package-check-signature nil) ; 如果使用国内源，有些签名验证失败，添加这个取消签名验证
(setq select-enable-clipboard t)

;; (set-face-attribute 'default nil :font "Bitstream Vera Sans Mono Roman" :height 280)

(setq visible-bell t)

(require 'package)

;; 初始化包管理工具
(unless (bound-and-true-p package--initialized)
  (package-initialize))
;; 刷新软件索引

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t) ; 不用每次都手动添加:ensure t(确保一定安装)
;;  (setq use-package-always-defer t) ; 默认设置延迟加载
  )

;;(setq max-lisp-eval-depth 10000)


(require 'use-package)

(provide 'init-elpa)
;;;
