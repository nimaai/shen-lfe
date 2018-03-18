(set *klambda-directory* "klambda/")
(set *klambda-lfe-directory* "klambda-lfe/")

(define compile-kl ->
  (do
    (output "klambda directory: ~S~%" (value *klambda-directory*))
    (output "klambda-lfe directory ~S~%" (value *klambda-lfe-directory*))
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
         KlFile (make-string "~A~A.kl" (value *klambda-directory*) File)
         LfeFile (make-string "~A~A.lfe" (value *klambda-lfe-directory*) File)
         KlCode (read-file KlFile)
         \* KlCode (map (function make-kl-code) ShenCode) *\
         KlString (list->string [[defmodule (intern File)] | KlCode])
         Write (write-to-file LfeFile KlString)
      KlFile))

(define list->string
  [] -> ""
  [X | Y] -> (@s (make-string "~R~%~%" X) (list->string Y)))

\*
(define make-kl-code
  [define F | Rules] -> (shen.elim-def [define F | Rules])
  [defcc F | Rules] -> (shen.elim-def [defcc F | Rules])
  Code -> Code)
*\
