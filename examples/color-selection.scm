(use henity)

(let ((color (color-selection-dialog '(show-palette))))
  (if color
      (print "You selected " color ".")
      (print "No color selected.")))
