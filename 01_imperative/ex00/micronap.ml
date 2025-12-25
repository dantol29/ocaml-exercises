let my_sleep () = Unix.sleep 1

let sleep n = 
  for i = 0 to n - 1 do
    ignore (my_sleep ())
  done
  
let () = 
  try
    let argv = Sys.argv in
    let n = Array.get argv 1 in
    match int_of_string_opt n with
    | None -> ()
    | Some n -> (
      if n > 0 then
        sleep n
    )
  with
  | Invalid_argument msg -> ()

(* to compile *)
(* ocamlopt -I +unix unix.cmxa ex00/micronap.ml *)
