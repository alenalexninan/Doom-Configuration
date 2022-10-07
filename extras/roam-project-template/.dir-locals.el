;; Directory loacl variable for roam
;;; For more information see (info "(emacs) Directory Variables")

((nil . ((eval . (setq-local org-roam-directory (expand-file-name "./")))
(eval . (git-auto-commit-mode 1))
(org-attach-id-dir . "~/roam/attachments")
(eval . (setq-local org-roam-db-location (expand-file-name "./")))
)))
