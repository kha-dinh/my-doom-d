;;; config.el -*- lexical-binding: t; -*-

(setq-default delete-by-moving-to-trash t                      ; Delete files to trash
              window-combination-resize t                      ; take new window space from all other windows (not just current)
              x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(display-time-mode 1)                             ; Enable time in the mode-line

(if (equal "Battery status not available"
           (battery))
    (display-battery-mode 1)                        ; On laptops it's nice to know how much power you have
  (setq password-cache-expiry nil))               ; I can trust my desktops ... can't I? (no battery = desktop)

(global-subword-mode 1)                           ; Iterate through CamelCase words

(setq user-full-name "Dinh Duy Kha"
      user-mail-address "dalo2903@gmail.com")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)
(use-package! solaire-mode
  :config
  (setq solaire-mode-auto-swap-bg nil)
  )
(use-package! nyan-mode
  :config
  (setq nyan-wavy-trail t
        nyan-animation-frame-interval 0.1)
  (nyan-mode)
  (nyan-start-animation))
(global-visual-line-mode)
(setq display-line-numbers-type 'relative)
(after! centaur-tabs
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-style "wave")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-height 36)

  )

(defvar my-completion-delay 0.5)

(use-package! lsp-mode
  ;; :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        treemacs-space-between-root-nodes nil
        lsp-idle-delay my-completion-delay ;; clangd is fast
        lsp-headerline-breadcrumb-enable t
        )
  )

(after! company
  :config
  (setq
   company-idle-delay my-completion-delay
   company-minimum-prefix-length 1)
  (map!
   :map company-active-map
   ("<tab>" 'company-complete-selection)
   ("<return>" nil)
   ("RET" nil)
   )
  (add-hook 'evil-normal-state-entry-hook #'company-abort)
  )



;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.doom.d/org/")
(setq org-roam-directory "~/.doom.d/org/roam/")
(setq deft-directory "~/.doom.d/org/")
;; (setq org-ref-completion-library 'org-ref-ivy-cite)
(setq reftex-default-bibliography "~/.doom.d/org/bibliography/bibliography.bib")
(setq bibtex-completion-bibliography '("~/.doom.d/org/bibliography/bibliography.bib")
      bibtex-completion-library-path "~/.doom.d/org/bibliography/pdfs"
      bibtex-completion-notes-path "~/.doom.d/org/bibliography/ivy-bibtex-notes"
      )
(use-package! org-ref
  :config
  (setq org-ref-default-bibliography '("~/.doom.d/org/bibliography/bibliography.bib")
        org-ref-bibliography-notes "~/.doom.d/org/bibliography/notes.org"
        org-ref-pdf-directory "~/.doom.d/org/bibliography/pdfs/"
        org-ref-completion-library 'org-ref-ivy-cite
        ))

(setq deft-recursive t)
(add-hook! org-mode +org-pretty-mode)
(use-package! org-roam-server
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil))



(add-hook! LaTeX-mode
  (setq TeX-auto-save t
        TeX-parse-self t
        TeX-save-query nil
        TeX-source-correlate-start-server t
        TeX-source-correlate-method 'synctex
        reftex-plug-into-AUCTeX t
        +latex-viewers '(pdf-tools zathura)
        lsp-latex-texlab-executable "~/.cargo/bin/texlab"
        )
  )
;; (add-hook! LaTeX-mode lsp)

(global-set-key (kbd "M-;") 'comment-dwim-2)
(map! :leader
      :desc "Toggle delete other windows" "1" 'zygospore-toggle-delete-other-windows
      :desc "Vertical split" "2"  'evil-window-split
      :desc "Vertical split" "3"  'evil-window-vsplit
      :desc "Vertical split" "0"  'ace-delete-other-windows
      :desc "Kill buffer" "k" 'kill-this-buffer
      )
