%token <string> NAME
%token DATATYPE
%token EQUAL BAR
%token EOF

%{
    open Syntax
%}

%start <Syntax.Program.t> program
%%

program:
    | ds = list(decl); EOF
        { ds }

decl:
    | DATATYPE; name = NAME; EQUAL; constructors = list(constructor_def)
        { Decl.DataType DataType.{ name; constructors } }

constructor_def:
    | BAR; n = NAME; ts = list(typ)
        { n, ts }

typ:
    | n = NAME
        { Type.Atom n }


