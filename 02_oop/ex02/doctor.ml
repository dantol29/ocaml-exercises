class doctor name age sidekick =
  object
    val name : string = name
    val sidekick : People.people = sidekick
    val age : int = age
    val hp : int = 100

    initializer Printf.printf "Doctor %s was born\n" name

    method to_string = Printf.sprintf "%s : %d : %d : people (%s)" name age hp sidekick#to_string
    method talk = print_endline "Hi! I'm the Doctor!"
    method use_sonic_screwdriver = print_endline "Whiiiiwhiiiwhiii Whiiiiwhiiiwhiii Whiiiiwhiiiwhiii"
    method private regenerate = new doctor name age sidekick
    method travel_in_time (start : int) (arrival : int) = 
      let () = print_string "
          _______
         /       \\
        /         \\
       /___________\\
       |  POLICE   |
       |    BOX    |
       |-----------|
       |  _   _    |
       | | | | |   |
       | |_| |_|   |
       |  _   _    |
       | | | | |   |
       | |_| |_|   |
       |           |
       |   ___     |
       |  |   |    |
       |  |   |    |
       |__|___|____|
       |   | |     |
       |   | |     |
       |___|_|_____|
       |   | |     |
       |   | |     |
       |___|_|_____|
    " in
    if arrival > start then new doctor name (age + (arrival - start)) sidekick
    else new doctor name age sidekick
  end