let fibonacci (n : int) : int =
  if n < 0 then -1
  else if n <= 1 then n
  else 
    let rec aux (i, prev, acc) =
      if i >= n then acc
      else aux (i + 1, acc, prev + acc)
    in
    aux (2, 1, 1)

let () = 
    print_int (fibonacci (-42));
    print_newline ();
    
    print_int (fibonacci 1);
    print_newline ();
    
    print_int (fibonacci 3);
    print_newline ();
    
    print_int (fibonacci 6);
    print_newline ();

    print_int (fibonacci 42);
    print_newline ();