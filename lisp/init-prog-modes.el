(install-pkg-list '(flycheck
                    fic-mode))

(require 'flycheck)
(require 'fic-mode)

(setq fic-highlighted-words '("FIXME" "FIXME:" "TODO" "TODO:"
                              "HACK" "HACK:" "NOTE" "NOTE:"
                              "BUG" "BUG:" "REFACTOR" "REFACTOR:"))

(defcustom programming-language-major-modes
  '(prog-mode     ; This is the mode perl, makefile, lisp-mode, scheme-mode,
                  ; emacs-lisp-mode, sh-mode, java-mode, c-mode, c++-mode,
                  ; python-mode inherits from.
    lua-mode
    cmake-mode
    tex-mode                            ; LaTeX inherits
    sgml-mode                           ; HTML inherits
    css-mode
    nxml-mode
    diff-mode
    haskell-mode
    rst-mode
    arduino-mode)
  "What to consider as programming languages.")

(dolist (mode programming-language-major-modes)
  (add-hook
   (intern (concat (symbol-name mode) "-hook"))
   (lambda ()
     (fic-mode 1)
     (rainbow-delimiters-mode 1)
     (yas-minor-mode 1)
     (whitespace-mode 1)
     (autopair-mode 1)
     (hl-line-mode 1))))

(setq compilation-ask-about-save nil
      compilation-window-height 30)

(global-font-lock-mode 1)

(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-completion-system 'ido)

(defun magnars/adjust-flycheck-automatic-syntax-eagerness ()
  "Adjust how often we check for errors based on if there are any.

   This lets us fix any errors as quickly as possible, but in a
   clean buffer we're an order of magnitude laxer about checking."
  (setq flycheck-idle-change-delay
        (if flycheck-current-errors 0.5 5.0)))

;; Each buffer gets its own idle-change-delay because of the
;; buffer-sensitive adjustment above.
(make-variable-buffer-local 'flycheck-idle-change-delay)

(add-hook 'flycheck-after-syntax-check-hook
          'magnars/adjust-flycheck-automatic-syntax-eagerness)

;; Remove newline checks, since they would trigger an immediate check
;; when we want the idle-change-delay to be in effect while editing.
(setq flycheck-check-syntax-automatically '(save
                                            idle-change
                                            mode-enabled))

(defun flycheck-handle-idle-change ()
  "Handle an expired idle time since the last change.

   This is an overwritten version of the original
   flycheck-handle-idle-change, which removes the forced deferred.
   Timers should only trigger inbetween commands in a single
   threaded system and the forced deferred makes errors never show
   up before you execute another command."
  (flycheck-clear-idle-change-timer)
  (flycheck-buffer-automatically 'idle-change))

(provide 'init-prog-modes)