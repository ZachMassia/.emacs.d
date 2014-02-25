(install-pkg-list '(clojure-mode
                    clojure-test-mode
                    cider
                    align-cljlet
                    ac-nrepl
                    clojure-cheatsheet
                    clj-refactor))
(require 'cider)
(require 'cider-eldoc)
(require 'clojure-mode)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

(defadvice clojure-test-run-tests (before save-first activate)
  (save-buffer))

(defadvice cider-load-current-buffer (before save-first activate)
  (save-buffer))

(add-hook 'cider-mode-hook
          (lambda ()
            (cider-turn-on-eldoc-mode)
            (ac-nrepl-setup)))

(add-hook 'cider-repl-mode-hook
          (lambda ()
            (setq show-trailing-whitespace nil)
            (ac-nrepl-setup)
            (cider-turn-on-eldoc-mode)
            (paredit-mode 1)))

(add-hook 'clojure-mode-hook
          (lambda ()
            (clj-refactor-mode 1)
            (cider-mode 1)
            (fill-keymap cider-mode-map
                         "C-c c-e" 'cider-eval-defun-at-point
                         "C-c C-h" 'clojure-cheatsheet
                         "C-c C-m" nil)
            (cljr-add-keybindings-with-prefix "C-c C-m")
            (clojure-test-mode 1)
            (autopair-mode 1)
            (paredit-mode 1)
            (local-set-key (kbd "RET") 'newline-and-indent)))

(defun cider-namespace-refresh ()
  (interactive)
  (cider-eval-sync
   "(require '[clojure.tools.namespace.repl :refer [refresh]])
    (refresh)"
   (cider-current-ns)))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "λ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\)("
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "ƒ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\){"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "∈")
                               nil))))))


(provide 'init-clojure)
