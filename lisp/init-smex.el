(require 'smex)

(defadvice smex (around space-inserts-hyphen activate compile)
  (let ((ido-cannot-complete-command 
	 `(lambda ()
	    (interactive)
	    (if (string= " " (this-command-keys))
		(insert ?-)
	      (funcall ,ido-cannot-complete-command)))))
    ad-do-it))

(provide 'init-smex)
