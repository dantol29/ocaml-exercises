class people name =
  object
    val name : string = name
    val hp : int = 100

    initializer Printf.printf "%s was born\n" name

    method to_string = name ^ " : " ^ string_of_int hp
    method talk = Printf.printf "I'm %s! Do you know the Doctor?\n" name
    method die = print_string "Aaaarghh!\n"
  end