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
(use-package! org-roam
  :hook  (after-init . org-roam-mode)
  :custom (org-roam-directory "~/.doom.d/org-roam/")
  )
(add-hook! after-init all-the-icons-ivy-rich-mode)
(after! zygospore
  (global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(use-package! ivy-posframe
  :config
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
  (ivy-posframe-mode)
  )

(setq TeX-auto-save t
      TeX-parse-self t
      TeX-save-query nil
      TeX-source-correlate-start-server t
      TeX-source-correlate-method 'synctex
      reftex-plug-into-AUCTeX t
      +latex-viewers '(pdf-tools okular)
)

(use-package! centaur-tabs
  :config
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-style "box")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-height 36)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project)
  (centaur-tabs-mode)
  )

(use-package! solaire-mode
  :config
  (setq solaire-mode-auto-swap-bg nil)
  )
(use-package! zoom
  :commands (zoom-mode) )
;; (defun indent-region-or-buffer ()
;;   "Indent a region if selected, otherwise the whole buffer."
;;   (interactive)
;;   (unless (member major-mode prelude-indent-sensitive-modes)
;;     (save-excursion
;;       (if (region-active-p)
;;           (progn
;;             (indent-region (region-beginning) (region-end))
;;             (message "Indented selected region."))
;;         (progn
;;           (indent-buffer)
;;           (message "Indented buffer.")))
;;       (whitespace-cleanup))))

;; (global-set-key (kbd "C-c i") 'indent-region-or-buffer)

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
