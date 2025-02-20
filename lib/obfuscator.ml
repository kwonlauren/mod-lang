open Syntax

let rec obfuscate n = function
  | Num i -> Num i
  | Add i -> Add (i + n)
  | Mult i -> Mult i
  | Seq (e1, e2) -> Seq (obfuscate n e1, obfuscate n e2)
  | Or (e1, e2) -> Or (obfuscate n e1, obfuscate n e2)
