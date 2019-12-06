;; Steps to install:
;;   0. Install Haskell tools:
;;       * ghc
;;       * cabal
;;       * stylish-haskell
;;       * fast-tags
;;       * hoogle
;;   1. Copy ~/.emacs up to ;; PACKAGES ;;
;;   2. Restart Emacs
;;   3. Install packages (M-x list-packages) and then (i to mark for installation and "x" to install all)
;;       * <color theme of choice>
;;       * company
;;       * company-ghci
;;       * evil
;;       * exec-path-from-shell
;;       * haskell-mode
;;       * rainbow-delimeters
;;       * smart-mode-line
;;       * smex
;;   4. Copy the rest of .emacs file
;;   5. Restart and enjoy!

;; disable package signature check (dirty hack to make it work)
(setq package-check-signature nil)

;; Configure MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
)
(package-initialize)

;; set default startup screen
(setq inhibit-startup-screen t)

;; disable toolbars and menus
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)

;; disable annoying beeping and blinking
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; set font
(set-default-font "Ubuntu Mono-14")

;; put all auto-save files in a separate directory
(setq backup-directory-alist '(("." . "~/.emacs_saves")))

;; save desktop session on quit
(desktop-save-mode 1)

;;;;;;;;;;;;;;
;; PACKAGES ;;
;;;;;;;;;;;;;;

;; set $PATH from user shell
(exec-path-from-shell-initialize)

;; ido (file navigation)
(require 'ido)
(ido-mode t)

;; smex (like ido but for commands)
(require 'smex)
(global-set-key (kbd "M-x") 'smex)

;; vim bindings
(require 'evil)
(evil-mode t)
(add-hook
    'evil-insert-state-exit-hook
    (lambda () (call-interactively #'save-buffer))
)

;; rainbow delimeters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; git diff highlight
(require 'diff-hl)
(global-diff-hl-mode t)

;; smart-mode-line
(setq sml/no-confirm-load-theme t)
(sml/setup)
(setq
    sml/theme 'dark
    sml/shorten-directory t
    sml/shorten-modes t
)

;;;;;;;;;;;;;
;; HASKELL ;;
;;;;;;;;;;;;;

(require 'haskell-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)  ;; enable interactive mode
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)  ;; spell checking in Haskell files
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)  ;; default template

;;; configure interactive mode
(setq
    haskell-process-type 'cabal-repl
    haskell-process-log t
    haskell-interactive-popup-errors nil
    haskell-process-auto-import-loaded-modules t
    haskell-process-suggest-remove-import-lines t
    haskell-process-suggest-hoogle-imports t
)

;;: formatting
(setq haskell-stylish-on-save t)

;;; haskell layout offsets
(setq
    haskell-indentation-ifte-offset 4
    haskell-indentation-layout-offset 4
    haskell-indentation-left-offset 4
    haskell-indentation-starter-offset 4
    haskell-indentation-where-post-offset 2
    haskell-indentation-where-pre-offset 2
)

;;; haskell hotkeys
(define-key haskell-mode-map (kbd "<f8>") 'haskell-navigate-imports)
(define-key haskell-mode-map (kbd "M-g") 'haskell-mode-tag-find)

;;; haskell autocompletion
(require 'company-ghci)
(push 'company-ghci company-backends)
(add-hook 'haskell-mode-hook 'company-mode)
(add-hook
    'haskell-mode-hook
    (lambda ()
        (set (make-local-variable 'company-backends)
             (append '((company-capf company-dabbrev-code)) company-backends)
	)
    )
)

;;; jump-to-definition with fast-tags
(setq
   haskell-tags-on-save t
   haskell-hasktags-path "~/.cabal/bin/fast-tags"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; V generated by emacs ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (naquadah)))
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "2eb1f5551310e99101f0f9426485ab73aa5386054da877aacd15d438382bb72e" default)))
 '(package-selected-packages
   (quote
    (smart-mode-line company company-ghci exec-path-from-shell diff-hl haskell-mode rainbow-delimiters evil naquadah-theme smex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; /\ generated by emacs /\ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; EDITOR AND COLOR SETTINGS

;; Set cursor color to white
(set-cursor-color "#ffffff")

;; higlight line
(require 'hl-line)
(global-hl-line-mode t)
(set-face-background 'hl-line "#444")

;; whitespace mode
(require 'whitespace)
(setq whitespace-line-column 120)  ;; higlight long lines
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(set-face-attribute 'whitespace-space nil :background nil)
(set-face-attribute 'whitespace-indentation nil :background nil)
(set-face-attribute 'whitespace-newline nil
    :background nil
    :foreground "gray30"
)
(setq whitespace-display-mappings
    '(
        (space-mark 32 [32])
        (newline-mark 10 [182 10])
        (tab-mark 9 [10148])
    )
)
