(defmodule install (export all))

(defun init-vars-table ()
  (ets:new 'shen_vars (list 'named_table)))

(defun init-functions-table ()
  (ets:new 'shen_functions (list 'named_table)))

(defun set-vars ()
  (primitives:set '*stinput* 'standard_io)
  (primitives:set '*stoutput* 'standard_io)
  (primitives:set '*sterror* 'standard_error)
  (primitives:set '*language* "LFE")
  (primitives:set '*port* 0.1)
  (primitives:set '*porters* "Matus Kmit"))

(defun init ()
  (init-vars-table)
  (init-functions-table)
  (set-vars)
  (io:format "~p~n" (list (primitives:cons? ()))))
