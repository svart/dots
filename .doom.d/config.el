;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dmitry Shinkaruk"
      user-mail-address "dimashink@gmail.com")

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
(setq doom-font (font-spec :family "JetBrainsMono NF" :size 21 :weight 'regular)
;; (setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 21 :weight 'regular :style 'retina)
      doom-variable-pitch-font (font-spec :family "FreeSerif" :size 21)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 35))
(after! doom-theme
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))

;; Mode-line configuration
(setq doom-modeline-height 10)
(custom-set-faces
  '(mode-line ((t (:family "JetBrainsMono Nerd Font" :height 0.9))))
  '(mode-line-inactive ((t (:family "JetBrainsMono Nerd Font" :height 0.9)))))
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-solarized-light)
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


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

(setq-default tab-width 4)

;; Change local leader key to ","
(setq doom-localleader-key ",")
(setq doom-localleader-alt-key "M-,")

;; orgmode configuration
;; Default directory for storing org files
(setq org-directory "~/Documents/org")
(setq org-roam-directory "~/Documents/org/roam")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files '("~/Documents/org" "~/Documents/org/roam"))
(setq org-log-into-drawer "LOGBOOK")
(setq org-agenda-show-future-repeats 'next)
(setq org-agenda-skip-scheduled-if-done 't)
(setq org-agenda-skip-deadline-if-done 't)
(after! org
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"
           "IN-PROGRESS(s)"
           "IDEA(i)"
           "PROBLEM(p)"
           "WAITING(w)"
           "DELEGATED(d)"
           "POSTPONED(P)"
           "|"
           "DONE(x)"
           "CANCELED(c)"))
        org-todo-keyword-faces
        '(("IN-PROGRESS" . "orange")
          ("WAITING" . "purple")
          ("PROBLEM" . "red")
          ("CANCELED" . "grey")
          ("DELEGATED" . "pink")
          ("POSTPONED" . "#008080"))
        org-hide-emphasis-markers t
        org-startup-folded t
  )
)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "todo.org" "Inbox")
         "* TODO %?\n %i %a" :empty-lines 1)
        ("n" "Note" entry (file+headline "notes.org" "Notes")
         "* %?\n %i %a" :emptry-lines 1)
       )
)

(setq projectile-project-search-path '("~/work"))

;; Make evil-search-word look for symbol rather than word boundaries
(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol)
  (setq-default evil-symbol-word-search t)
)

(map! :leader
      :prefix "c"
      :desc "Comment or uncomment lines"  ";" #'evilnc-comment-or-uncomment-lines
      :desc "Open code structure sidebar" "u" #'lsp-ui-imenu
      :desc "Restart LSP server for workspace" "R" #'lsp-restart-workspace

      :prefix "f"
      :desc "New file" "n" #'dired-create-empty-file ;; TODO: open this file after creation

      :prefix "s"
      :desc "Copy visible link" "L" #'link-hint-copy-link
)

(map! :after evil-org
      :map evil-org-mode-map
      :localleader
      :desc "Insert structured template" :nv "S" #'org-insert-structure-template
)

(map! :after lsp-mode
      :localleader
      :prefix "g"
      :desc "Open ref in other window" :n "g" #'xref-find-definitions-other-window
)


;; org-roam-ui configuration
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
