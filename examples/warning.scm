(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(warning-dialog
 '((text "Disconnect the power cable to avoid electrical shock.")))
