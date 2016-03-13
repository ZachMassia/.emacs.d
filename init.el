(defvar cask-el-path
  (pcase system-type
    (`darwin    "/usr/local/Cellar/cask/0.7.4/cask.el")
    (`gnu/linux "/usr/share/cask/cask.el")))

(require 'cask cask-el-path)
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))
