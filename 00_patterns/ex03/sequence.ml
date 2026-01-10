let sequence n =
  let ints_to_string l =
    let rec aux ints acc =
      match ints with
      | [] -> acc
      | head :: tail -> aux tail (acc ^ String.make 1 (Char.chr (head + 48)))
    in
    aux l ""
  in

  let rec aux (acc: int list) (new_l: int list) (curr: int option) count seqn = 
    if seqn = n then acc
    else 
      match acc with
      | [] -> (
        match curr with
        | None -> []
        | Some i -> aux (new_l @ [count; i]) [] None 0 (seqn + 1)
      )
      | head :: tail -> (
        match curr with
        | None -> aux tail new_l (Some head) 1 seqn
        | Some i -> (
          if head = i then
            aux tail new_l curr (count + 1) seqn
          else
           aux tail (new_l @ [count; i]) (Some head) 1 seqn
        )
      )
  in

  if n > 0 then
    ints_to_string (aux [1] [] None 0 0)
  else 
    ""

let () =
    print_endline (sequence 1);
    print_endline (sequence 2);
    print_endline (sequence 3);
    print_endline (sequence 4);
    print_endline (sequence 5);
    print_endline (sequence 6);
