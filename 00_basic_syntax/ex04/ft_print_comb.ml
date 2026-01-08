let ft_print_comb () : unit =
  let rec aux num1 num2 num3 =
    if num1 > 7 then print_string "\n"
    else (
      if num3 != 2 then print_string ", ";
      print_int num1;
      print_int num2;
      print_int num3;
      
      if num2 = 8 then
        aux (num1 + 1) (num1 + 2) (num1 + 3)
      else if num3 = 9 then
        aux num1 (num2 + 1) (num2 + 2)
      else
        aux num1 num2 (num3 + 1)
    )
  in

  aux 0 1 2
let () = 
  ft_print_comb ()