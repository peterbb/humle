
exception Duplicate of string

type t = string

module Set = struct
    include Set.Make(String)

end

module Map = struct
    include Map.Make(String)

    let add_unique name value map =
        if mem name map then
            raise (Duplicate name)
        else
            add name value map

    let dom map =
        bindings map |> List.map fst |> Set.of_list
end
