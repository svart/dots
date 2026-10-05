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
(setq doom-font (font-spec :family "JetBrainsMono" :size 21 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "FreeSerif" :size 21)
      doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 35))

;; Specify font for Cyrillic characters separately as default config was not applied
(set-fontset-font t 'cyrillic (font-spec :family "JetBrainsMono" :size 21 :weight 'regular))

(after! doom-theme
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))

;; Mode-line configuration
(setq doom-modeline-height 10)
(custom-set-faces
  '(mode-line ((t (:family "JetBrainsMono NF" :size 12))))
  '(mode-line-inactive ((t (:family "JetBrainsMono NF" :size 12)))))
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

;; Fix inserting last stored link when link is stored by id
(defadvice! +org--store-id-link-a (link)
  :filter-return #'org-id-store-link
  (when (and link org-store-link-plist)
    (add-to-list 'org-stored-links
                 (list (plist-get org-store-link-plist :link)
                       (plist-get org-store-link-plist :description))))
  link)


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
)

(map! :leader
     :prefix "f"
     :desc "New file" "n" #'dired-create-empty-file ;; TODO: open this file after creation
)

(map! :leader
     :prefix "s"
     :desc "Copy visible link" "L" #'link-hint-copy-link
)

(map! :leader
      :prefix "o"
      :desc "Dired" "d" #'dired-jump
      :desc "Start a debugger" "-" #'+debugger/start
      :desc "Toggle vterm popup" "T" #'+vterm/toggle
      :desc "Open vterm here" "t" #'+vterm/here)

(map! :after evil-org
     :map evil-org-mode-map
     :localleader
     :desc "Insert structured template" :nv "S" #'org-insert-structure-template
     :desc "Run source code block" :nv "R" #'org-babel-execute-src-block
)

(map! :after lsp-mode
      :map lsp-mode-map
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

(set-popup-rule! "^\\*doom:scratch" :width 0.5 :side 'right)

(use-package mindstream
  :config
  (mindstream-mode))

;; ArkTS (HarmonyOS). One-time grammar install:
;;   M-x treesit-install-language-grammar RET arkts
(use-package! arkts-ts-mode
  :load-path (lambda () (expand-file-name "lisp" doom-user-dir))
  :mode "\\.ets\\'"
  :hook (arkts-ts-mode-local-vars . lsp!))

;; ArkTS language server (@arkts/language-server, installed by
;; M-x lsp-install-server RET arkts-ls).  `sdkPath' must contain
;; ets/build-tools/ets-loader; override per project in .dir-locals.el.
(defvar my/arkts-sdk-path "~/.local/share/openharmony/sdk/12"
  "OpenHarmony SDK root used by the ArkTS language server.")
(defvar my/arkts-hms-path nil
  "HarmonyOS HMS SDK root (DevEco `hms' dir), or nil for pure OpenHarmony.")
(put 'my/arkts-sdk-path 'safe-local-variable #'stringp)
(put 'my/arkts-hms-path 'safe-local-variable #'string-or-null-p)

(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(arkts-ts-mode . "ets"))
  (lsp-dependency 'ets-language-server
                  '(:system "ets-language-server")
                  '(:npm :package "@arkts/language-server"
                         :path "ets-language-server"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     (lambda ()
                       (list (lsp-package-path 'ets-language-server) "--stdio")))
    :activation-fn (lsp-activate-on "ets")
    :server-id 'arkts-ls
    :initialization-options
    (lambda ()
      `(:ets (:sdkPath ,(expand-file-name my/arkts-sdk-path)
              ,@(when my/arkts-hms-path
                  `(:hmsPath ,(expand-file-name my/arkts-hms-path))))))
    :download-server-fn
    (lambda (_client callback error-callback _update?)
      (lsp-package-ensure 'ets-language-server callback error-callback)))))

;; Repo list honouring dir-local `magit-repository-directories'.
(defun my/magit-list-repositories ()
  (interactive)
  (let ((dirs magit-repository-directories))
    (magit-list-repositories)
    (with-current-buffer "*Magit Repositories*"
      (setq-local magit-repository-directories dirs)
      (magit-repolist-refresh))))

(map! :leader "g L" #'my/magit-list-repositories)

(defun my/magit-repolist-column-branch-dirty (_)
  (concat (or (magit-get-current-branch) (magit-rev-parse "--short" "HEAD"))
          (and (magit-anything-modified-p) "*")))

(defun my/magit-repolist-column-upstream-sync (_)
  "Commits ahead (↑) and behind (↓) the upstream, or \"=\" when in sync.
Without a configured upstream, compares with origin/<branch>.
Uses the local remote-tracking ref; it does not fetch."
  (when-let* ((upstream
               (or (magit-get-upstream-branch)
                   (when-let* ((branch (magit-get-current-branch))
                               (ref (concat "origin/" branch)))
                     (and (magit-ref-exists-p (concat "refs/remotes/" ref))
                          ref)))))
    (pcase-let ((`(,ahead ,behind) (magit-rev-diff-count "HEAD" upstream)))
      (if (= 0 ahead behind)
          "="
        (string-join (delq nil (list (and (> ahead 0) (format "↑ %d" ahead))
                                     (and (> behind 0) (format "↓ %d" behind))))
                     " ")))))

(after! magit-repos
  (setq magit-repolist-columns
        '(("Name"   25 magit-repolist-column-ident nil)
          ("Branch" 25 my/magit-repolist-column-branch-dirty nil)
          ("Sync"   10 my/magit-repolist-column-upstream-sync nil)
          ("Path"   99 magit-repolist-column-path nil))))
