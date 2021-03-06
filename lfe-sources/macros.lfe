(defmodule macros
  (export-macro defun funcall freeze let trap-error))

(defmacro defun (name params body)
 `(ets:insert 'shen_functions
              (tuple ',name (lambda ,params ,body))))

(defmacro funcall
  ((list name) `(funcall (helpers:get-fun ',name)))
  ((cons name args) `(funcall (helpers:get-fun ',name) ,@args)))

(defmacro freeze (body)
  `(lambda () ,body))

(defmacro let (x y body)
  `(let ((x y)) ,body))

(defmacro trap-error (x f)
  `(try ,x (catch (e (funcall ,f e)))))
