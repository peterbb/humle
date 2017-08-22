
module FS = Frontend.Syntax
module CS = Core.Syntax

let check_type state = function
    | FS.Type.Atom a -> CS.Type.Atom a

let add_data_type name constructors state =
    let state = CS.Program.add_data_type name state in
    let convert_types (con, tys) =
            con, List.map (check_type state) tys
    and convert_constructors cs (con, tys) =
            Name.Map.add_unique con tys cs
    in
    let constructors = List.map convert_types constructors
                       |> List.fold_left convert_constructors Name.Map.empty
    in
    CS.Program.add_constructors name constructors state


let update_state state =
    let open FS.Decl in
    function
    | DataType FS.DataType.{name; constructors} ->
        add_data_type name constructors state
        
let elaborate =
    let rec loop state = function
        | [] ->
            state
        | decl :: program ->
            loop (update_state state decl) program
    in loop CS.Program.empty


