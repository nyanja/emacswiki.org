;;; org-readme.el --- Integrates Readme.org and Commentary/Change-logs.
;; 
;; Filename: org-readme.el
;; Description: Integrate Readme.org and Commentary/Change Logs.
;; Author: Matthew L. Fidler
;; Maintainer: Matthew L. Fidler
;; Created: Fri Aug  3 22:33:41 2012 (-0500)
;; Version: 0.7
;; Package-Requires: ((http-post-simple "1.0") (yaoddmuse "0.1.1")(header2 "21.0") (lib-requires "21.0"))
;; Last-Updated: Sat Aug 11 01:02:40 2012 (-0500)
;;           By: Matthew L. Fidler
;;     Update #: 459
;; URL: https://github.com/mlf176f2/org-readme
;; Keywords: Header2, Readme.org, Emacswiki, Git
;; Compatibility: Tested with Emacs 24.1 on Windows.
;;
;; Features that might be required by this library:
;;
;;   None
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; * Using org-readme
;; Org readme is used to:
;; 
;; - Create/Update a "History" section in the Readme.org based on the changelog
;;   section of the Emacs Log.
;; - Create/Update a "Library Information" Section Based on the Emacs lisp header.
;; - Create/Update a "Possible Dependencies" Section Based on the Emacs
;;   lisp header.
;; 
;; All other sections of the Readme.org are then put into the
;; "Commentary" section of the readme.org.
;; 
;; In addition this library defines `org-readme-sync',  a convenience function that:
;; 
;; - Asks for a commentary about the library change.
;; - Syncs the Readme.org with the lisp file as described above.
;; - Updates emacswiki with the library description and the library
;;   itself.
;; - Updates Marmalade-repo if the library version is different than the
;;   version in the server.
;; - Updates the git repository with the differences that you posted.
;; 
;; When `org-readme-sync' is called in a `Readme.org' file that is not a
;; single lisp file, the function exports the readme in EmacsWiki format
;; and posts it to the EmacsWiki.
;; ** EmacsWiki Page Names
;; When exporting the Readme.org to EmacsWiki, the names are transformed
;; as follows:
;; 
;; - When the library is a single lisp function, the single lisp file is
;;   converted to the emacswiki name by taking out the "-" and ".el" of
;;   the library and converting to Camel Case.  For example,
;;   org-readme.el would be converted to OrgReadme.
;; - When the library is a multiple file lisp library, or a library
;;   without any direct lisp calls, the Readme.org is converted to an
;;   appropriate EmacsWiki documentation file by the Parent Directory of
;;   the `Readme.org'.  For example, =EmacsPortable.App" is converted to
;;   EmacsPortableApp
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 01:02:04 2012 (-0500) #457 (Matthew L. Fidler)
;;    Added better Package-Requires tag.
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:58:56 2012 (-0500) #454 (Matthew L. Fidler)
;;    Made request for minor revision earlier, and fixed bug.
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:57:29 2012 (-0500) #451 (Matthew L. Fidler)
;;    Fixed code typo
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:56:12 2012 (-0500) #449 (Matthew L. Fidler)
;;    Bug fix for deleting a section of a Readme.org file.
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:55:37 2012 (-0500) #447 (Matthew L. Fidler)
;;    Testing bug.
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:55:30 2012 (-0500) #446 (Matthew L. Fidler)
;;    Minor bug fix.
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:53:32 2012 (-0500) #444 (Matthew L. Fidler)
;;    Bug fix for comment sync, now Readme.org =file= is translated to lisp
;;    `file'.  Additionally, asks for version bump.
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:44:17 2012 (-0500) #434 (Matthew L. Fidler)
;;    Bug fix for syncing readme.  Now the returns should not be as prevalent.
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:39:23 2012 (-0500) #430 (Matthew L. Fidler)
;;    Attempting to post to marmlade again...
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:35:40 2012 (-0500) #426 (Matthew L. Fidler)
;;    Attempting to fix org-readme-marmalade-post.
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:26:36 2012 (-0500) #420 (Matthew L. Fidler)
;;    Bug fix to upload to emacswiki and upload to marmalade-repo
;; 11-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug 11 00:21:27 2012 (-0500) #413 (Matthew L. Fidler)
;;    Added marmalade-repo support.  Now org-readme should upload to
;;    marmalade-repo when the version is different from the latest version.  
;; 08-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Wed Aug  8 18:44:37 2012 (-0500) #343 (Matthew L. Fidler)
;;    Fixed preformatting tags in emacswiki post.  Previously they may have
;;    been replaced with <PRE></pre> instead of <pre></pre>.  This makes the
;;    emacswiki page display correctly.
;; 07-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Tue Aug  7 19:22:53 2012 (-0500) #333 (Matthew L. Fidler)
;;    To use, put (require 'ess-smart-underscore) in your ~/.emacs file
;; 7-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Tue Aug  7 19:14:34 2012 (-0500) #331 (Matthew L. Fidler)
;;    Added a Comment to EmcsWiki pages that states that the content of the
;;    page will likely be overwitten since it is automatically generated by `org-readme'
;; 7-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Mon Aug  6 23:42:02 2012 (-0500) #328 (Matthew L. Fidler)
;;    Added more documentation.
;; 06-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Mon Aug  6 23:24:22 2012 (-0500) #326 (Matthew L. Fidler)
;;    Added support for uploading Readme.org files to emacswiki without
;;    having to have a single associated lisp file.
;; 06-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Mon Aug  6 20:44:55 2012 (-0500) #282 (Matthew L. Fidler)
;;    Bug fix for syncing from the single lisp file.
;; 06-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Mon Aug  6 20:12:50 2012 (-0500) #274 (Matthew L. Fidler)
;;    Added the ability to call `org-readme-sync' from Readme.org
;; 05-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sun Aug  5 12:30:26 2012 (-0500) #250 (Matthew L. Fidler)
;;    Added git pushing to org-readme
;; 05-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sun Aug  5 12:21:53 2012 (-0500) #237 (Matthew L. Fidler)
;;    Added git support as well as a comment mode.  The only thing that
;;    should need to be called is `org-readme-sync'
;; 04-Aug-2012    Matthew L. Fidler  
;;    Last-Updated: Sat Aug  4 21:40:14 2012 (-0500) #122 (Matthew L. Fidler)
;;    Added syncing with emacswiki. 
;; 04-Aug-2012    Matthew L. Fidler
;;    Last-Updated: Sat Aug  4 00:02:49 2012 (-0500) #20 (Matthew L. Fidler)
;;    Initial Release
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

(require 'yaoddmuse)
(require 'http-post-simple)

(defgroup org-readme nil
  "Org-readme is a way to create Readme.org files based on an elisp file.")

(defcustom org-readme-marmalade-server "http://marmalade-repo.org" 
  "Marmalade server website.  This should start with http: and should notend with a trailing forward slash, just like the default value of http://marmalade-repo.org"
  :type 'string
  :group 'org-readme)

(defcustom org-readme-marmalade-token nil
  "Marmalade token to upload content to the marmalade server."
  :type 'string
  :group 'org-readme)

(defcustom org-readme-marmalade-user-name nil
  "Marmalade user name to upload content to the marmalade server."
  :type 'string
  :group 'org-readme)

(defun org-readme-buffer-version ()
  "Gets the version of the current buffer."
  (let (ver
        (case-fold-search t))
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward "^ *;+ *Version: *\\(.*?\\) *" nil t)
        (setq ver (match-string 1))))
    (symbol-value 'ver)))

(defun org-readme-marmalade-post ()
  "Posts the current buffer to Marmalade."
  (interactive)
  (let* ((package (file-name-sans-extension
                   (file-name-nondirectory (buffer-file-name))))
         (m-ver (org-readme-marmalade-version package))
         (b-ver (org-readme-buffer-version))
         token
         resp)
    (message "Marmalade %s Version: %s, Buffer Version: %s"
             package m-ver b-ver)
    (when (or (not m-ver) (not (string= m-ver b-ver)))
      (message "Should post %s, the marmalade package is outdated or does not exist."
               package)
      (setq token (org-readme-token))
      
      (setq resp (http-post-simple-multipart
                  (format "%s/v1/packages"
                          org-readme-marmalade-server)
                  `((name . ,org-readme-marmalade-user-name)
                    (token . ,token))
                  `(("package" ,(buffer-file-name)
                     "text/x-script.elisp"
                     ,(buffer-string)))))
      (message "%s" resp))))

(defun org-readme-marmalade-version (package)
  "Gets the marmalade version of the PACKAGE." 
  (let ((ver-json (url-retrieve-synchronously
                   (format "%s/v1/packages/%s/latest"
                           org-readme-marmalade-server
                           package)))
        ver)
    (when ver-json
      (save-excursion
        (set-buffer ver-json)
        (goto-char (point-min))
        (when (re-search-forward "\"version\"[ \t]*:[ \t]*\"\\(.*?\\)\"" nil t)
          (setq ver (match-string 1)))
        (kill-buffer (current-buffer))))
    (symbol-value 'ver)))

(defun org-readme-token ()
  "Gets marmalade-token, if not already saved."
  (or org-readme-marmalade-token
      (let ((user-name (or org-readme-marmalade-user-name
                           (read-string "Marmalade username: ")))
            (password (read-passwd "Marmalade password: "))
            token)
        (setq token
              (with-temp-buffer
                (insert
                 (format "%s"
                         (nth 0
                              (http-post-simple
                               (format "%s/v1/users/login"
                                       org-readme-marmalade-server)
                               `((name . ,user-name)
                                 (password . ,password))))))
                (goto-char (point-min))
                
                (if (not (re-search-forward "\"token\"[ \t]*:[ \t]*\"\\(.*?\\)\"" nil t))
                    nil
                  (match-string 1))))
        (when token
          (setq org-readme-marmalade-user-name user-name)
          (setq org-readme-marmalade-token token)
          (customize-save-variable 'org-readme-marmalade-user-name org-readme-marmalade-user-name)
          (customize-save-variable 'org-readme-marmalade-token org-readme-marmalade-token))
        (symbol-value 'token))))

(defcustom org-readme-remove-sections '("History" "Possible Dependencies" "Library Information")
  "List of sections to remove when changing the Readme.org to Change-log."
  :group 'org-readme
  :type '(repeat (string :tag "Section")))

(defvar org-readme-edit-mode-map nil
  "Keymap for editing change-logs.")

(unless org-readme-edit-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-c") 'org-readme-edit-commit)
    (define-key map (kbd "C-x C-s") 'org-readme-edit-commit)
    (define-key map (kbd "C-c C-k") 'org-readme-edit-cancel)
    (setq org-readme-edit-mode-map map)))

(defun org-readme-edit-commit ()
  "Changelog for editing."
  (interactive)
  (let ((comment (buffer-substring (point-min) (point-max)))
        mr)                             
    (kill-buffer (get-buffer "*Change Comment*"))
    (with-temp-buffer
      (insert comment)
      (goto-char (point-min))
      (end-of-line)
      (while (re-search-forward "^" nil t)
        (insert ";;    "))
      (setq mr (buffer-substring (point-min) (point-max))))
    (set-buffer org-readme-edit-last-buffer)
    (make-revision)
    (insert mr)
    (save-buffer)
    (with-temp-file (org-readme-get-change)
      (insert comment))
    (org-readme-sync t)))

(defun org-readme-edit-cancel ()
  "Cancel the edit log."
  (interactive)
  (kill-buffer (get-buffer "*Change Comment*"))
  (when org-readme-edit-last-window-configuration
    (set-window-configuration org-readme-edit-last-window-configuration)))

(defvar org-readme-edit-last-window-configuration nil)

(defvar org-readme-edit-last-buffer nil)

(defun org-readme-edit ()
  "Edit change comment for commit."
  (interactive)
  (unless org-readme-edit-last-window-configuration
    (setq org-readme-edit-last-window-configuration (current-window-configuration)))
  (switch-to-buffer-other-window (get-buffer-create "*Change Comment*"))
  (org-readme-edit-mode))

(define-derived-mode org-readme-edit-mode text-mode "Org-readme Log edit.")

(defalias 'org-readme-sync-emacswiki 'org-readme-convert-to-emacswiki)

(defun org-readme-convert-to-emacswiki ()
  "Converts Readme.org to oddmuse markup and uploads to emacswiki."
  (interactive)
  (let ((readme (org-readme-find-readme))
        (what (file-name-nondirectory (buffer-file-name)))
        (wiki (org-readme-get-emacswiki-name))
        tmp tmp2)                       
    (with-temp-buffer
      (insert-file-contents readme)
      
      ;; Take out CamelCase Links
      (goto-char (point-min))
      (let ((case-fold-search nil))
        (while (re-search-forward "\\([A-Z][a-z]+[A-Z][A-Za-z]*\\)" nil t)
          (replace-match (format "!%s" (match-string 1)) t t)))
      
      ;; Convert Tables.
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]*|[-+]+|[ \t]*\n" nil t)
        (replace-match ""))
      
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]*|" nil t)
        (replace-match "||")
        (while (re-search-forward "|" (point-at-eol) t)
          (replace-match "||")))
      
      ;; Convert Links
      (goto-char (point-min))
      (while (re-search-forward "\\[\\[\\(\\(?:https?\\|ftp\\).*?\\)\\]\\[!?\\(.*?\\)\\]\\]" nil t)
        (replace-match "[\\1 \\2]" t))
      
      
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]*[A-Z]+:[ \t]*\\[[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}.*" nil t)
        (replace-match ""))
      
      (goto-char (point-min))
      (while (re-search-forward "\\[\\[file:\\(.*?[.]el\\)\\]\\[\\1\\]\\]" nil t)
        (replace-match "[[\\1]]"))
      
      (goto-char (point-min))
      (while (re-search-forward "\\[\\[\\(.*?\\)\\]\\[\\(.*?\\)\\]\\]" nil t)
        (replace-match "\\2"))
      
      (goto-char (point-min))
      (while (re-search-forward "=\\(.*?\\)=" nil t)
        (replace-match (format "<tt>%s</tt>" (match-string 1)) t t))
      
      (goto-char (point-min))
      (while (re-search-forward "^\\([*]+\\) *!?\\(.*\\)" nil t)
        (setq tmp (make-string (min 4 (+ 1 (length (match-string 1)))) ?=))
        (replace-match (format "%s %s %s" tmp (match-string 2) tmp) t t)
        (beginning-of-line)
        (let ((case-fold-search nil))
          (while (re-search-forward "!\\([A-Z][a-z]+[A-Z][A-Za-z]*\\)" (point-at-eol) t)
            (replace-match "\\1" t))))
      
      (goto-char (point-min))
      (while (re-search-forward "^: " nil t)
        (replace-match "<pre>\n::::" t t) ;
        (while (progn
                 (end-of-line)
                 (re-search-forward "\\=\n: " nil t))
          (replace-match "\n:::: "))
        (end-of-line)
        (insert "\n</pre>"))
      
      (goto-char (point-min))
      (while (re-search-forward "^ *#[+]BEGIN_SRC emacs-lisp *.*" nil t)
        (replace-match "{{{")
        (setq tmp (point))
        (when (re-search-forward "^ *#[+]END_SRC" nil t)
          (replace-match "}}}")
          (beginning-of-line)
          (setq tmp2 (point))
          (goto-char tmp)
          (while (and (> tmp2 (point))
                      (re-search-forward "^" tmp2 t))
            (replace-match "::::"))))
      
      (goto-char (point-min))
      (while (re-search-forward "^ *#[+]BEGIN_SRC.*" nil t)
        (replace-match "<pre>" t t)
        (setq tmp (point))
        (when (re-search-forward "^ *#[+]END_SRC" nil t)
          (replace-match "</pre>" t t)
          (beginning-of-line)
          (setq tmp2 (point))
          (goto-char tmp)
          (while (and (> tmp2 (point))
                      (re-search-forward "^" tmp2 t))
            (replace-match "::::"))))
      
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]*[+-] +\\(.*?\\)::" nil t)
        (replace-match (format "* <b>%s</b> -- " (match-string 1))))
      
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]*[+-] +" nil t)
        (replace-match "* "))
      
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]*#.*" nil t) ;
        (replace-match ""))
      
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]*[0-9]+[.)] +" nil t)
        (replace-match "# "))
      
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]+" nil t)
        (replace-match ""))
      
      (goto-char (point-min))           
      (while (re-search-forward "^::::" nil t)
        (replace-match "")
        (let ((case-fold-search nil))
          (while (re-search-forward "!\\([A-Z][a-z]+[A-Z][A-Za-z]*\\)" (point-at-eol) t)
            (replace-match "\\1" t))))
      (goto-char (point-max))
      (insert "\n\nThis was generated with OrgReadme.  On updating the library, this page is likely to be replaced with updated content.")
      (setq readme (buffer-substring (point-min) (point-max))))
    (with-temp-file wiki
      (insert readme))
    (save-excursion
      (set-buffer (find-file-noselect wiki))
      (emacswiki-post nil "")
      (kill-buffer (current-buffer)))
    (delete-file wiki)))

