;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Ariel Fernandes"
      user-mail-address "0.arielfernandes.0@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-night)

(setq doom-font (font-spec :family "Hack" :size 14))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; Fallback cleanly to consult in TUI
;;
(display-time-mode 1)
(display-battery-mode 1)
(toggle-frame-maximized)

(setq-default enable-local-variables t)

(after! (:or lsp-mode lsp)
  :config
  (setq lsp-response-timeout 90000))

(after! company
  :config
  (setq company-selection-wrap-around t)
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0))

(after! ivy
  :config
  (setq enable-recursive-minibuffers t)

  ;; enable this if you want `swiper' to use it
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (counsel-rg . ivy--regex-plus)
          (t      . ivy--regex-fuzzy)))

  (setq ivy-bibtex-default-action 'ivy-bibtex-insert-key)

  (defun eh-ivy-return-recentf-index (dir)
    (when (and (boundp 'recentf-list)
               recentf-list)
      (let ((files-list
             (cl-subseq recentf-list
                        0 (min (- (length recentf-list) 1) 20)))
            (index 0))
        (while files-list
          (if (string-match-p dir (car files-list))
              (setq files-list nil)
            (setq index (+ index 1))
            (setq files-list (cdr files-list))))
        index)))

  (defun eh-ivy-sort-file-function (x y)
    (let* ((x (concat ivy--directory x))
           (y (concat ivy--directory y))
           (x-mtime (nth 5 (file-attributes x)))
           (y-mtime (nth 5 (file-attributes y))))
      (if (file-directory-p x)
          (if (file-directory-p y)
              (let ((x-recentf-index (eh-ivy-return-recentf-index x))
                    (y-recentf-index (eh-ivy-return-recentf-index y)))
                (if (and x-recentf-index y-recentf-index)
                    ;; Directories is sorted by `recentf-list' index
                    (< x-recentf-index y-recentf-index)
                  (string< x y)))
            t)
        (if (file-directory-p y)
            nil
          ;; Files is sorted by mtime
          (time-less-p y-mtime x-mtime)))))

  (add-to-list 'ivy-sort-functions-alist
               '(read-file-name-internal . eh-ivy-sort-file-function)))
