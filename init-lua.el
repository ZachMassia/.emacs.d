(require 'init-utils)

(install-pkg-list '(lua-mode))
(require 'lua-mode)

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(setq lua-indent-level 2)

(add-hook 'lua-mode-hook 'autopair-mode)

(provide 'init-lua)
