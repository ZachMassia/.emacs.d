(require 'zach-utils)

(install-pkg-list '(csharp-mode
                    omnisharp))

(require 'csharp-mode)
(require 'omnisharp)

(add-hook 'csharp-mode-hook 'omnisharp-mode)

(provide 'init-csharp)
