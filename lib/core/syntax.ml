
module Type = struct
    type t =
        | Atom of string

    let check types = function
        | Atom a ->
            if Name.Set.mem a types then
                ()
            else
                failwith "Type.check: unknown type"
    
end

module DataType = struct
    type t = {
        name : string;
        constructors : Type.t list Name.Map.t;
    }
end

module Program = struct
    type t = {
        datatype : DataType.t Name.Map.t;
        constructor : (Type.t list * Type.t) Name.Map.t;
    }

    let empty = {
        datatype = Name.Map.empty;
        constructor = Name.Map.empty;
    }

    let add_data_type name program =
        let info = DataType.{ name; constructors = Name.Map.empty } in
        let datatype = Name.Map.add_unique name info program.datatype in
        { program with datatype }

    let add_constructors name constructors
                         ({datatype; constructor} as program) =
        let info = Name.Map.find name datatype in
        let info = { info with constructors } in
        let datatype = Name.Map.add name info datatype in
        let constructor = Name.Map.fold
                (fun con tys constructor ->
                    List.iter (Type.check (Name.Map.dom datatype)) tys;
                    Name.Map.add_unique con (tys, Type.Atom name) constructor)
                constructors constructor in
        { program with datatype; constructor }
end

