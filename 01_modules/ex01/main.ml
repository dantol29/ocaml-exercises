let rec iter f l = 
  match l with
  | [] -> ()
  | head :: tail -> (
    f head;
    iter f tail
  )

let () = 
 let all = Value.all in
 iter (fun x -> print_endline (Value.toStringVerbose x)) all;
 iter (fun x -> print_int (Value.toInt x)) all;
 print_endline "";

 try 
  let a = Value.As in
  let n = Value.next a in
  print_endline (Value.toStringVerbose n);
 with
 | Invalid_argument s -> print_endline s;

 try 
  let a = Value.As in
  let n = Value.previous a in
  print_endline (Value.toStringVerbose n);

  let a = Value.T2 in
  let n = Value.previous a in
  print_endline (Value.toStringVerbose n);
 with
 | Invalid_argument s -> print_endline s