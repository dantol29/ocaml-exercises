let ft_countdown (number : int) : unit =
  let rec aux number =
    if number >= 0 then begin
      print_int number;
      print_char '\n';
      aux (number - 1)
    end
  in

  if number > 0 then aux number
  else aux 0

let () = 
  ft_countdown (5);
  ft_countdown (0);
  ft_countdown (-5);