let rec iter f l = 
  match l with
  | [] -> ()
  | head :: tail -> (
    f head;
    iter f tail
  )

let () = 
 let all = Color.all in
 iter (fun x -> print_endline (Color.toStringVerbose x)) all
