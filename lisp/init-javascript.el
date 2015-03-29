(require 'zach-utils)

(install-pkg-list '(js2-mode
                    js2-refactor
                    json-mode))

(require 'js2-mode)

;; Use js2-mode for Javascript
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Use 2 space indentation
(setq js2-basic-offset 2)
(setq js-indent-level 2)

(add-hook 'js2-mode-hook
          (lambda ()
            (autopair-on)))

(provide 'init-javascript)