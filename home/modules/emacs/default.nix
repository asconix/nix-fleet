{ pkgs, lib, config, ... }:

{
  programs.emacs = {
    enable = true;
  };

  # home.file.".emacs.d/init.el".source = ./init.el;
  # Install the literate config
  home.file.".emacs.d/init.org".source = ./init.org;
  
  # Bootstrap init.el (small + stable)
  home.file.".emacs.d/init.el".text = ''
    ;; Bootstrap literate config
    (require 'org)

    (let ((org-file (expand-file-name "init.org" user-emacs-directory))
          (el-file  (expand-file-name "init.el" user-emacs-directory)))
      ;; Only tangle when org is newer than el
      (when (file-newer-than-file-p org-file el-file)
        (require 'ob-tangle)
        (org-babel-tangle-file org-file el-file "emacs-lisp")))

    ;; Load the tangled config (this file will be overwritten by tangle)
    ;; So we load the *tangled output* from a different name to avoid
    ;; clobbering the bootstrap.
    (load (expand-file-name "config.el" user-emacs-directory) nil 'nomessage)
  '';

  # IMPORTANT: tangle to config.el so bootstrap init.el stays intact
  home.file.".emacs.d/config.el".text = ""; # Placeholder, will be overwritten
}
