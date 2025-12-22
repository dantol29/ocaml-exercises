let rec tak (x: int) (y: int) (z: int) : int = 
  if y < x then
    let t1 = tak (x - 1) y z in
    let t2 = tak (y - 1) z x in
    let t3 = tak (z - 1) x y in
    tak t1 t2 t3
  else
    z

let () = 
    print_int (tak 1 2 3);
    print_newline ();
    
    print_int (tak 5 23 7);
    print_newline ();
    
    print_int (tak 9 1 0);
    print_newline ();
    
    print_int (tak 1 1 1);
    print_newline ();

    print_int (tak 0 42 0);
    print_newline ();

    print_int (tak 23498 98734 98776);
    print_newline ();