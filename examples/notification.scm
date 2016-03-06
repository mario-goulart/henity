(use henity)

(notification-dialog '((window-icon "info")
                       (text "There are system updates necessary!")))

(notification-dialog '(listen)
                     writer: (lambda ()
                               (print "message: hey")))
