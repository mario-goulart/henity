(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(error-dialog '((text "Could not find /var/log/syslog.")))
