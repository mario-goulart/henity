(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(print (or (entry-dialog '((title "Add new profile")
                           (text "Enter name of new profile:")
                           (entry-text "NewProfile")))
           "No name entered"))
