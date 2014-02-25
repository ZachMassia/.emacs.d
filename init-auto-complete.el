(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories (concat user-emacs-directory "ac-dict"))
(ac-config-default)

(setq ac-auto-start 0
      ac-quick-help-delay 0.5
      ac-fuzzy-enable t
      ac-use-fuzzy t
      ac-auto-show-menu 0.2)

(global-auto-complete-mode t)

(provide 'init-auto-complete)
