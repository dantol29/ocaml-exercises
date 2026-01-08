let ft_string_all (func : char -> bool) (str: string) : bool =
  let rec aux (i : int) : bool =
    if i >= 0 then (
      if func (String.get str i) then 
        aux (i - 1) 
      else 
        false
    )
    else 
      true
  in

  aux (String.length str - 1)

let is_digit c = c >= '0' && c <= '9'

let () = 
  if ft_string_all (is_digit) ("123") then
    print_endline "true"
  else
    print_endline "false";

  if ft_string_all (is_digit) ("123b") then
    print_endline "true"
  else
    print_endline "false";