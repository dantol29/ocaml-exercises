let () = 
  let p = new People.people "Greg" in
  let d = new Doctor.doctor "Smith" 42 p in
  let enemy = new Dalek.dalek in

  print_endline p#to_string;
  print_endline d#to_string;
  print_endline enemy#to_string;

  enemy#talk;
  enemy#exterminate p;

  d#use_sonic_screwdriver;
  enemy#die