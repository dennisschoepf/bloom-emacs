;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dennis Schoepf"
      user-mail-address "me@dnsc.io")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 18)
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/orgnzr/")
(setq org-roam-directory "~/Dropbox/memex")
(setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ORG configuration
(after! org
  (setq org-agenda-files (list
                          "~/Dropbox/orgnzr/in.org"
                          "~/Dropbox/orgnzr/_work.org"
                          "~/Dropbox/orgnzr/_university.org"
                          "~/Dropbox/orgnzr/_personal.org"))
  (setq org-todo-keywords '((sequence "PROJECT(p)" "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (add-to-list 'org-capture-templates
               '("c" "Capture in Inbox" entry (file "~/Dropbox/orgnzr/in.org") "* TODO %?\n" :prepend t :kill-buffer t))
  (add-to-list 'org-capture-templates
               '("t" "New Thought" entry (file "~/Dropbox/orgnzr/thoughts.org") "* %?\n" :prepend t :kill-buffer t))
  (add-to-list 'org-capture-templates
               '("i" "New Idea" entry (file "~/Dropbox/orgnzr/ideas.org") "* %?\n" :prepend t :kill-buffer t))
  (with-eval-after-load 'ox-latex (add-to-list 'org-latex-classes '("uni-submission"
                                                                    "\\documentclass[a4paper, 11pt]{article}
                                     \\usepackage{graphicx}
                                     \\usepackage[margin=2.5cm]{geometry}
                                     \\usepackage[utf8]{inputenc}
                                     \\usepackage{hyperref}
                                     [NO-DEFAULT-PACKAGES]
                                     [NO-PACKAGES]
                                     [EXTRA]"
                                                                    ("\\section{%s}" . "\\section*{%s}")
                                                                    ("\\subsection{%s}" . "\\subsection*{%s}")
                                                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                                                    ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                                                    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                                                                    ))))
(use-package! org-ref
  :config
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")))

(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

;; Programming setup
(setq typescript-indent-level 2)
(setq js-indent-level 2)
(setq js2-indent-level 2)
(setq javascript-indent-level 2)
(setq js2-basic-offset 2)
(setq web-mode-markup-indent-offset 2)
(setq indent-tabs-mode nil)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq react-indent-level 2)
(setq web-mode-script-padding 2)

;; Disable Typescript formatting as it uses tsfmt
(setq-hook! 'typescript-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-tsx-mode-hook +format-with-lsp nil)

;; Use prettier where possible
(add-hook 'after-init-hook #'global-prettier-mode)
