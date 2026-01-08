let ft_is_palindrome (str: string) : bool = 
  let rec aux start ending =
    if start < ending then (
      if (String.get str start) = (String.get str ending) then
       aux (start + 1) (ending - 1)
      else
        false
    ) 
    else 
      true
  in

  aux 0 (String.length str - 1)

let () = 
  if ft_is_palindrome "radar" then
    print_endline "true"
  else 
    print_endline "false";
  
  if ft_is_palindrome "madam" then
    print_endline "true"
  else 
    print_endline "false";
  
  if ft_is_palindrome "car" then
    print_endline "true"
  else 
    print_endline "false";

  if ft_is_palindrome "" then
    print_endline "true"
  else 
    print_endline "false"