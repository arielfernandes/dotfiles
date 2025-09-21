(doom! :completion
       (company
        +auto +tng)
       (ivy +fuzzy)

       :ui
       deft
       doom
       doom-quit
       hl-todo
       indent-guides
       ;; modeline
       nav-flash
       ophints
       doom-dashboard
       (popup
        +all
        +defaults)
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces
       zen
       (treemacs +lsp)

       :editor
       (evil +everywhere)
       file-templates
       (format +onsave)
       rotate-text
       snippets
       word-wrap

       :emacs
       (undo +tree)
       dired
       electric
       ibuffer
       vc

       :term
       eshell
       vterm

       :checkers
       spell
       grammar
       syntax

       :tools
       debugger
       (docker +lsp)
       editorconfig
       (eval +overlay)
       (lookup
        +docsets +dictionary)
       (lsp)
       (magit +forge)
       make
       biblio
       terraform
       direnv
       (delimiters +rainbow)

       :lang
       (cc +lsp)
       (yaml +lsp)
       data
       emacs-lisp
       (go +lsp)
       latex
       markdown
       (org
        +roam2
        +hugo
        +journal
        +gnuplot
        +pancoc
        +dragndrop
        +journal)
       plantuml
       (python +pyenv +lsp +pyright)
       rest
       (rust +eglot)
       (sh +lsp)
       (javascript +lsp)
       (ledger)
       (php +lsp)
       ;;(nix)
       ;;(java +lsp +tree-sitter)

       :email
       (notmuch +org)

       :app
       (rss +org)
       ;; irc

       :config
       (default +bindings +smartparens))
