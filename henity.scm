(module henity

( ;; exports
 entry-dialog
 calendar-dialog
 error-dialog
 info-dialog
 question-dialog
 warning-dialog
 file-selection-dialog
 progress-dialog
 text-info-dialog
 scale-dialog
 color-selection-dialog
 password-dialog
 forms-dialog
 list-dialog
 notification-dialog
 henity-debug
)

(import scheme)
(cond-expand
 (chicken-4
  (import chicken)
  (use data-structures extras files ports posix srfi-1 utils)
  (define file-executable? file-execute-access?))
 (chicken-5
  (import (chicken base)
          (chicken condition)
          (chicken file)
          (chicken io)
          (chicken pathname)
          (chicken port)
          (chicken process)
          (chicken process-context)
          (chicken string))
  (import srfi-1))
 (else
  (error "Unsupported CHICKEN version.")))

(define program-available?
  (let ((paths (string-split (get-environment-variable "PATH") ":")))
    (lambda (program)
      (let loop ((paths paths))
        (if (null? paths)
            #f
            (let ((path (car paths)))
              (let ((program-path (make-pathname path program)))
                (if (and (file-exists? program-path)
                         (file-executable? program-path))
                    program-path
                    (loop (cdr paths))))))))))

(define henity-debug (make-parameter #f))

(define run-zenity
  (let ((zenity-program #f))
    (lambda (widget args bool? numeric? env writer)
      (unless zenity-program
        (let ((zenity (program-available? "zenity")))
          (if zenity
              (set! zenity-program zenity)
              (error 'run-zenity "Could not find zenity."))))
      (let* ((dialog (conc widget "-dialog"))
             (cmd-line-args (options->cmd-line-args dialog args))
             (separator (let loop ((args args))
                          (and (not (null? args))
                               (let ((arg (car args)))
                                 (if (and (pair? arg) (eq? (car arg) 'separator))
                                     (cadr arg)
                                     (loop (cdr args)))))))
             (widget-option (string-append "--" (symbol->string widget))))
        (when (henity-debug)
          ((henity-debug)
           (string-intersperse
            (cons zenity-program (cons widget-option cmd-line-args)))))
        (let-values (((in out pid err)
                      (process* zenity-program
                                (cons widget-option cmd-line-args)
                                env)))
          (if writer
              (and
               (handle-exceptions exn
                 #f
                 (with-output-to-port out writer)
                 (close-output-port out)
                 #t)
               (let-values (((_ exited-normally? status)
                             (process-wait pid)))
                 (if exited-normally?
                     (case status
                       ((0) #t)
                       ((255) (error 'run-zenity dialog
                                     (with-input-from-port err read-string)))
                       (else #f))
                     (error 'run-zenity dialog "killed by" status))))
              (let ((out (with-input-from-port in read-string)))
                (when (eof-object? out)
                  (set! out ""))
                (let-values (((_ exited-normally? status) (process-wait pid)))
                  (if exited-normally?
                      (case status
                        ((0) (cond (bool?
                                    #t)
                                   (numeric?
                                    (and out (string->number
                                              (string-chomp out "\n"))))
                                   (else
                                    (if separator
                                        (string-split (string-chomp out "\n")
                                                      separator)
                                        (string-chomp out "\n")))))
                        ((255) (error 'run-zenity dialog
                                      (with-input-from-port err read-string)))
                        (else #f))
                      (error 'run-zenity dialog "killed by" status))))))))))

(define (options->cmd-line-args caller options)
  (let loop ((options options))
    (if (null? options)
        '()
        (let ((option (car options)))
          (cons
           (cond ((pair? option)
                  (conc "--" (car option) "=" (cadr option)))
                 ((symbol? option)
                  (conc "--" option))
                 ((string? option)
                  option)
                 ((number? option)
                  (number->string option))
                 (else (error caller (conc "Unsupported value: " option))))
           (loop (cdr options)))))))

(define (make-zenity widget #!key bool? numeric?)
  (lambda (args #!key writer env)
    (run-zenity widget args bool? numeric? env writer)))

(define entry-dialog           (make-zenity 'entry))
(define calendar-dialog        (make-zenity 'calendar))
(define error-dialog           (make-zenity 'error))
(define info-dialog            (make-zenity 'info))
(define question-dialog        (make-zenity 'question bool?: #t))
(define warning-dialog         (make-zenity 'warning))
(define file-selection-dialog  (make-zenity 'file-selection))
(define progress-dialog        (make-zenity 'progress))
(define text-info-dialog       (make-zenity 'text-info))
(define scale-dialog           (make-zenity 'scale numeric?: #t))
(define color-selection-dialog (make-zenity 'color-selection))
(define password-dialog        (make-zenity 'password))
(define forms-dialog           (make-zenity 'forms))
(define list-dialog            (make-zenity 'list))
(define notification-dialog    (make-zenity 'notification))

) ;; end module
