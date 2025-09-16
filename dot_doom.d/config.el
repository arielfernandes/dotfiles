;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "ariel fernandes"
      user-mail-address "0.arielfernandes.0@gmail.com")

(setq doom-font (font-spec :family "hack" :size 14))
(setq doom-theme 'doom-tomorrow-night)

(setq display-line-numbers-type t)
(setq org-directory "~/org/")

(display-time-mode 1)
(display-battery-mode 1)
(toggle-frame-maximized)
(setq-default enable-local-variables t)

(setq org-hierarchical-todo-statistics nil)

;; GC otimizado
(setq gc-cons-threshold (* 100 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 8 1024 1024))))

;; recentf
(setq recentf-max-saved-items 200)
(setq recentf-save-file (expand-file-name "recentf" doom-cache-dir))
(recentf-mode 1)

;; company-mode
(after! company
  (setq company-idle-delay 0
        company-minimum-prefix-length 1
        company-selection-wrap-around t
        company-show-numbers t
        company-tooltip-align-annotations t
        company-tooltip-limit 10
        company-transformers '(delete-consecutive-dups))
  (company-tng-configure-default)
  (define-key company-active-map (kbd "TAB") 'company-select-next)
  (define-key company-active-map (kbd "<tab>") 'company-select-next)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
  (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
  (define-key company-active-map (kbd "RET") 'company-complete-selection)
  (define-key company-active-map (kbd "<return>") 'company-complete-selection))

;; lsp-mode
(after! lsp-mode
  (setq lsp-response-timeout 90000
        lsp-enable-symbol-highlighting nil
        lsp-headerline-breadcrumb-enable nil
        lsp-enable-file-watchers nil
        lsp-idle-delay 0.5
        lsp-file-watch-ignored-directories
        '("[/\\\\]\\.git$"
          "[/\\\\]node_modules$"
          "[/\\\\]dist$"
          "[/\\\\]build$"
          "[/\\\\]\\.venv$")))

;; projectile
(after! projectile
  (setq projectile-indexing-method 'alien)
  (dolist (dir '("node_modules" ".git" "dist" "build" "vendor" "coverage"))
    (add-to-list 'projectile-globally-ignored-directories dir)))

;; ivy
(after! ivy
  :config
  (setq enable-recursive-minibuffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (counsel-rg . ivy--regex-plus)
          (t . ivy--regex-ignore-order))) ;; fuzzy leve
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
                    (< x-recentf-index y-recentf-index)
                  (string< x y)))
            t)
        (if (file-directory-p y)
            nil
          (time-less-p y-mtime x-mtime)))))
  (add-to-list 'ivy-sort-functions-alist
               '(read-file-name-internal . eh-ivy-sort-file-function)))

;; ivy-bibtex
(after! ivy-bibtex
  (setq ivy-bibtex-default-action 'ivy-bibtex-insert-key))

(defun my/disable-heavy-features-in-large-files ()
  "Desativa LSP, Flycheck, Font-lock etc. em arquivos grandes (>2MB)."
  (when (> (buffer-size) (* 1024 1024 2))
    (message "Arquivo grande detectado: desativando LSP/Flycheck/font-lock.")
    (when (bound-and-true-p lsp-mode) (lsp-mode -1))
    (when (bound-and-true-p flycheck-mode) (flycheck-mode -1))
    (font-lock-mode -1)
    (setq-local truncate-lines t)))

(add-hook 'find-file-hook #'my/disable-heavy-features-in-large-files)

;; so-long-mode para arquivos com linhas longas
(global-so-long-mode 1)

(+global-word-wrap-mode +1)

;; gcmh para gerenciamento automático de GC
(use-package! gcmh
  :config
  (gcmh-mode 1))

(use-package! origami
  :hook (prog-mode . origami-mode)
  :config
  (map! :leader
        (:prefix ("c" . "code")
         :desc "Toggle fold" "f" #'origami-toggle-node
         :desc "Toggle all folds" "F" #'origami-toggle-all-nodes)))
