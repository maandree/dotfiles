(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;(setq auto-mode-alist (cons '("\.haskell$" . haskell-mode) auto-mode-alist))
;(autoload 'haskell-mode "haskell-mode" "Haskell editing mode." t)

(setq auto-mode-alist (cons '("\.hs$" . haskell-mode) auto-mode-alist))
(autoload 'haskell-mode "haskell-mode" "Haskell editing mode." t)

(column-number-mode)
(display-time-mode)

