let crossover (l1: 'a list) (l2: 'a list): 'a list = 
  let rec aux l acc = 
    let rec contains (l: 'a list) (elem: 'a) = 
      match l with
      | [] -> false
      | head :: tail -> (
        if head = elem then
          true
        else
          contains tail elem
      )
    in

    match l with
    | [] -> acc
    | head :: tail -> (
      match contains acc head with
      | false -> (
        match contains l1 head with
        | true -> aux tail (head :: acc)
        | false -> aux tail acc
      )
      | true -> aux tail acc
    )
  in

  aux l2 []

let () =
  let result = crossover ([1; 2; 3;]) ([1; 2]) in
  List.iter (fun x -> print_int x) result;
  print_newline ();

  let result = crossover ([1; 2; 2; 2; 3;]) ([1; 2; 2;]) in
  List.iter (fun x -> print_int x) result;
  print_newline ();

  let result = crossover [] [] in
  List.iter print_int result;
  print_newline ();

  let result = crossover [1; 2; 3] [] in
  List.iter print_int result;
  print_newline ();

  let result = crossover [] [1; 2; 3] in
  List.iter print_int result;
  print_newline ();

  let result = crossover [1; 2; 3] [4; 5; 6] in
  List.iter print_int result;
  print_newline ();

  let result = crossover [1; 1; 2; 3] [1; 2; 2; 2] in
  List.iter print_int result;
  print_newline ();