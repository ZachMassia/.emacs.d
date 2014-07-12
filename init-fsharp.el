(require 'init-utils)

(install-pkg-list '(fsharp-mode))

(require 'fsharp-mode)
(setq inferior-fsharp-program "/usr/local/bin/fsharpi"
      fsharp-compiler "/usr/local/bin/fsharpc")

(add-hook 'fsharp-mode-hook
          (lambda ()
            (auto-complete-mode t)
            (autopair-mode t)))

(provide 'init-fsharp)
