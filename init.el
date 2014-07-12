(add-to-list 'load-path user-emacs-directory)

(defvar vendor-dir
     (expand-file-name "vendor" user-emacs-directory))
(add-to-list 'load-path vendor-dir)

(require 'init-package)
(require 'init-utils)

(install-pkg-list
 '(auto-complete
   smex
   magit
   autopair
   rainbow-delimiters
   cyberpunk-theme
   solarized-theme
   paredit
   popup
   fuzzy
   pretty-lambdada
   yasnippet
   yaml-mode
   projectile
   editorconfig
   markdown-mode
   markdown-mode+))

;;;; Appearance --------------------------------------
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq initial-scratch-message
      ";; scratch buffer -- hack away!")

;; Set the font based on OS.
(pcase system-type
  (`darwin     (set-frame-font "Monaco-12"))
  (`gnu/linux  (set-frame-font "Source Code Pro Medium-10"))
  (`windows-nt (set-frame-font "-outline-Consolas-normal-r-normal-normal-14-97-96-96-c-*-iso8859-1")))

(if (display-graphic-p) 
    (load-theme 'solarized-dark t))

(setq-default tab-width 4
              line-spacing 3)

;;;; Misc --------------------------------------------
;; OSX Stuff
(when (eq system-type 'darwin)
  ;; Use command key as meta
  (setq mac-option-modifier 'super
        mac-command-modifier 'meta)
  ;; Make ansi-term play nice with zsh prompt
  (defadvice ansi-term (after advise-ansi-term-coding-system)
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))

;; ERC
(require 'erc)
(erc-autojoin-mode t)
(erc-track-mode t)
(setq erc-autojoin-channels-alist '((".*\\.freenode.net" "#clojure" "#lpmc"))
      erc-hide-list '("JOIN" "PART" "QUIT" "NICK")
      erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))
(defun erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer."
  (interactive)
  (if (get-buffer "irc.freenode.net:6667")
      (erc-track-switch-buffer 1)
    (when (y-or-n-p "Start ERC? ")
      (erc :server "irc.freenode.net" :port 6667 :nick "zachmassia" :full-name "Zachary Massia"))))

;; Projectile
(require 'projectile)
(projectile-global-mode)

;; Ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; Paren
(require 'paren)
(show-paren-mode t)
(setq show-paren-delay 0
      show-paren-style 'parenthesis)

(setq whitespace-style '(face empty lines-tail trailing)
      whitespace-line-column 120)

(column-number-mode 1)

(setq-default indent-tabs-mode nil)

;;;; Backup Settings ---------------------------------
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t))
      backup-directory-alist '((".*" . "~/.emacs.d/backups/")))

(make-directory (concat user-emacs-directory "autosaves/") t)

(setq vc-make-backup-files t
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;;;; -------------------------------------------------
(load-elisp-files-in-dir user-emacs-directory "^init-.\*")
(require 'init-key-bindings)

;;;; -------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8ac31e1bc1920b33d478dfafb0b45989a00ede15a2388ea16093e7d0988c48d0" "968d1ad07c38d02d2e5debffc5638332696ac41af7974ade6f95841359ed73e3" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
