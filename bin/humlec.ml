

let main = function
    | [_; filename] ->
        let p = Frontend.parse_file filename in
        let _p = Elaborate.elaborate p in
        Printf.printf "done.\n";
        exit 0
    | prog :: _ ->
        Printf.printf "usage: %s <filename>\n" prog;
        exit 1
    | [] ->
        Printf.printf "usage: fabamlc <filename>\n";
        exit 1

let () = main (Sys.argv |> Array.to_list)