(defun org-readme-git ()
  "Add The files to git."
  (interactive)
  (let* ((df (file-name-directory (buffer-file-name)))
         (default-directory df))
    (message "Git Adding Readme")
    (shell-command
     (format "git add %s"
             (file-name-nondirectory (org-readme-find-readme))))
    (message "Git Adding %s" (file-name-nondirectory (buffer-file-name)))
    (shell-command
     (format "git add %s"
             (file-name-nondirectory (buffer-file-name))))
    (when (file-exists-p (org-readme-get-change))
      (message "Git Committing")
      (shell-command
       (format "git commit -F %s"
               (file-name-nondirectory
                (org-readme-get-change))))
      (delete-file (org-readme-get-change))
      (message "Git push upstream")
      (shell-command "git push upstream"))))

(defun org-readme-in-readme-org-p ()
  "Determine if the currently open buffer is the Readme.org"
  (string= "readme.org"
           (downcase (file-name-nondirectory (buffer-file-name)))))

(defun org-readme-single-lisp-p ()
  "Determine if the Readme.org is in a directory with a single lisp file.
If so, return the name of that lisp file, otherwise return nil."
  (let* ((dn (file-name-directory (buffer-file-name)))
         (df (directory-files dn t "[.][Ee][Ll]$")))
    (if (= 1 (length df))
        (progn
          (setq df (nth 0 df))
          (symbol-value 'df))
      nil)))

;;;###autoload
(defun org-readme-sync (&optional comment-added)
  "Syncs Readme.org with current buffer.
When COMMENT-ADDED is non-nil, the comment has been added and the syncing should begin.
"
  (interactive)
  (if (and (not comment-added)
           (org-readme-in-readme-org-p))
      (let ((single-lisp-file (org-readme-single-lisp-p)))
        (message "In Readme.org")
        (if single-lisp-file
            (progn
              (setq org-readme-edit-last-window-configuration (current-window-configuration))
              (find-file single-lisp-file)
              (setq org-readme-edit-last-buffer (current-buffer))
              (org-readme-sync))
          ;; Multiple lisp files or no lisp files.
          (message "Posting Description to emacswiki")
          (org-readme-convert-to-emacswiki)))
    (if (not comment-added)
        (progn
          (setq org-readme-edit-last-buffer (current-buffer))
          (org-readme-edit))
      (when (yes-or-no-p "Is this a minor revision (upload to Marmalade)? ")
        (save-excursion
          (goto-char (point-min))
          (let ((case-fold-search t))
            (when (re-search-forward "^[ \t]*;+[ \t]*Version:" nil t)
              (end-of-line)
              (when (looking-back "\\([ .]\\)\\([0-9]+\\)[ \t]*")
                (replace-match (format "\\1%s"
                                       (+ 1 (string-to-number (match-string 2))))))))))
      
      (message "Adding Readme to Header Commentary")
      (org-readme-to-commentary)
      (message "Updating Changelog in current file.")
      (org-readme-changelog-to-readme)
      (org-readme-top-header-to-readme)
      (save-buffer)
      (message "Attempting to post to marmalade-repo.org")
      (org-readme-marmalade-post)
      (message "Posting lisp file to emacswiki")
      (emacswiki-post nil "")
      (when org-readme-edit-last-window-configuration
        (set-window-configuration org-readme-edit-last-window-configuration)
        (setq org-readme-edit-last-window-configuration nil))
      
      (org-readme-git)
      (message "Posting Description to emacswiki")
      (org-readme-convert-to-emacswiki))))

;;;###autoload
(defun org-readme-to-commentary ()
  "Change Readme.org to a Commentary section."
  (interactive)
  (let ((readme (org-readme-find-readme)) p1)
    (with-temp-buffer
      (insert-file-contents readme)
      (mapc
       (lambda(section)
         (org-readme-remove-section section))
       org-readme-remove-sections)
      
      (goto-char (point-min))
      (while (re-search-forward "=\\<\\(.*?\\)\\>=" nil t)
        (replace-match (format "`%s'" (match-string 1))))
      
      (goto-char (point-min))
      (while (re-search-forward "#.*" nil t)
        (replace-match ""))
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]*[A-Z]+:[ \t]*\\[[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}.*" nil t)
        (replace-match ""))
      (goto-char (point-min))
      (while (re-search-forward "^:" nil t)
        (replace-match ""))
      (goto-char (point-min))
      (while (org-readme-remove-section
              (regexp-opt
               (mapcar
                (lambda(x)
                  (nth 0 x))
                org-todo-keyword-faces)) nil t))
      (goto-char (point-min))
      (skip-chars-forward " \t\n")
      (delete-region (point-min) (point))
      (insert "\n")
      (goto-char (point-max))
      (skip-chars-backward " \t\n")
      (delete-region (point) (point-max))
      (insert "\n")
      (goto-char (point-min))
      (while (re-search-forward "^" nil t)
        (insert ";; "))
      (setq readme (buffer-substring (point-min) (point-max))))
    (goto-char (point-min))
    (when (re-search-forward "^;;;[ \t]*Commentary:[ \t]*$" nil t)
      (skip-chars-forward "\n")
      (setq pt (point))
      (when (re-search-forward "^;;;;+[ \t]*$" nil t)
        (goto-char (match-beginning 0))
        (skip-chars-backward "\n")
        (delete-region pt (point))
        (insert readme)))))

(defun org-readme-get-emacswiki-name ()
  "Gets emacswiki-style name based on buffer."
  (if (org-readme-in-readme-org-p)
      (let ((wiki (file-name-nondirectory (substring (file-name-directory (buffer-file-name)) 0 -1))))
        (with-temp-buffer
          (insert wiki)
          (goto-char (point-min))
          (when (looking-at ".")
            (replace-match (upcase (match-string 0))))
          (while (re-search-forward "[-._]\\(.\\)" nil t)
            (replace-match  (upcase (match-string 1))) t t)
          (setq wiki (buffer-substring (point-min) (point-max))))
        (symbol-value 'wiki))
    (let ((dir (file-name-directory (buffer-file-name)))
          (name (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
      (with-temp-buffer
        (insert (downcase name))
        (goto-char (point-min))
        (when (looking-at ".")
          (replace-match (upcase (match-string 0))))
        (while (re-search-forward "-\\(.\\)" nil t)
          (replace-match  (upcase (match-string 1))) t t)
        (setq name (concat dir (buffer-substring (point-min) (point-max)))))
      (symbol-value 'name))))

(defun org-readme-get-change ()
  "Get file for changelog commits."
  (expand-file-name "Changelog" (file-name-directory (buffer-file-name))))

(defcustom org-readme-default-template "
* Installation

To use without using a package manager:

 - Put the library in a directory in the emacs load path, like ~/.emacs.d
 - Add (require 'LIB-NAME) in your ~/.emacs file

This is in emacswiki, so this package can also be installed using el-get.

After installing el-get, Type M-x el-get-install LIB-NAME.
"
  "Default template for blank Readme.org Files. LIB-NAME is replaced with the library."
  :type 'string
  :group 'org-readme)

(defun org-readme-find-readme ()
  "Find the Readme.org."
  (let* ((dir (file-name-directory (buffer-file-name)))
         (df (directory-files dir t "^[Rr][Ee][Aa][Dd][Mm][Ee][.][Oo][Rr][Gg]$")))
    (if (= 1 (length df))
        (setq df (nth 0 df))
      (setq df (expand-file-name "Readme.org" dir))
      (let ((lib-name (file-name-sans-extension
                       (file-name-nondirectory (buffer-file-name)))))
        (with-temp-file df
          (insert org-readme-default-template)
          (goto-char (point-min))
          (while (re-search-forward "LIB-NAME" nil t)
            (replace-match lib-name t t)))))
    (symbol-value 'df)))

(defun org-readme-remove-section (section &optional txt any-level at-beginning)
  "Remove `org-mode' SECTION. Optionally insert TXT.
When ANY-LEVEL is non-nil, any level may be specified.
When AT-BEGINNING is non-nil, if the section is not found, insert it at the beginning."
  (let ((case-fold-search t)
        (mtch ""))
    (save-excursion
      (goto-char (point-min))
      (if (re-search-forward
           (format "^\\([*]%s\\) +%s"
                   (if any-level
                       "+" "")
                   section) nil t)
          (progn
            (setq mtch (match-string 1))
            (delete-region
             (save-excursion
               (goto-char (match-beginning 0))
               (skip-chars-backward " \t\n")
               (point))
             (if (re-search-forward (format "^%s +" (regexp-quote mtch)) nil t)
                 (progn
                   (- (match-beginning 0) 1))
               (point-max)))
            (when txt
              (beginning-of-line)
              (skip-chars-backward " \t\n")
              (skip-chars-forward "\n")
              (insert txt))
            t)
        (when txt
          (goto-char (if at-beginning
                         (point-min)
                       (point-max)))
          ;; Skip comments 
          (if at-beginning
              (while (re-search-forward "\\=[ \t]*#.*\n" nil t))
            (while (re-search-backward "\n[ \t]*#.*\\=" nil t)))
          (beginning-of-line)
          (insert txt))
        nil))))

;;;###autoload
(defun org-readme-top-header-to-readme ()
  "This puts the top header into the Readme.org file as Library Information"
  (interactive)
  (let ((top-header "")
        (readme (org-readme-find-readme)))
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward "^;;;;+[ \t]*$" nil t)
        (beginning-of-line)
        (setq top-header (buffer-substring (point-min) (point)))))
    (with-temp-buffer
      (insert top-header)
      (goto-char (point-min))
      (when (looking-at ";;; *\\(.*?\\) *--+ *\\(.*\\)")
        (replace-match " *\\1* --- \\2"))
      
      (goto-char (point-min))
      (while (re-search-forward "^ *;; ?" nil t)
        (replace-match ""))
      
      (goto-char (point-min))
      (when (re-search-forward "[Ff]ile[Nn]ame: *\\(.*\\) *$" nil t)
        (replace-match "Filename: [[file:\\1][\\1]]"))
      
      (goto-char (point-min))
      (while (re-search-forward "^\\(.*?\\):\\(.*?[A-Za-z0-9.].*\\)$" nil t)
        (replace-match " - \\1 ::\\2"))
      (goto-char (point-min))
      (insert "* Library Information\n")
      
      (goto-char (point-min))
      (when (re-search-forward "^[ \t]*Features that might be required by this library:[ \t]*$" nil t)
        (replace-match "* Possible Dependencies"))
      (setq top-header (buffer-substring (point-min) (point-max))))
    (with-temp-buffer
      (insert-file-contents readme)
      (org-readme-remove-section "Possible Dependencies")
      (org-readme-remove-section "Library Information" top-header nil t)
      (write-file readme))))

;;;###autoload
(defun org-readme-changelog-to-readme ()
  "This puts the emacs lisp change-log into the Readme.org file."
  (interactive)
  (when (buffer-file-name)
    (let ((readme (org-readme-find-readme))
          pt1 pt2 txt)
      (save-excursion
        (goto-char (point-min))         
        (when (re-search-forward "^[ \t]*;;; Change Log:[ \t]*$" nil t)
          (setq pt1 (point))
          (when (re-search-forward "^[ \t]*;;;;+[ \t]*$" nil t)
            (setq pt2 (match-beginning 0))
            (setq txt (buffer-substring pt1 pt2))
            (with-temp-buffer
              (insert txt)
              (goto-char (point-min))
              ;; Take out comments
              (while (re-search-forward "^[ \t]*;+ ?" nil t)
                (replace-match ""))
              (goto-char (point-min))
              (while (re-search-forward "^[ \t]*\\([0-9][0-9]-[A-Za-z][A-Za-z][A-Za-z]-[0-9][0-9][0-9][0-9]\\)[ \t]+\\(.*\\)\n.*\n\\(\\(?:\n\\|.\\)*?\\)\n[ \t]*\\([0-9][0-9]\\)" nil t)
                (replace-match
                 (format " - %s :: %s (%s)\n %s"
                         (match-string 1)
                         (save-match-data
                           (replace-regexp-in-string
                            "~~~~" "\n    + "
                            (replace-regexp-in-string
                             "  +" " "
                             (replace-regexp-in-string
                              "\n" " "
                              (replace-regexp-in-string
                               "\n[ \t]*[*-+] +" "~~~~" (match-string 3))))))
                         (save-match-data
                           (replace-regexp-in-string
                            "[ \t]*$" ""
                            (match-string 2))) (match-string 4)) t t)
                (beginning-of-line))
              (when (re-search-forward "\\([0-9][0-9]-[A-Za-z][A-Za-z][A-Za-z]-[0-9][0-9][0-9][0-9]\\)[ \t]+\\(.*\\)\n.*\n\\(\\(?:\n\\|.\\)*\\)" nil t)
                (replace-match
                 (format " - %s :: %s (%s)" 
                         (match-string 1)
                         (save-match-data
                           (replace-regexp-in-string
                            "~~~~" "\n    + "
                            (replace-regexp-in-string
                             "  +" " "
                             (replace-regexp-in-string
                              "\n" " "
                              (replace-regexp-in-string
                               "\n[ \t]*[*-+] +" "~~~~" (match-string 3))))))
                         (save-match-data
                           (replace-regexp-in-string
                            "[ \t]*$" ""
                            (match-string 2)))) t t))
              (goto-char (point-min))
              (while (re-search-forward "`\\(.*?\\)'" nil t)
                (replace-match "=\\1="))
              (goto-char (point-min))
              (insert "* History\n")
              (setq txt (buffer-substring (point-min) (point-max))))
            (with-temp-buffer
              (insert-file-contents readme)
              (org-readme-remove-section "History" txt)
              (write-file readme))))))))

(provide 'org-readme)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; org-readme.el ends here
