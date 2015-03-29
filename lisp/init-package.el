(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(when (not package-archive-contents)
  (package-refresh-contents))
(package-initialize)

(provide 'init-package)
