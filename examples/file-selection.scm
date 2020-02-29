(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(let ((file (file-selection-dialog '((title "Select a file")))))
  (if file
      (print "\"" file "\" selected.")
      (print "No file selected.")))
