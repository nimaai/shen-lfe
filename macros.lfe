(defmodule macros (export all))

(defmacro defun (name params body)
 `(ets:insert 'shen_functions
              (tuple ',name (lambda ,params ,body))))

(defmacro funcall
  ([name] `(funcall (fun-value ',name)))
  ((cons name args) `(funcall (fun-value ',name) ,@args)))

(defmacro freeze (body)
  `(lambda () ,body))

(defmacro let (x y body)
  `(let ((x y)) ,body))
