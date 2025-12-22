let gray n = 
  let rec aux count acc = 
    if count < n then
      let l1 = List.map (fun x -> "1" ^ x) acc in
      let l2 = List.map (fun x ->  "0" ^ x) acc in
      aux (count + 1) (l2 @ List.rev (l1))
    else begin
      List.iter (fun x -> Printf.printf "%s " x) acc;
      print_newline ();
    end in
  
  if n > 0 then
    aux 1 ["0"; "1"]


let () = 
  gray 0;
  gray 1;
  gray 2;
  gray 3;
  gray 4;