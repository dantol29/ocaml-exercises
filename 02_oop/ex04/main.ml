let () = 
  let people = [new People.people "Cristiano"; new People.people "Fabio";
    new People.people "Gareth"; new People.people "Frodo"] in

  let doctors = [new Doctor.doctor "Denis" 42 (List.nth people 0); 
    new Doctor.doctor "Martin" 42 (List.nth people 1)] in

  let g = new Galifrey.galifrey [new Dalek.dalek; new Dalek.dalek] doctors people in

  g#do_time_war

  