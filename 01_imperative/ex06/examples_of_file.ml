(* idiomatic code *)
(* let parse_line2 line = 
  let rec aux l (acc: float list) : float list * string = 
    match l with
    | [] -> (acc, "")
    | head :: [] -> (acc, head)
    | head :: tail -> (
      match float_of_string_opt head with
      | None -> aux tail acc
      | Some n -> aux tail (n :: acc)
    );
  in
  
  aux (String.split_on_char ',' line) []


let examples_of_file2 path = 
  let file = open_in path in

  let rec aux acc = 
    try
      let (nums, str) = parse_line2 (input_line file) in
      aux ((nums, str) :: acc)
    with
    | End_of_file -> (
      close_in file;
      acc
    )
  in

  aux [] *)

(* terrible code, but I can't use recursion here *)
let parse_line (str: string) =
  let res = ref [||] in
  let curr = ref "" in
  let i = ref 0 in

  try
    while true do
      let ch = String.get str !i in
      if ch = ',' then
        (match float_of_string_opt !curr with
        | None -> curr := "";
        | Some n -> (
          curr := "";
          res := Array.append !res [|n|];
        )
        )
      else
        curr := !curr ^ String.make 1 ch;
      
      incr i;
    done;
  with
  | Invalid_argument s -> ();

  (!res, !curr)

let examples_of_file path = 
  let file = open_in path in
  let l = ref [] in

  try
    while true do
      let line = input_line file in
      let (nums, str) = parse_line line in
      l := (nums, str) :: !l
    done;
  with
  | End_of_file -> close_in file;

  !l

let () = 
  let argv = Sys.argv in
  let l = examples_of_file argv.(1) in
  
  List.iter (fun (nums, str) ->
    Array.iter (fun x -> Printf.printf "%f, " x) nums;
    print_endline str;
  ) l;