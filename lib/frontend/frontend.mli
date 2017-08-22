
module Syntax : module type of Syntax

val parse_file : string -> Syntax.Program.t

