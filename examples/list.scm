(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(list-dialog '((title "Choose the Bugs You Wish to View")
               (column "Bug Number")
               (column "Severity")
               (column "Description")
               992383 "Normal" "GtkTreeView crashes on multiple selections"
               293823 "High" "GNOME Dictionary does not handle proxy"
               393823 "Critical" "Menu editing does not work in GNOME 2.0"))
