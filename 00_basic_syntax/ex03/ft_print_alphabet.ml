let ft_print_alphabet () : unit = 
  let rec aux (c : char) =
    if c <= 'z' then begin
      print_char c;
      aux (char_of_int (int_of_char c + 1))
    end
  in
  
  aux 'a';
  print_char '\n'

let () = 
  ft_print_alphabet ()