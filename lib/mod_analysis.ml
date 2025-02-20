open Syntax
open! Core

type anlaysis_result = { results : Int.Set.t; modulo : int }

let rec anal m r = function
  | Num i -> Int.Set.singleton (i mod m)
  | Add i -> Int.Set.map r ~f:(fun x -> (x + i) mod m)
  | Mult i -> Int.Set.map r ~f:(fun x -> x * i mod m)
  | Seq (e1, e2) -> anal m (anal m r e1) e2
  | Or (e1, e2) -> Set.union (anal m r e1) (anal m r e2)

let analysis m exp = { results = anal m (Int.Set.singleton 0) exp; modulo = m }

let string_of_analysis_result { results; modulo } =
  Printf.sprintf "{%s}(%d)"
    (results |> Set.to_list |> List.map ~f:Int.to_string
   |> String.concat ~sep:", ")
    modulo
