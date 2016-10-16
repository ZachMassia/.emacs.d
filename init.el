
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar cask-el-path
  (pcase system-type
    (`darwin    "/usr/local/Cellar/cask/0.8.0/cask.el")
    (`gnu/linux "/usr/share/cask/cask.el")))

(require 'cask cask-el-path)
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))
