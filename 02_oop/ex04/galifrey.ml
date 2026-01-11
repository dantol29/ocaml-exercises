class galifrey (dal: Dalek.dalek list) (doc: Doctor.doctor list) (peop: People.people list) =
  object
    val dalek_members = dal
    val doctor_members = doc
    val people_members = peop

    method do_time_war =
      Random.self_init ();
      print_endline "The Time War begins!\n";

      List.iter (fun (d: Dalek.dalek) ->
        let target_type = Random.int 2 in
        if target_type = 0 && doctor_members <> [] then (
          let target = List.nth doctor_members (Random.int (List.length doctor_members)) in
          d#talk;
          Printf.printf "Dalek attacks Doctor: (%s)\n" target#to_string
        )
        else if people_members <> [] then (
          let target = List.nth people_members (Random.int (List.length people_members)) in
          d#talk;
          Printf.printf "Dalek attack a person: (%s)\n" target#to_string;
          d#exterminate target
        )
      ) dalek_members;


      List.iter (fun (doc: Doctor.doctor) ->
        doc#talk;
        doc#use_sonic_screwdriver
      ) doctor_members;

      print_endline "The Time War ends... for now."
  end