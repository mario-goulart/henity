(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(let ((friend (forms-dialog `((title "Add Friend")
                              (text "Enter information about your friend.")
                              (separator ",")
                              (add-entry "First Name")
                              (add-entry "Family Name")
                              (add-entry "Email")
                              (add-calendar "Birthday")))))
  (if friend
      (begin
        (with-output-to-file "addr.sexp"
          (lambda ()
            (write friend)))
        (print "Friend added."))
      (print "No friend added.")))
