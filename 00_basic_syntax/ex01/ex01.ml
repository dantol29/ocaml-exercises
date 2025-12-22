let rec ft_countdown (number : int) : unit =
  if number >= 0 then begin
    print_int number;
    print_char '\n';
    ft_countdown (number - 1)
  end

let () = 
  ft_countdown (5);
  ft_countdown (0);
  ft_countdown (-5);