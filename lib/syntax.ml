open! Core

type expr =
  | Num of int
  | Add of int
  | Mult of int
  | Seq of expr * expr
  | Or of expr * expr
[@@deriving sexp_of]

let rec eval n = function
  | Num i -> i
  | Add i -> n + i
  | Mult i -> n * i
  | Seq (e1, e2) -> eval (eval n e1) e2
  | Or (e1, e2) -> if Random.bool () then eval n e1 else eval n e2

let run exp = eval 0 exp

let rec analysis m r = function
  | Num i -> Int.Set.singleton (i mod m)
  | Add i -> Int.Set.map r ~f:(fun x -> (x + i) mod m)
  | Mult i -> Int.Set.map r ~f:(fun x -> x * i mod m)
  | Seq (e1, e2) -> analysis m (analysis m r e1) e2
  | Or (e1, e2) -> Set.union (analysis m r e1) (analysis m r e2)

let mod_analysis m exp = analysis m (Int.Set.singleton 0) exp
