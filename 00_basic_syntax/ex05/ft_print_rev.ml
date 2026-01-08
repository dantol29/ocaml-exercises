let ft_print_rev (str : string) : unit =
  let rec aux i = 
    if i >= 0 then begin
      print_char (String.get str i);
      aux (i - 1)
    end
  in

  aux (String.length str - 1);
  print_char '\n'

let () =
  ft_print_rev ("Hello world !");
  ft_print_rev ("")


