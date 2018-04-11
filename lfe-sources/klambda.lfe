(defmodule klambda
  (export (cons? 1)
          (error-to-string 1)
          (intern 1)
          (set 2)
          (simple-error 1)
          (value 1)
          (write-byte 2))
  (natives and
           cond
           cons
           hd
           if
           or
           tl))

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

(defun intern (s)
  (list_to_atom s))

(defun write-byte (b s)
  (io:fwrite s (binary b) [])
  b)

; (defun debug-macro ()
;   (: lfe_io format '"~p~n" (list (kl-defun square (x) (* x x)))))
