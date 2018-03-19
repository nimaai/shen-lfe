(set *kl-directory* "kl-sources/")
(set *lfe-directory* "lfe-sources/")

(set *kl-natives* [and cons hd if or tl])
(set *kl-primitives* [cons? eval-kl set simple-error value])

(define native? X -> (element? X (value *kl-natives*)))
(define primitive? X -> (element? X (value *kl-primitives*)))

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
         LfeCode (map-make-lfe-code [] KlCode)
         LfeString (list->string [(module File) | (skip-copyright LfeCode)])
         Write (write-to-file LfeFile LfeString)
      KlFile))

(define module File -> [defmodule (intern File) [import all from macros]])

(define skip-copyright
  [Copy | Rest] -> Rest where (string? Copy)
  X -> X)

(define list->string
  [] -> ""
  [X | Y] -> (@s (make-string "~R~%~%" X) (list->string Y)))

(define make-lfe-code
  Params [F | R] -> [F | (quote-free-symbols R Params)] where (native? F)
  _ [F | R] -> (let FString (str F)
                    FNew (intern (cn "klambda:" FString))
                    [FNew | (map-make-lfe-code [] R)])
            where (primitive? F)
  _ [cond | R] -> [cond | R]
  _ [defun N P B] -> [shen-defun N P (make-lfe-code [] B)]
  _ [lambda P B] -> [shen-lambda P (make-lfe-code [] B)]
  _ [F | R] -> [shen-funcall F | (map-make-lfe-code [] R)]
  _ Code -> Code)

(define quote-free-symbols
  [] _ -> []
  [X | Y] P -> [(quote-free-symbols X P) | (quote-free-symbols Y P)]
  X P -> (intern (cn "'" (str X))) where (not (element? X P)))

(define map-make-lfe-code P X -> (map ((function make-lfe-code) P) X))
