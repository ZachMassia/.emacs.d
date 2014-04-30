(require 'init-utils)

(install-pkg-list '(tss))

(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(require 'tss)
(setq tss-popup-help-key "C-:"
      tss-jump-to-definition-key "C->")

(tss-config-default)

(provide 'init-typescript)
