(require 'init-utils)

(install-pkg-list '(jedi
                    py-autopep8))

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(provide 'init-python)
 
