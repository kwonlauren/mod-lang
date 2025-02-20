%{ open Syntax %}

%token <int> NUM
%token ADD MULT SEQ OR
%token EOF LPAR RPAR

%left SEQ
%nonassoc OR

%start <expr> program

%%

program:
  | expr EOF { $1 }

expr:
  | NUM { Num $1 }
  | ADD NUM { Add $2 }
  | MULT NUM { Mult $2 }
  | expr SEQ expr { Seq ($1, $3) }
  | expr OR expr { Or ($1, $3) }
  | LPAR expr RPAR { $2 }