(defmodule klambda
  (export (cons? 1) (error-to-string 1) (simple-error 1) (set 2) (value 1))
  (natives if and or cond cons hd tl))

(defun natives ()
  (element 2 (lists:keyfind 'natives 1 (module_info 'attributes))))

(defun set (x y)
  (ets:insert 'shen_vars (tuple x y)))

(defun value (x)
  (element 2 (hd (ets:lookup 'shen_vars x))))

(defun simple-error (s)
  (throw s))

(defun error-to-string (e)
  (funcall (match-lambda
             (((tuple 'throw message _)) message)
             ((_) (error "not an exception")))
           e))

(defun cons?
  ((()) 'false)
  ((x) (is_list x)))

; (defun debug-macro ()
;   (: lfe_io format '"~p~n" (list (kl-defun square (x) (* x x)))))
