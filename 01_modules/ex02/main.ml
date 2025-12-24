let () =
  let card = Card.newCard Card.Value.Jack Card.Color.Spade in
  let card2 = Card.newCard Card.Value.As Card.Color.Diamond in

  Printf.printf "toString: %s\n" (Card.toString card);
  Printf.printf "verbose: %s\n" (Card.toStringVerbose card);
  Printf.printf "should be true: %b, should be false: %b\n" (Card.isSpade card) (Card.isDiamond card);
  Printf.printf "should be true: %b, should be <0: %i\n" (Card.isOf card Card.Color.Spade) (Card.compare card card2);
  Printf.printf "should be >0: %i, should be 0: %i\n" (Card.compare card2 card) (Card.compare card card);
  Printf.printf "max: %s\n" (Card.toStringVerbose (Card.min card card2));
  Printf.printf "min: %s\n" (Card.toStringVerbose (Card.max card card2));
  Printf.printf "best: %s\n" (Card.toStringVerbose (Card.best [card; card2]));
  Printf.printf "best: %s\n" (Card.toStringVerbose (Card.best [card; card]));
  
  try
     let a = Card.best [] in
     print_endline (Card.toStringVerbose a)
  with
  | Invalid_argument s -> Printf.printf "error: %s" s;

  print_endline "\nSpades: ";
  List.iter (fun x -> print_endline (Card.toStringVerbose x)) Card.allSpades;