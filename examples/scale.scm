(use henity)

(let ((value (scale-dialog '((text "Select window transparency.")
                             (value 50)))))
  (if value
      (print "You selected " value ".")
      (print "No value selected.")))
