let () = 
  let argv = Sys.argv in
  let file = open_in (Array.get argv 1) in
  
  let jokes = ref [||] in

  try
    while true do
      let line = input_line file in
      jokes := Array.append !jokes [|line|];
    done
  with
  | End_of_file -> (
    Random.self_init ();
    let i = Random.int (Array.length !jokes) in
    print_endline (Array.get !jokes i)
  );

  close_in file;
