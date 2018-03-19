(defmodule klambda
  (export all)
  (natives if and or cons hd tl))

(defun natives ()
  (element 2 (lists:keyfind 'natives 1 (module_info 'attributes))))

; if : native
; and : native
; or : native

(defmacro kl-defun (name params body)
 `(ets:insert 'shen_functions
              (tuple ',name (lambda ,params ,body))))

(defun set (x y)
  (ets:insert 'shen_vars (tuple x y)))

(defun value (x)
  (element 2 (hd (ets:lookup 'shen_vars x))))

(defun simple-error (s)
  (error s))

; (defun trap-error (e f))

; cons : native
; hd : native
; tl : native
(defun cons?
  ((()) 'false)
  ((x) (is_list x)))

(defmacro eval-kl (expr)
  (eval (quote expr)))

(defun debug-macro ()
  (: lfe_io format '"~p~n" (list (kl-defun square (x) (* x x)))))
