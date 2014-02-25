(require 'paredit)

(defun forward-barf-sexp (prefix)
  "Calls `paredit-forward-barf-sexp', unless PREFIX is non nil.
  With prefix it calls `paredit-barf-all-the-way-forward'"
  (interactive "P")
  (if prefix
      (paredit-barf-all-the-way-forward)
    (paredit-forward-barf-sexp)))

(defun forward-slurp-sexp (prefix)
  "Calls `paredit-forward-slurp-sexp`, unless PREFIX is non nil.
  With prefix it calls `paredit-slurp-all-the-way-forward'"
  (interactive "P")
  (if prefix
      (paredit-slurp-all-the-way-forward)
    (paredit-forward-slurp-sexp)))

(defun backward-barf-sexp (prefix)
  "Calls `paredit-backward-barf-sexp', unless PREFIX is non nil.
  With prefix it calls `paredit-barf-all-the-way-backward'"
  (interactive "P")
  (if prefix
      (paredit-barf-all-the-way-backward)
    (paredit-backward-barf-sexp)))

(defun backward-slurp-sexp (prefix)
  "Calls `paredit-backward-slurp-sexp', unless PREFIX is non nil.
  With prefix it calls `paredit-slurp-all-the-way-backward'"
  (interactive "P")
  (if prefix
      (paredit-slurp-all-the-way-backward)
    (paredit-backward-slurp-sexp)))

(defvar paredit-minibuffer-commands '(eval-expression
                                      pp-eval-expression
                                      eval-expression-with-eldoc
                                      ibuffer-do-eval
                                      ibuffer-do-view-and-eval)
  "Interactive commands for which paredit should be enabled in the minibuffer.")

(defun conditionally-enable-paredit-mode ()
  "Enable paredit during lisp-related minibuffer commands."
  (if (memq this-command paredit-minibuffer-commands)
      (enable-paredit-mode)))

(provide 'init-paredit)
