open! Core
open Mod_lang

let () =
  let pp = ref false in
  let src = ref "" in
  let modulo = ref 100 in
  let _ =
    Arg.parse
      [
        ("-pp", Arg.Set pp, "Pretty print the Program");
        ("-mod", Arg.Set_int modulo, "Set modulo for analysis");
      ]
      (fun s -> src := s)
      "Usage: dune exec mod_lang -- [-pp] [-mod num] <source file>"
  in
  let lexbuf =
    Lexing.from_channel
      (if String.equal !src "" then Stdlib.stdin else Stdlib.open_in !src)
  in
  let pgm = Parser.program Lexer.read_token lexbuf in
  let _ =
    if !pp then (
      print_endline "======== Input Program ========";
      Syntax.sexp_of_expr pgm |> Sexp.to_string_hum |> print_endline;
      print_endline "")
  in

  Printf.printf "=========== Result ===========\n%d\n\n" (Syntax.run pgm);
  Printf.printf "======= Analysis Result =======\n";
  Syntax.mod_analysis !modulo pgm
  |> Set.to_list
  |> List.to_string ~f:Int.to_string
  |> print_endline;
  print_endline ""
