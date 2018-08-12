;; locale coding
(setq locale-coding-system'utf-8)
(prefer-coding-system'utf-8)
(set-keyboard-coding-system'utf-8)
(set-terminal-coding-system'utf-8)
(set-selection-coding-system'utf-8)
(set-clipboard-coding-system 'ctext)
(set-buffer-file-coding-system 'utf-8)

(let ((default-directory "~/.emacs.d/lisp/"))
    (normal-top-level-add-to-load-path '("."))
     (normal-top-level-add-subdirs-to-load-path))

;; (global-set-key  (kbd "C-x l") 'windmove-left)
;; (global-set-key  (kbd "C-x r") 'windmove-right)
;; (global-set-key  (kbd "C-x p") 'windmove-up)
;; (global-set-key  (kbd "C-x d") 'windmove-down)

;;(require 'php-mode)

;;buffser list and complate
(require 'ido)
(ido-mode t)

(load-file "~/.emacs.d/lisp/vespa-style.el")
(require 'vespa-style)
(add-hook 'c-mode-common-hook 'vespa-c-mode-hook)

(load-file "~/.emacs.d/lisp/index-engine-tools.el")
(require 'index-engine-tools)

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;;close bell
(setq visible-bell t)

;;not insert tab
(setq-default indent-tabs-mode nil)

(require 'linum+)
(global-linum-mode 0)
(global-set-key (kbd "C-x C-l") 'linum-mode)
;;(setq linum-format "%d| ")

;;show column number
(column-number-mode t)

;; hide menu bar
;;(menu-bar-mode nil)

;; high light
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;transient-mark-mode
(setq transient-mark-mode t)

;;turn on highlighting current line
;;(global-hl-line-mode 1)

;; for buffer
(global-set-key (kbd "M-n") 'next-buffer)
(global-set-key (kbd "M-p") 'previous-buffer)

;; not generate ~ temp file
(setq make-backup-files nil)

;; ****for compile
(global-set-key (kbd "C-x C-m") 'compile)
(setq compile-command "scons -u . -j32 mode=debug")

;;compilation settings
(defun my-compile()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers t)
  (switch-to-buffer-other-window "*compilation*")
  (compile compile-command))

;;compilation settings
(defun my-compile2()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers t)
  ;;(switch-to-buffer-other-window "*compilation*")
  (compile compile-command))

(defun refresh-buffer()
  "revert buffer without comfirmation"
  (interactive) (revert-buffer t t)
)

(global-set-key [f5] 'refresh-buffer)
(global-set-key [f6] 'my-compile)
(global-set-key [f7] 'eshell)
(global-set-key [f8] 'rename-buffer)

;;for auto-complete
(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
;;(ac-set-trigger-key "TAB")
;;(setq ac-auto-start nil)
;;(setq ac-auto-show-menu nil)

;; for c mode dev
(setq c-basic-offset 4)
(defun wcy-c-open-other-file ()
  "if current file is a header file, then open the
   corresponding source file or vice versa.
  "
    (interactive)
    (let ((f (buffer-file-name))
          (headers '("h" "hpp" "hxx"))
          (sources '("c" "cxx" "cpp" "cc")))
      (if f
          (let* ((b (file-name-sans-extension f))
                 (x (file-name-extension f))
                 (s (cond
                     ((member x headers) sources)
                     ((member x sources) headers)
                     (t nil)))
                 (return-value nil))
            (while s
              (let ((try-file (concat b "." (car s))))
                (cond
                 ((find-buffer-visiting try-file)
                  (switch-to-buffer (find-buffer-visiting
                                     try-file))
                  (setq s nil
                        return-value t))
                 ((file-readable-p try-file)
                  (find-file try-file)
                  (setq s nil
                        return-value t))
                 (t (setq s (cdr s))))))
            return-value))))

(global-set-key (kbd "C-x t") 'wcy-c-open-other-file)

(require 'view-mode-settings)

;; **不要menu-bar和tool-bar
;; (unless window-system
;;   (menu-bar-mode -1))
(menu-bar-mode -1)
;; GUI下显示toolbar的话select-buffer会出问题
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

(global-set-key (kbd "C-x %") 'match-paren)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t (self-insert-command (or arg 1)))))
;; end [] match

;;comment and uncomment-region
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)

;;split window then undo then undo...
(winner-mode 1)
(global-set-key (kbd "C-c j") 'winner-undo)
(global-set-key (kbd "C-c k") 'winner-redo)

(defun move-cursor-next-pane ()
  "Move cursor to the next pane."
  (interactive)
  (other-window 1))

(defun move-cursor-previous-pane ()
  "Move cursor to the previous pane."
  (interactive)
  (other-window -1))
(global-set-key (kbd "C-c p") 'move-cursor-previous-pane)

;; C-x C-o, 空行区域操作，区域保留一行空行

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode)) 
(add-to-list 'auto-mode-alist '("\\.hpp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.[Cc][uUcC]$" . c++-mode))