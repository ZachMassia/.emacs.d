(fill-keymap 'global
	     "C-x C-b" 'ibuffer
	     "C-a"     'smart-line-beginning
	     "C-x g"   'magit-status
	     "<f11>"   'toggle-fullscreen
	     "M-x"     'smex
         "C-c e"   'erc-start-or-switch)

(require 'paredit)
(require 'init-paredit)
(fill-keymap paredit-mode-map
             "M-s" 'paredit-splice-sexp
             "M-S" 'paredit-split-sexp
             "M-j" 'paredit-join-sexps

             "M-o" 'paredit-forward-down
             "M-O" 'paredit-forward-up
             "M-u" 'paredit-backward-down
             "M-U" 'paredit-backward-up

             "M-l" 'paredit-forward
             "M-h" 'paredit-backward
             "M-k" 'paredit-kill
             "M-(" 'backward-barf-sexp
             "M-)" 'forward-barf-sexp
             "C-(" 'backward-slurp-sexp
             "C-)" 'forward-slurp-sexp)

(provide 'init-key-bindings)
