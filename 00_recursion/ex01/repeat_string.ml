(* not tail-recursive *)
let rec repeat_string ?(str="") (n : int) : string =
  if n = - 1 then
    "Error"
  else if n = 0 then
    ""
  else if str = "" then
    "x" ^ repeat_string (n - 1)
  else 
    str ^ repeat_string ~str:str (n - 1)

let () = 
  print_endline (repeat_string (-1));
  print_endline (repeat_string (0));
  print_endline (repeat_string ~str:"Toto" (1));
  print_endline (repeat_string (2));
  print_endline (repeat_string ~str:"a" (5));
  print_endline (repeat_string ~str:"what" (3))
  