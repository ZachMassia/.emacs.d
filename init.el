(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))
