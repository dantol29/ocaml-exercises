let ft_rot_n (num : int) (str : string) : string =
  let move_char (c : char) (i : int) = 
    let cnum = int_of_char c in
    if cnum > 122 || cnum < 65 || (cnum > 90 && cnum < 97) then
      c
    else
      char_of_int (int_of_char c + i)
    in

  String.map (fun c -> move_char c num) str

let () =
  let line = ft_rot_n 1 "abcdefghijklmnopqrstuvwxyz" in
  print_endline line;
  let line = ft_rot_n 13 "abcdefghijklmnopqrstuvwxyz" in
  print_endline line;
  let line = ft_rot_n 42 "0123456789" in
  print_endline line;
  let line = ft_rot_n 2 "OI2EAS67B9" in
  print_endline line;