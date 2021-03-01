;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.doom.d/org/")
(setq org-roam-directory "~/.doom.d/org-roam/")

;; (use-package! zygospore
;; :config
;; (global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(add-hook! LaTeX-mode
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-save-query nil
        TeX-source-correlate-start-server t
        TeX-source-correlate-method 'synctex
        reftex-plug-into-AUCTeX t
        +latex-viewers '(pdf-tools okular)
        )
  )
(global-set-key (kbd "M-;") #'comment-dwim-2)
(use-package! zygospore)
;; (load! zygospore)
(map! :leader
      :desc "Toggle delete other windows" "1" 'zygospore-toggle-delete-other-windows
      :desc "Vertical split" "2"  'evil-window-split
      :desc "Vertical split" "3"  'evil-window-vsplit
      :desc "Vertical split" "0"  'ace-delete-other-windows
      )
;; (global-set-key (kbd "M-;") #'comment-line)
(after! centaur-tabs
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-style "wave")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-height 36)
  )
;; (use-package! lsp-ui
;;   :defer
;;   :config
;;   (setq lsp-ui-sideline-show-hover t
;;         ;; (lsp-ui-doc-enalbe )
;;         ;; lsp-ui-doc-position 'at-point
;;         lsp-ui-doc-delay 1.5
;;         lsp-ui-doc-use-childframe nil
;;         ;; (lsp-ui-doc-show-with-cursor nil)
;;         ;; (lsp-ui-doc-show-with-nil nil)
;;         )
;;   ;; (lsp-ui-doc-enable t)
;;   )
(global-visual-line-mode)
(use-package! lsp-mode
  ;; :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        treemacs-space-between-root-nodes nil
        company-idle-delay 0.5
        company-minimum-prefix-length 1
        lsp-idle-delay 0.5 ;; clangd is fast
        ;; be more ide-ish
        lsp-headerline-breadcrumb-enable t
        )
  )
()
(use-package! nyan-mode
  :config
  (setq nyan-wavy-trail t
        nyan-animation-frame-interval 0.1)
  (nyan-mode)
  (nyan-start-animation))

(use-package! solaire-mode
  :config
  (setq solaire-mode-auto-swap-bg nil)
  )

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
