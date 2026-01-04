let () = 
  let p = new People.people "Greg" in
  let p2 = new People.people "Henry" in
  let d = new Doctor.doctor "Smith" 42 p in
  let e = new Dalek.dalek in

  let army_p = new Army.army [p; p; p] in
  print_endline "Army 1";
  List.iter (fun x -> print_endline x#to_string) army_p#get_members;
  print_newline ();

  let army_p2 = army_p#delete in
  print_endline "Army 2";
  List.iter (fun x -> print_endline x#to_string) army_p2#get_members;
  print_newline ();

  let army_p3 = army_p2#delete in
  print_endline "Army 3";
  List.iter (fun x -> print_endline x#to_string) army_p3#get_members;
  print_newline ();

  let army_p4 = army_p3#delete in
  print_endline "Army 4";
  List.iter (fun x -> print_endline x#to_string) army_p4#get_members;
  print_newline ();

  let army_p5 = army_p4#add p2 in
  print_endline "Army 5";
  List.iter (fun x -> print_endline x#to_string) army_p5#get_members;
  print_newline ();

  let army_d = new Army.army [d; d; d] in
  print_endline "Doctors 1";
  List.iter (fun x -> print_endline x#to_string) army_d#get_members;
  print_newline ();

  let army_e = new Army.army [e; e; e] in
  print_endline "Enemies 1";
  List.iter (fun x -> print_endline x#to_string) army_e#get_members