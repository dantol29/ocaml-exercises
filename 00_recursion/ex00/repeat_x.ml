(* not tail-recursive *)
let rec repeat_x (n : int) : string = 
  if n = 0 then
    ""
  else if n = - 1 then
    "Error"
  else 
    "x" ^ repeat_x(n - 1)

let () = 
    print_endline (repeat_x (-1));
    print_endline (repeat_x 0);
    print_endline (repeat_x 1);
    print_endline (repeat_x 2);
    print_endline (repeat_x 5);