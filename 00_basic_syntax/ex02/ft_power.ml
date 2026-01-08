let ft_power (number, power) : int =
  let rec aux (acc, power) : int =
    if power > 0 then aux (number * acc, power - 1) 
    else acc
  in

  aux (1, power)

let () =
  print_int (ft_power (5, 2));
  print_newline ();
  print_int (ft_power (3, 3));
  print_newline ();
  print_int (ft_power (3, 0));
  print_newline ();
  print_int (ft_power (0, 5));
  print_newline ()