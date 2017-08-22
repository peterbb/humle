
module Syntax = Syntax

let parse lexbuf =
    match Parser.program Lexer.read lexbuf with
    | program -> program

let with_open_file filename body =
    let ch = open_in filename in
    try body ch
    with e -> close_in ch; raise e

let parse_file filename =
    with_open_file filename begin fun ch ->
        let lexbuf = Lexing.from_channel ch in
        lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
        parse lexbuf
    end

