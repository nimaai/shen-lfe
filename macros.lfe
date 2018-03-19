(defmodule macros (export all))

(defmacro shen-defun (name params body)
 `(ets:insert 'shen_functions
              (tuple ',name (lambda ,params ,body))))

(defmacro shen-funcall
  ([name] `(funcall (fun-value ',name)))
  ((cons name args) `(funcall (fun-value ',name) ,@args)))
