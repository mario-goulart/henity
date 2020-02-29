(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(let ((color (color-selection-dialog '(show-palette))))
  (if color
      (print "You selected " color ".")
      (print "No color selected.")))
