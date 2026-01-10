let encode (l : 'a list): (int * 'a) list =
  let rec aux (l: 'a list) (acc: (int * 'a) list) (count: int) (prev_element: 'a) = 
    match l with
    | [] -> ((count, prev_element) :: acc)
    | head :: tail -> (
      if prev_element = head then
        aux tail acc (count + 1) head
      else
        aux tail ((count, prev_element) :: acc) 1 head
    )
  in
  
  match l with
  | [] -> []
  | head :: tail -> aux tail [] 1 head


let () =
  let result = encode (['a'; 'a'; 'a'; 'b'; 'b'; 'b'; 'c']) in
  List.iter (fun (x, y) -> Printf.printf "(%d, %c) " x y) result;
  print_newline ();

  let result = encode ([1; 1; 1; 2; 2; 2; 3]) in
  List.iter (fun (x, y) -> Printf.printf "(%d, %d) " x y) result;
  print_newline ();

  let result = encode ([1]) in
  List.iter (fun (x, y) -> Printf.printf "(%d, %d) " x y) result;
  print_newline ();

  let result = encode ([]) in
  List.iter (fun (x, y) -> Printf.printf "(%d, %d) " x y) result;
  print_newline ()
