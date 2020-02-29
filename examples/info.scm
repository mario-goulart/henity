(cond-expand
 (chicken-4 (use henity))
 (chicken-5 (import henity))
 (else (error "Unsupported CHICKEN version.")))

(info-dialog '((text "Merge complete. Updated 3 of 10 files.")))
