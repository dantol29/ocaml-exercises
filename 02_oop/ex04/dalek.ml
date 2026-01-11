class dalek =
  object
    val name : string = 
      let () = Random.self_init () in
      Printf.sprintf "Dalek%c%c%c"
      (char_of_int (Random.int_in_range ~min:65 ~max:91))
      (char_of_int (Random.int_in_range ~min:65 ~max:91))
      (char_of_int (Random.int_in_range ~min:65 ~max:91))
    val hp : int = 100
    val mutable shield : bool = true

    method to_string = Printf.sprintf "%s : %d : %B" name hp shield
    method die = print_endline "Emergency Temporal Shift!"
    method talk = 
      let () = Random.self_init () in

      let phrases = ["Explain! Explain!"; "Exterminate! Exterminate!";
      "I obey!"; "You are the Doctor! You are the enemy of the Daleks!"] in
      print_endline (List.nth phrases (Random.int (List.length phrases)))
    method exterminate (p : People.people) = 
      let () = p#die in

      if shield = true then shield <- false
      else shield <- true
  end