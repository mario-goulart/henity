(use henity)

(print (or (calendar-dialog
            '((title "Select a date")
              (text "Click on a date to select that date.")
              (day 10)
              (month 8)
              (year 2004)))
           "No date selected"))
