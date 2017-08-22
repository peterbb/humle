
{
    open Lexing
    open Parser
}

let newline = '\n' | '\r' | "\r\n"
let whitespace = [ ' ' '\t' ]


rule read = parse
    | whitespace+       { read lexbuf }
    | newline           { new_line lexbuf; read lexbuf }
    | "(*"              { comment lexbuf; read lexbuf }
    | eof               { EOF }

    | "datatype"        { DATATYPE }
    | "="               { EQUAL }
    | "|"               { BAR }
    
    | ['a'-'z' 'A'-'Z']+ as name
                        { NAME name }

and comment = parse
    | "*)"              { () }
    | newline           { new_line lexbuf; comment lexbuf }
    | _                 { comment lexbuf }
    | eof               { failwith "eof inside comment" }

