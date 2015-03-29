(require 'eldoc)
(require 'auto-complete)

(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)

(defcustom elisp-programming-major-modes
  '(emacs-lisp-mode
    lisp-interaction-mode
    ielm-mode)
  "Modes that are used to do Elisp programming.")

(dolist (mode elisp-programming-major-modes)
  (add-hook
   (intern (concat (symbol-name mode) "-hook"))
   (lambda ()
     (turn-on-eldoc-mode)
     (paredit-mode 1)
     (autopair-mode 1)
     (rainbow-delimiters-mode 1)
     (pretty-lambda-mode 1))))

(defun ielm-auto-complete ()
  "Enables `auto-complete' support in \\[ielm]."
  (setq ac-sources '(ac-source-functions
		     ac-source-variables
		     ac-source-features
		     ac-source-symbols
		     ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'inferior-emacs-lisp-mode))
(add-hook 'ielm-mode-hook 'ielm-auto-complete)

(provide 'init-elisp)
