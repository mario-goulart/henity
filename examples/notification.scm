(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(notification-dialog '((window-icon "info")
                       (text "There are system updates necessary!")))

(notification-dialog '(listen)
                     writer: (lambda ()
                               (print "message: hey")))
