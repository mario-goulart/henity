(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(let ((value (scale-dialog '((text "Select window transparency.")
                             (value 50)))))
  (if value
      (print "You selected " value ".")
      (print "No value selected.")))
