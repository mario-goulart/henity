(use henity)

(let ((data (password-dialog '(password username))))
  (if data
      (let ((user/pwd (string-split data "|")))
        (if (null? user/pwd)
            (print "No data provided.")
            (begin
              (print "User Name: " (car user/pwd))
              (if (null? (cdr user/pwd))
                  (print "No password provided.")
                  (print "Password: " (string-intersperse (cdr user/pwd) "|"))))))
      (print "Stop login.")))
