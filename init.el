;;; init.el

;; ========== INITIAL SETUP ========== ;;

;; Turn off mouse interface early in startup to avoid momentary display

;; (when window-system ...)
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))

;; Add user's .emacs.d directory to the load-path
(let
    ((user-emacs-dir
      (file-name-directory (or load-file-name (buffer-file-name)))))
  (add-to-list 'load-path user-emacs-dir))

;; Load theme as soon as possible
(load "themes/zenburn-theme")

;; ;; Fonts (commented out here, because they are set in .Xresources
;; (set-default-font "Terminus-9")
;; (setq default-frame-alist '((font . "Terminus-9")))


;; ========== ELPA PACKAGES ========== ;;

;; --- Set up ELPA package repositories ---
(setq package-archives
      '(("original"    . "http://tromey.com/elpa/")
        ("gnu"         . "http://elpa.gnu.org/packages/")
        ("marmalade"   . "http://marmalade-repo.org/packages/")
        ("technomancy" . "http://repo.technomancy.us/emacs/")
        ("melpa"       . "http://melpa.milkbox.net/packages/")
        ))
(package-initialize)

(defun package-install-needed (packages)
  "Install needed packages unless already installed."
  (dolist
      (package packages)
    (unless (package-installed-p package)
      (package-install package)))
  )

(package-install-needed '(yaml-mode lua-mode))


;; ========== EDITOR CUSTOMIZATIONS ========== ;;

(setq column-number-mode t)
(setq scroll-preserve-screen-position t)

(setq truncate-partial-width-windows nil)
(setq toggle-text-mode-auto-fill nil)
(setq fill-column 80)

;; Enable upcase-region (C-x C-u) and downcase-region (C-x C-l).
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; --- Typing special characters ---
;; € :: AltGr + Shift + 2
(defun insert-euro ()
  "Insert a Euro currency symbol in UTF-8."
  (interactive)
  (ucs-insert #x20ac))
(global-set-key (kbd "⅛") 'insert-euro)
;; £ :: AltGr + Shift + 3
;; ° :: AltGr + Shift + 0

;; --- Moving between windows. ---
;; The following shortcuts conflict with org-mode.
;; (global-set-key [C-tab] 'other-window)
;; (global-set-key [M-left] 'windmove-left)
;; (global-set-key [M-right] 'windmove-right)
;; (global-set-key [M-up] 'windmove-up)
;; (global-set-key [M-down] 'windmove-down)

;; ========== EXTENSIONS ========== ;;

;; --- Helm ---
(package-install-needed '(helm))
(global-set-key (kbd "C-c h") 'helm-mini)
;; (helm-mode 1)


;; ========== EXTERNAL DEPENDENCIES ========== ;;

;; --- Web Browser. ---
;; (setq browse-url-browser-function 'browse-url-firefox)
;; (setq browse-url-browser-function 'browse-default-macosx-browser)
;; (setq browse-url-browser-function 'browse-default-windows-browser)
;; (setq browse-url-browser-function 'browse-default-kde)
;; (setq browse-url-browser-function 'browse-default-epiphany)
;; (setq browse-url-browser-function 'browse-default-w3m)
;; Call external script: ~/bin/browser $url
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "browser")


;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

;; remember this directory
(setq starter-kit-dir
      (file-name-directory (or load-file-name (buffer-file-name))))

;; load up the starter kit
(org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))

;;; init.el ends here
