(set *kl-directory* "kl-sources/")
(set *lfe-directory* "lfe-sources/")

(define compile-kl ->
  (do
    (output "klambda directory: ~S~%" (value *kl-directory*))
    (output "lfe directory ~S~%" (value *lfe-directory*))
    (output "~%")
    (map
      (function compile-kl-file)
      ["core"
       \*
       "declarations"
       "load"
       "macros"
       "prolog"
       "reader"
       "sequent"
       "sys"
       "dict"
       "t-star"
       "toplevel"
       "track"
       "types"
       "writer"
       "yacc"
       *\
       ])
    (output "~%")
    (output "compilation complete.~%")
    ()))

(define compile-kl-file
  File ->
    (let _ (output "compiling ~A~%" File)
         KlFile (make-string "~A~A.kl" (value *kl-directory*) File)
         LfeFile (make-string "~A~A.lfe" (value *lfe-directory*) File)
         KlCode (read-file KlFile)
         LfeCode (map (function make-lfe-code) KlCode)
         LfeString (list->string [[defmodule (intern File)] | (skip-copyright LfeCode)])
         Write (write-to-file LfeFile LfeString)
      KlFile))

(define skip-copyright
  [Copy | Rest] -> Rest where (string? Copy)
  X -> X)

(define list->string
  [] -> ""
  [X | Y] -> (@s (make-string "~R~%~%" X) (list->string Y)))

(define make-lfe-code
  [defun | R] -> [kl-defun | R]
  Code -> Code)
