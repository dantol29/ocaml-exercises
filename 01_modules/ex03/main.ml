let () =
  let deck = Deck.newDeck () in
  List.iter (fun x -> Printf.printf "%s " x) (Deck.toStringList deck);
  print_newline ();
  List.iter (fun x -> Printf.printf "%s " x) (Deck.toStringListVerbose deck);
  print_newline ();

  try
    let _ = List.fold_left 
      (fun acc _ -> 
        let (card, d) = Deck.drawCard acc in
        print_endline (Deck.Card.toStringVerbose card);
        d
      )
      deck (List.init 53 (fun _ -> ())) in
    print_endline "Passed!"
  with
  | Failure msg -> print_endline msg
  

