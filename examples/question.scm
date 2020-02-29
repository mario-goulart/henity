(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(print (question-dialog '((text "Are you sure you wish to proceed?"))))
