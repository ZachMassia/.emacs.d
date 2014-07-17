(require 'init-utils)

(install-pkg-list '(haskell-mode))
(require 'haskell-mode)

(add-hook 'haskell-mode-hook
          (lambda ()
            (turn-on-haskell-indentation)
            (auto-complete-mode)
            (autopair-mode)))

(eval-after-load "haskell-mode"
  '(fill-keymap haskell-mode-map
                "C-x C-d" nil
                "C-c C-z" 'haskell-interactive-switch
                "C-c C-l" 'haskell-process-load-file
                "C-c C-b" 'haskell-interactive-switch
                "C-c C-t" 'haskell-process-do-type
                "C-c C-i" 'haskell-process-do-info
                "C-c M-." nil
                "C-c C-d" nil))

(provide 'init-haskell)
