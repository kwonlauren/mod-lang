open! Core

type expr =
  | Num of int
  | Add of int
  | Mult of int
  | Seq of expr * expr
  | Or of expr * expr
[@@deriving sexp_of]

let string_of_expr pgm = sexp_of_expr pgm |> Sexp.to_string_hum
