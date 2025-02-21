open Syntax

let rec eval n = function
  | Num i -> i
  | Add i -> n + i
  | Mult i -> n * i
  | Seq (e1, e2) -> eval (eval n e1) e2
  | Or (e1, e2) -> if Random.bool () then eval n e1 else eval n e2

let run exp =
  Random.init 2025;
  eval 0 exp
