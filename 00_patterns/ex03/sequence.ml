let sequence n =
  let int_to_digits n =
    let rec aux n acc =
      if n < 10 then
        Char.chr (n + 48) :: acc
      else
        aux (n / 10) (Char.chr ((n mod 10) + 48) :: acc)
    in
    aux n []
  in

  let rev_list l = 
    let rec aux l acc =
      match l with
      | [] -> acc
      | head :: tail -> aux tail (head :: acc)
    in
    aux l []
  in
  
  let rec aux (old_l: char list) (new_l: char list) (curr_c: char option) count_c curr_n = 
    if curr_n = n 
      then old_l
    else 
      match old_l with
      | [] -> (
        match curr_c with
        | None -> []
        | Some c -> (
          let next_l = rev_list (c :: int_to_digits count_c @ new_l) in
          aux next_l [] None 0 (curr_n + 1)
        )
      )
      | head :: tail -> (
        match curr_c with
        | None -> aux tail new_l (Some head) 1 curr_n
        | Some c -> (
          if head = c then
            aux tail new_l curr_c (count_c + 1) curr_n
          else begin
            let next_l = (c :: int_to_digits count_c @ new_l) in
            aux tail next_l (Some head) 1 curr_n
          end
        )
      )
  in

  if n > 0 then
    aux ['1'] [] None 0 0
  else 
    []

let () =
    let l = sequence 1 in
    List.iter (fun x -> print_char x) l;
    print_newline();
    let l = sequence 2 in
    List.iter (fun x -> print_char x) l;
    print_newline();
    let l = sequence 3 in
    List.iter (fun x -> print_char x) l;
    print_newline();
    let l = sequence 4 in
    List.iter (fun x -> print_char x) l;
    print_newline();
    let l = sequence 5 in
    List.iter (fun x -> print_char x) l;
    print_newline();
    let l = sequence 6 in
    List.iter (fun x -> print_char x) l;
    print_newline();