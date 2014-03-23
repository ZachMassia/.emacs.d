(require 'init-utils)

(install-pkg-list '(js2-mode
                    js2-refactor))

(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-hook 'js2-mode-hook
          (lambda ()
            (autopair-on)))


(provide 'init-javascript)
