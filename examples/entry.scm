(use henity)

(print (or (entry-dialog '((title "Add new profile")
                           (text "Enter name of new profile:")
                           (entry-text "NewProfile")))
           "No name entered"))
