(defmodule install (export all))

(defun init-vars-table ()
  (ets:new 'shen_vars (list 'named_table)))

(defun init-functions-table ()
  (ets:new 'shen_functions (list 'named_table)))

(defun set-vars ()
  (klambda:set '*stinput* 'standard_io)
  (klambda:set '*stoutput* 'standard_io)
  (klambda:set '*sterror* 'standard_error)
  (klambda:set '*language* "LFE")
  (klambda:set '*port* 0.1)
  (klambda:set '*porters* "Matus Kmit"))

(defun start ()
  (init-vars-table)
  (init-functions-table)
  (set-vars))
