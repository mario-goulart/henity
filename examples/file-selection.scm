(use henity)

(let ((file (file-selection-dialog '((title "Select a file")))))
  (if file
      (print "\"" file "\" selected.")
      (print "No file selected.")))
