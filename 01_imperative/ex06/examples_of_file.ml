let parse_line line = 
  let rec aux l (acc: float array) : float array * string = 
    match l with
    | [] -> (acc, "")
    | head :: [] -> (acc, head)
    | head :: tail -> (
      match float_of_string_opt head with
      | None -> aux tail acc
      | Some n -> aux tail (Array.append acc [|n|])
    );
  in
  
  aux (String.split_on_char ',' line) [||]


let examples_of_file path = 
  let file = open_in path in

  let rec aux acc = 
    try
      let (nums, str) = parse_line (input_line file) in
      aux ((nums, str) :: acc)
    with
    | End_of_file -> (
      close_in file;
      acc
    )
  in

  List.rev (aux [])

let () = 
  let argv = Sys.argv in
  let l = examples_of_file argv.(1) in
  
  List.iter (fun (nums, str) ->
    Array.iter (fun x -> Printf.printf "%f, " x) nums;
    print_endline str;
  ) l;