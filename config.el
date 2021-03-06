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

(use-package! ranger
  :config (setq ranger-override-dired 'ranger))

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
  ;; (add-hook 'evil-normal-state-entry-hook #'company-abort)
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
  (setq org-roam-server-host "localhost"
        org-roam-server-port 8080
        org-roam-server-authenticate nil))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((gnuplot . t)))



(use-package! lsp-latex
  :config
  (server-start)
  (setq
   lsp-latex-forward-search-executable "emacsclient"
   lsp-latex-texlab-executable "~/.cargo/bin/texlab"
   lsp-latex-forward-search-args
   '("--eval"
     "(lsp-latex-forward-search-with-pdf-tools \"%f\" \"%p\" \"%l\")")
   ))
(setq +latex-viewers '(zathura pdf-tools okular))
;; (add-hook! LaTeX-mode
;;   (setq TeX-auto-save t
;;         TeX-parse-self t
;;         TeX-save-query nil
;;         TeX-source-correlate-start-server t
;;         TeX-PDF-mode t
;;         TeX-source-correlate-method 'synctex
;;         reftex-plug-into-AUCTeX t
;;         +latex-viewers '(pdf-tools zathura)
;;         )
;;   )
;; (add-hook! LaTeX-mode lsp)

(global-set-key (kbd "M-;") 'comment-dwim-2)
(map! :leader
      :desc "Toggle delete other windows" "1" 'zygospore-toggle-delete-other-windows
      :desc "Vertical split" "2"  'evil-window-split
      :desc "Vertical split" "3"  'evil-window-vsplit
      :desc "Vertical split" "0"  'ace-delete-other-windows
      :desc "Kill buffer" "k" 'kill-this-buffer
      :desc "Previous buffer" "[" 'previous-buffer
      :desc "Next buffer" "]" 'next-buffer
      )
(global-set-key (kbd "C-s") 'save-buffer)

(defhydra hydra-dired (:hint nil :color pink)
  "
_+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
_C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
_D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
_R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
_Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
_S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
_r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
_z_ compress-file  _A_ find regexp
_Z_ compress       _Q_ repl regexp

T - tag prefix
"
  ("\\" dired-do-ispell)
  ("(" dired-hide-details-mode)
  (")" dired-omit-mode)
  ("+" dired-create-directory)
  ("=" diredp-ediff)         ;; smart diff
  ("?" dired-summary)
  ("$" diredp-hide-subdir-nomove)
  ("A" dired-do-find-regexp)
  ("C" dired-do-copy)        ;; Copy all marked files
  ("D" dired-do-delete)
  ("E" dired-mark-extension)
  ("e" dired-ediff-files)
  ("F" dired-do-find-marked-files)
  ("G" dired-do-chgrp)
  ("g" revert-buffer)        ;; read all directories again (refresh)
  ("i" dired-maybe-insert-subdir)
  ("l" dired-do-redisplay)   ;; relist the marked or singel directory
  ("M" dired-do-chmod)
  ("m" dired-mark)
  ("O" dired-display-file)
  ("o" dired-find-file-other-window)
  ("Q" dired-do-find-regexp-and-replace)
  ("R" dired-do-rename)
  ("r" dired-do-rsynch)
  ("S" dired-do-symlink)
  ("s" dired-sort-toggle-or-edit)
  ("t" dired-toggle-marks)
  ("U" dired-unmark-all-marks)
  ("u" dired-unmark)
  ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
  ("w" dired-kill-subdir)
  ("Y" dired-do-relsymlink)
  ("z" diredp-compress-this-file)
  ("Z" dired-do-compress)
  ("q" nil)
  ("." nil :color blue))
;; (define-key dired-mode-map "." 'hydra-dired/body)
(map!
 :map dired-mode-map
 ("." 'hydra-dired/body)
 )

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))
(add-to-list 'auto-mode-alist '("\\.terminal\\'" . auto-revert-tail-mode))

(defun etc-log-tail-handler ()
  (end-of-buffer)
  (make-variable-buffer-local 'auto-revert-interval)
  (setq auto-revert-interval 1)
  (auto-revert-set-timer)
  (make-variable-buffer-local 'auto-revert-verbose)
  (setq auto-revert-verbose nil)
  (read-only-mode t)
  (font-lock-mode 0)
  (when (fboundp 'show-smartparens-mode)
    (show-smartparens-mode 0)))

(add-hook 'auto-revert-tail-mode-hook 'etc-log-tail-handler)

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))
