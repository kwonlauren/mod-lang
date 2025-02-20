{open Parser}

let blank = [' ' '\t' '\n' '\r']+
let digit = ['0'-'9']
let number = '-'? digit+

rule read_token = parse
  | blank { read_token lexbuf }
  | number { NUM (int_of_string (Lexing.lexeme lexbuf)) }
  | "add" { ADD }
  | "mult" { MULT }
  | ";" { SEQ }
  | "or" { OR }
  | "(" { LPAR }
  | ")" { RPAR }
  | eof { EOF }
  | _ { failwith "unexpected character" }