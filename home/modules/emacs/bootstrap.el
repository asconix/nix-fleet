(let ((cfg (expand-file-name "hm-config.el" user-emacs-directory)))
  (when (file-exists-p cfg)
    (file-notify-add-watch
     cfg '(change)
     (lambda (_event)
       (condition-case err
           (progn
             (load-file cfg)
             (message "Reloaded %s" cfg))
         (error
          (message "Reload failed: %s" err)))))))