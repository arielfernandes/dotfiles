;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;

(setq doom-font (font-spec :family "Hack Nerd Font" :size 15))
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

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
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

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(setq treesit-language-source-alist
  '((typescript . ("https://github.com/tree-sitter/tree-sitter-typescript"
                    "master"
                    "typescript/src"))
     (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript"
              "master"
              "tsx/src"))))

(after! lsp-cmake
  (setq lsp-cmake-server-command
    (or (executable-find "cmake-language-server")
        (expand-file-name "~/.local/bin/cmake-language-server"))))

(after! lsp-clangd
  (add-to-list 'lsp-clients-clangd-args
    (concat "--query-driver="
      (expand-file-name "~/.espressif/tools/")
      "**/*-elf-*")))

;; --- Claude Code ---
(use-package! claude-code-ide
  :commands (claude-code-ide claude-code-ide-menu)
  :init
  (map! :leader
        (:prefix ("o c" . "Claude Code")
         :desc "Menu"               "c" #'claude-code-ide-menu
         :desc "Start/toggle"       "o" #'claude-code-ide
         :desc "Send prompt"        "p" #'claude-code-ide-send-prompt
         :desc "Resume session"     "r" #'claude-code-ide-resume))
  :config
  (setq claude-code-ide-cli-path (or (executable-find "claude")
                                      (expand-file-name "~/.local/bin/claude"))
        claude-code-ide-terminal-backend 'vterm
        claude-code-ide-use-ide-diff t)
  (claude-code-ide-emacs-tools-setup))

;; --- Debug TS/TSX (dape + js-debug) ---
;; Adapter lives in ~/.config/doom/debug-adapters/js-debug (install on each machine)
;; SPC d commands that dape does not autoload (gave "commandp" errors before it loaded)
(dolist (cmd '(dape-breakpoint-toggle dape-breakpoint-remove-all
               dape-breakpoint-log dape-breakpoint-expression dape-breakpoint-hits
               dape-info dape-repl dape-memory dape-disassemble
               dape-pause dape-continue dape-next dape-step-in dape-step-out
               dape-restart dape-select-thread dape-select-stack
               dape-stack-select-down dape-stack-select-up
               dape-evaluate-expression dape-watch-dwim
               dape-disconnect-quit dape-quit))
  (unless (fboundp cmd)
    (autoload cmd "dape" nil t)))

(after! dape
  (dolist (name '(js-debug-tsx js-debug-ts-node js-debug-node-attach js-debug-chrome))
    (when-let ((cfg (alist-get name dape-configs)))
      (plist-put cfg 'modes (append (plist-get cfg 'modes) '(tsx-ts-mode))))))
