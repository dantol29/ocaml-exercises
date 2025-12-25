let () = 
  let jokes = [|
    "- Where did you get that information?\n- Manual.\n- Manuel who?";
    "That s what she said."; 
    "Why do Java developers wear glasses? Because they don't C#.";
    "I would tell you a UDP joke, but you might not get it.";
    "What’s the object-oriented way to become wealthy? Inheritance."
    |] 
  in

  Random.self_init ();
  let r = Random.int (Array.length jokes) in
  print_endline (Array.get jokes r)
  
