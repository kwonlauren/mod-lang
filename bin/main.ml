open! Core
open Mod_lang

let () =
  (* let pp = ref false in *)
  let src = ref "" in
  let sem_modulo = ref 100 in
  let anal_modulo = ref 100 in
  let obfs_modulo = ref 100 in
  let _ =
    Arg.parse
      [
        (* ("-pp", Arg.Set pp, "Pretty print the Program"); *)
        ("-sem", Arg.Set_int sem_modulo, "Set modulo for semantics");
        ("-anal", Arg.Set_int anal_modulo, "Set modulo for analysis");
        ("-obfs", Arg.Set_int obfs_modulo, "Set modulo for obfuscation");
      ]
      (fun s -> src := s)
      "Usage: dune exec mod_lang -- [-pp] [-mod num] <source file>"
  in
  let lexbuf =
    Lexing.from_channel
      (if String.equal !src "" then Stdlib.stdin else Stdlib.open_in !src)
  in
  let pgm = Parser.program Lexer.read_token lexbuf in
  let analysis = Mod_analysis.analysis !anal_modulo pgm in
  let obfs_pgm = Obfuscator.obfuscate !obfs_modulo pgm in
  let obfs_analysis = Mod_analysis.analysis !anal_modulo obfs_pgm in
  print_endline "============= Input Program =============";
  print_endline (Syntax.string_of_expr pgm);
  Printf.printf "============= mod %d Result =============\n" !sem_modulo;
  print_endline (string_of_int (Mod_interp.run pgm mod !sem_modulo));
  Printf.printf "========= mod %d Analysis Result =========\n" !anal_modulo;
  print_endline (Mod_analysis.string_of_analysis_result analysis);
  Printf.printf "======== Obfuscated Program by %d ========\n" !obfs_modulo;
  print_endline (Syntax.string_of_expr obfs_pgm);
  Printf.printf "============= mod %d Result =============\n" !sem_modulo;
  print_endline (string_of_int (Mod_interp.run obfs_pgm mod !sem_modulo));
  Printf.printf "======== mod %d Analysis Result ========\n" !anal_modulo;
  print_endline (Mod_analysis.string_of_analysis_result obfs_analysis)
