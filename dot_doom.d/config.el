;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Informações do usuário (opcional, mas usadas por alguns pacotes)
(setq user-full-name "ariel fernandes"
      user-mail-address "0.arielfernandes.0@gmail.com")

;; Configuração de fontes e tema
(setq doom-font (font-spec :family "hack" :size 14))
(setq doom-theme 'doom-tomorrow-night)

;; Números de linha (t = absolutos, 'relative = relativos, nil = nenhum)
(setq display-line-numbers-type t)

;; Diretório padrão dos arquivos org
(setq org-directory "~/org/")

;; Exibir hora e bateria na modeline
(display-time-mode 1)
(display-battery-mode 1)

;; Iniciar maximizado
(toggle-frame-maximized)

;; Permitir variáveis locais em arquivos
(setq-default enable-local-variables t)

;; Estatísticas de TODOs com base em subtarefas, não apenas checkboxes
(setq org-hierarchical-todo-statistics nil)

;; Otimizações de performance para GC
(setq gc-cons-threshold 100000000)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold 800000)))

;; recentf para arquivos recentes (suporta sorting customizado no ivy)
(setq recentf-max-saved-items 200)
(setq recentf-save-file (expand-file-name "recentf" doom-cache-dir))
(recentf-mode 1)

;; Ajustes para company-mode (auto-complete)
(after! company
  ;; Mostrar sugestões imediatamente, sem delay
  (setq company-idle-delay 0
        company-minimum-prefix-length 1
        company-selection-wrap-around t
        company-show-numbers t)

  ;; Usar TAB para navegar e aceitar sugestões (igual VSCode)
  (define-key company-active-map (kbd "TAB") 'company-select-next)
  (define-key company-active-map (kbd "<tab>") 'company-select-next)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
  (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
  (define-key company-active-map (kbd "RET") 'company-complete-selection)
  (define-key company-active-map (kbd "<return>") 'company-complete-selection))

;; Ajustes para lsp-mode
(after! lsp-mode
  (setq lsp-response-timeout 90000)
  (setq lsp-file-watch-ignored-directories
        '("[/\\\\]\\.git$"
          "[/\\\\]node_modules$"
          "[/\\\\]dist$"
          "[/\\\\]build$"
          "[/\\\\]\\.venv$")))

;; Ignorar diretórios desnecessários no Projectile sem sobrescrever padrão
(after! projectile
  (dolist (dir '("node_modules" ".git" "dist" "build" "vendor" "coverage"))
    (add-to-list 'projectile-globally-ignored-directories dir)))

(after! ivy
  :config
  (setq enable-recursive-minibuffers t)
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

;; Ajustes para ivy-bibtex
(after! ivy-bibtex
  (setq ivy-bibtex-default-action 'ivy-bibtex-insert-key))
