(require 'zach-utils)

(install-pkg-list '(go-mode))

(defun expand-go-src (pkg &optional domain)
  (let* ((root (if domain
                   (expand-file name "src" domain)
                 "src/github.com"))
         (gosrc (expand-file-name root (getenv "GOPATH"))))
    (expand-file-name pkg gosrc)))

(add-to-list 'load-path (expand-go-src "dougm/goflymake"))
(add-to-list 'load-path (expand-go-src "nsf/gocode/emacs"))
(require 'go-mode)
(require 'go-flycheck)
(require 'go-autocomplete)
(require 'auto-complete-config)

(add-hook 'before-save-hook #'gofmt-before-save)

(add-hook 'go-mode-hook (lambda ()
                          (autopair-mode)))

(provide 'init-go)
