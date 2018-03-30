(defmodule helpers (export all))

(defun get-fun (name)
  (element 2 (hd (ets:lookup 'shen_functions name))))
