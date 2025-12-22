(* @ and Lists modules not allowed :( *)
let gray n = 
  let rec print_list l = 
    match l with
    | [] -> print_newline ()
    | head :: tail -> (
      print_string head;
      print_string " ";
      print_list tail
    )
  in

  let rec modify_list l str acc = 
    match l with
    | [] -> acc
    | head :: tail -> modify_list tail str ((str ^ head) :: acc)
  in

  let rec combine_lists l1 l2 = 
    match l2 with
    | [] -> l1
    | head :: tail -> combine_lists (head :: l1) tail
  in

  let rec aux count acc = 
    if count < n then
      let l1 = modify_list acc "1" [] in
      let l2 = modify_list acc "0" [] in
      aux (count + 1) (combine_lists l1 l2)
    else
      print_list acc;
    in
  
  if n > 0 then
    aux 1 ["0"; "1"]

let () = 
  gray 0;
  gray 1;
  gray 2;
  gray 3;
  gray 4;