(require 'zach-utils)

(install-pkg-list '(clojure-mode
                    cider
                    ac-cider
                    align-cljlet
                    clojure-cheatsheet
                    clj-refactor
                    cljsbuild-mode
                    4clojure))

(require 'cider)
(require 'cider-eldoc)
(require 'clojure-mode)
(require 'cljsbuild-mode)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

;; Prevent Cider from adding Java processes to the dock in OSX.
(eval-after-load "clojure-mode"
  '(setenv "LEIN_JVM_OPTS" "-Dapple.awt.UIElement=true"))

(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))

(setq cljsbuild-hide-buffer-on-success t
      cljsbuild-compile-command "lein trampoline cljsbuild auto")

(setq nrepl-hide-special-buffers t
      cider-auto-select-error-buffer nil
      cider-repl-result-prefix ";; => "
      cider-repl-use-pretty-printing t
      cider-repl-use-clojure-font-lock t)

(defadvice clojure-test-run-tests (before save-first activate)
  (save-buffer))

(defadvice cider-load-current-buffer (before save-first activate)
  (save-buffer))

(defun count-last-sexp ()
  (interactive)
  (cider-interactive-eval
   (format "(count %s)"
           (cider-last-sexp))))

(defun nth-from-last-sexp (n)
  (interactive "p")
  (cider-interactive-eval
   (format "(nth %s %s)"
           (cider-last-sexp) n)))

(add-hook 'cider-mode-hook
          (lambda ()
            (cider-turn-on-eldoc-mode)
            (ac-nrepl-setup)))

(add-hook 'cider-repl-mode-hook
          (lambda ()
            (setq show-trailing-whitespace nil)
            (ac-nrepl-setup)
            (cider-turn-on-eldoc-mode)
            (paredit-mode 1)
            (hl-line-mode -1)))

(add-hook 'clojure-mode-hook
          (lambda ()
            (clj-refactor-mode 1)
            (cider-mode 1)
            (fill-keymap cider-mode-map
                         "C-c c-e" 'cider-eval-defun-at-point
                         "C-c C-h" 'clojure-cheatsheet
                         "C-c C-m" nil
                         "C-x C-i" 'align-cljlet
                         ;; Next two give error for some reason
                         ;"C-c c"   'count-last-sexp
                         ;"C-c n"   'nth-from-last-sexp
                         )
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

;; Teach compile the syntax of the kibit output
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
         '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
(add-to-list 'compilation-error-regexp-alist 'kibit)

;; A convenient command to run "lein kibit" in the project to which
;; the current emacs buffer belongs to.
(defun kibit ()
  "Run kibit on the current project.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile "lein kibit"))

(defun kibit-current-file ()
  "Run kibit on the current file.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile (concat "lein kibit " buffer-file-name)))

(require 'projectile)
(defun lein-server ()
  "Run 'lein server' in the project root."
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (start-process "lein-server" "*lein-server*" "lein" "trampoline" "server")))

(defun 4clojure-check-and-proceed ()
  "Check the answer and show the next question if it worked"
  (interactive)
  (unless
      (save-excursion
        ;; Find last sexp (the answer.)
        (goto-char (point-max))
        (forward-sexp -1)
        ;; Check the answer.
        (cl-letf ((answer
                   (buffer-substring (point) (point-max)))
                  ;; Preserve buffer contents, in case you failed.
                  ((buffer-string)))
          (goto-char (point-min))
          (while (search-forward "__" nil t)
            (replace-match answer))
          (string-match "failed." (4clojure-check-answers))))
    (4clojure-next-question)))

(defadvice 4clojure/start-new-problem
    (after 4clojure/start-new-problem-advice () activate)
  ;; Prettify the 4clojure buffer.
  (goto-char (point-min))
  (forward-line 2)
  (forward-char 3)
  (fill-paragraph)
  ;; Position point for the answer
  (goto-char (point-max))
  (insert "\n\n\n")
  (forward-char -1)
  ;; Define our key.
  (local-set-key (kbd "M-j") #'4clojure-check-and-proceed))

(defadvice 4clojure-open-question
    (around 4clojure-open-question-around)
  "Start a cider/nREPL connection if one hasn't already been started when
opening 4clojure questions"
  ad-do-it
  (unless cider-current-clojure-buffer
    (cider-jack-in)))


(provide 'init-clojure)
