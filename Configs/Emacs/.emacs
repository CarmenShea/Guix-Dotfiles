;; Emacs configuration ideas sourced from David Wills @SystemCrafters, Gavin Freeborn, Andrew Tropin.
;; Syntax was derived from looking at the code samples from the above sources.
;; Lines 7 through 18 are auto generated by emacs Custom UI configuration tools.
;; Carmen Shea's Emacs config.


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit beframe avy doom-modeline emojify org-gcal org-roam exwm-modeline x86-lookup desktop-environment)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight regular :height 143 :width normal)))))

;; test load of doom-modeline
;;(use-package doom-modeline
;;  :ensure t)
;;(doom-modeline-mode 1)

;; set some emacs gui features -------------------------------------------------
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar
;;(transwin-ask 0)
(tab-bar-mode)
;; add MELPA to the archives ---------------------------------------------------
(require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/") t)

;; setup mastodon.el -----------------------------------------------------------
(add-to-list 'load-path "/home/carmen/common-lisp/mastodon.el/lisp")
    (require 'mastodon)

;; Logging in to your instance
(setq mastodon-instance-url "https://mastodon.cloud"
      mastodon-active-user "@CarmenShea")

;; Adding Async mode
(require 'mastodon-async)


;; Adding Discover
;;(require 'mastodon-discover)
;;(with-eval-after-load 'mastodon (mastodon-discover))

;; Basic UI Configuration ------------------------------------------------------

;; Adjust this font size for your system
(defvar runemacs/default-font-size 143)

;; Disable line numbers for the following modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(column-number-mode)
(global-display-line-numbers-mode t)

;; Themeing Emacs -------------------------------------------------------------
;; Guix Packages that need to be loaded from the Guix Package Repository
;; "emacs-doom-themes"
;; "emacs-spacegray-theme"

(use-package spacegray-theme :defer t)
(use-package doom-themes :defer t)
  (load-theme 'doom-palenight t)
  (doom-themes-visual-bell-config)

;; Font Configuration ----------------------------------------------------------

(set-face-attribute 'default nil :font "Fira Code Retina" :height runemacs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 143)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 177 :weight 'regular)
;; Set up Magit ----------------------------------------------------------------
(use-package magit
  :ensure t)
;; Set up Org Roam -------------------------------------------------------------
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/RoamNotes")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-setup))

;; Set Org Agenda directory
(setq org-agenda-files '("~/RoamNotes" "~/RoamNotes/daily"))

;; Use Org-gcal ----------------------------------------------------------------
;; (use-package org-gcal)

;; Initialize Helm
(helm-mode 1)
;; Set Helm frame mode
(setq helm-display-function #'helm-display-buffer-in-own-frame)

;; Inherit the face of `doom-modeline-panel` for better appearance -------------
(set-face-attribute 'tab-bar-tab nil :inherit 'doom-modeline-panel :foreground nil :background nil)

;; Totally customize the format of the tab bar name
(defun my/tab-bar-format (tab i)
  (propertize
   (format
    (concat
      (if (eq (car tab) 'current-tab)
          "> " "< ")
      "%s")
    (alist-get 'name tab))
   'face (list (append
                  '(:foreground "#bbccdd")
                  (if (eq (car tab) 'current-tab)
		      '(:foreground "#000000" :background "#ffa000" :box t)
                      '())))))

;; Replace the default tab bar function
(setq tab-bar-tab-name-format-function #'my/tab-bar-format)

(defun my/tab-bar-tab-name-function ()
  (let ((project (project-current)))
    (if project
        (project-root project)
        (tab-bar-tab-name-current))))

(setq tab-bar-tab-name-function #'my/tab-bar-tab-name-function)
;; Test Line
;; Test 2nd line
;; Only show the tab bar if there are 2 or more tabs
(setq tab-bar-show 0)

(defun my/tab-bar-string () "")

;; Customize the tab bar format to add the global mode line string
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator tab-bar-format-align-centre tab-bar-format-global))

(add-to-list 'global-mode-string "")

;; Make sure mode line text in the tab bar can be read
(set-face-attribute 'tab-bar nil :foreground "#FFFFFF")

(defun my/project-create-tab ()
  (interactive)
  (tab-bar-new-tab)
  (magit-status))

(setq project-switch-commands #'my/project-create-tab)

(defun my/switch-to-tab-buffer ()
  (interactive)
  (if (project-current)
      (call-interactively #'project-switch-to-buffer)
    (call-interactively #'switch-to-buffer)))

(global-set-key (kbd "C-x b") #'my/switch-to-tab-buffer)

;; Turn on tab bar mode after startup
;; (tab-bar-mode 1)
(doom-modeline-mode 1)
;; Save the desktop session
(desktop-save-mode 1)

;; set transparency
;;  (set-frame-parameter (selected-frame) 'alpha '(90 90))
;;  (add-to-list 'default-frame-alist '(alpha 90 90))
;;  (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
;;  (add-to-list 'default-frame-alist '(fullscreen maximized))
