(require 'init-utils)

(install-pkg-list '(geiser
                    ac-geiser))

(require 'geiser)
(require 'ac-geiser)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'geiser-repl-mode))

(add-hook 'geiser-mode-hook
          (lambda ()
            (ac-geiser-setup)
            (paredit-mode 1)))

(add-hook 'geiser-repl-mode-hook
          (lambda ()
            (ac-geiser-setup)
            (paredit-mode 1)))


(require 'quack)

(provide 'init-racket)
