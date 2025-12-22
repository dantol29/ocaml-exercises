let ft_power (number, power) : int =
  let rec aux (acc, power) : int =
    if power > 1 then aux (number * acc, power - 1) 
    else acc
  in

  aux (number, power)

let () =
  print_int (ft_power (5, 2));
  print_newline ();
  print_int (ft_power (3, 3));
  print_newline ();
  print_int (ft_power (1, 0));
  print_newline ();
  print_int (ft_power (0, 1));
  print_newline ()