(require 'init-utils)

(install-pkg-list '(jedi
                    py-autopep8))

(add-hook 'python-mode-hook
          (lambda ()
            (jedi:setup)
            (setq tab-width 4)))
(setq jedi:complete-on-dot t)

(provide 'init-python)
 
