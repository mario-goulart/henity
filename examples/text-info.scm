(use henity)

(with-output-to-file "COPYING"
  (lambda ()
    (print "This is the legalese.")))

(print (if (text-info-dialog '((title="License")
                               (filename "COPYING")
                               (checkbox "I read and accept the terms.")))
           "Start installation!"
           "Stop installation!"))
