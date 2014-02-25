(add-to-list 'load-path user-emacs-directory)

(require 'init-package)
(require 'init-utils)

(let ((basic-pkgs '(auto-complete
		    smex
		    magit
		    autopair
		    rainbow-delimiters
		    cyberpunk-theme
		    paredit
		    popup
		    fuzzy
		    pretty-lambdada
                    yasnippet)))
  (install-pkg-list basic-pkgs))

;;;; Appearance --------------------------------------
(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq initial-scratch-message
      ";; scratch buffer -- hack away!")

(when (eq system-type 'gnu/linux)
  (set-frame-font "Droid Sans Mono-13"))

(if (display-graphic-p) 
    (load-theme 'cyberpunk t))

;;;; Misc --------------------------------------------
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

(setq whitespace-style '(face empty lines-tail trailing))

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
