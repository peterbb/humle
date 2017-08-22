

module Type = struct
    type t =
        | Atom of string
end

module DataType = struct
    type t = {
        name : string;
        constructors : (string * Type.t list) list
    }
end

module Decl = struct
    type t =
        | DataType of DataType.t
end

module Program = struct
    type t = Decl.t list
end

