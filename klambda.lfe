(defmodule klambda
  (export (cons? 1) (simple-error 1) (set 2) (value 1))
  (natives if and or cons hd tl))

(defun natives ()
  (element 2 (lists:keyfind 'natives 1 (module_info 'attributes))))

(defun fun-value (name)
  (element 2 (hd (ets:lookup 'shen_functions name))))

(defun set (x y)
  (ets:insert 'shen_vars (tuple x y)))

(defun value (x)
  (element 2 (hd (ets:lookup 'shen_vars x))))

(defun simple-error (s)
  (error s))

; (defun trap-error (e f))

(defun cons?
  ((()) 'false)
  ((x) (is_list x)))

; (defun debug-macro ()
;   (: lfe_io format '"~p~n" (list (kl-defun square (x) (* x x)))))
