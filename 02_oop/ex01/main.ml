let () = 
  let p = new People.people "Greg" in
  let d = new Doctor.doctor "Smith" 42 p in
  print_endline d#to_string;
  d#talk;
  d#use_sonic_screwdriver;
  
  let d2 = d#travel_in_time 2025 2035 in
  print_endline d2#to_string