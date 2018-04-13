(defmodule absvector
  (behaviour gen_server)
  (export
    ;; gen_server implementation
    (new 1)
    ;; callback implementation
    (init 1)
    (handle_call 3)
    ;; server API
    (get 2)
    (put 3)))

;;; gen_server implementation

(defun new (size)
  (gen_server:start (MODULE) size '()))

;;; callback implementation

(defun init (size)
  `#(ok ,(array:new size)))

(defun handle_call
  (((tuple 'get index) _caller state)
    `#(reply ,(array:get index state) ,state))
  (((tuple 'put index value) _caller state)
   (let ((new-state (array:set index value state)))
     `#(reply ,new-state ,new-state))))

;;; our server API

(defun get (pid index)
  (gen_server:call pid `#(get ,index)))

(defun put (pid index value)
  (gen_server:call pid `#(put ,index ,value)))
