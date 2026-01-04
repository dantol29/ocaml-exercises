let () = 
  let p = new People.people "Greg" in
  print_endline p#to_string;
  p#talk;
  p#die