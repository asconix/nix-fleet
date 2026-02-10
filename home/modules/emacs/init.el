;; --- Vanilla init.el managed by Home Manager ---

;; Load bootstrap
(load (expand-file-name "bootstrap.el" user-emacs-directory) nil 'nomessage)

(setq inhibit-startup-screen t
    make-backup-files nil
    auto-save-default nil
    create-lockfiles nil
    ring-bell-function 'ignore)

    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (scroll-bar-mode -1)

    (global-display-line-numbers-mode 1)
    (column-number-mode 1)

    (when (eq system-type 'darwin)
      (setq mac-option-modifier 'meta)
      (setq mac-command-modifier 'super))