class hydrogen = 
  object
    inherit Atom.atom "Hydrogen" "H" 1
  end

class carbon = 
  object
    inherit Atom.atom "Carbon" "C" 6
  end

class oxygen = 
  object
    inherit Atom.atom "Oxygen" "O" 8
  end

class nitrogen = 
  object
    inherit Atom.atom "Nitrogen" "N" 7
  end

class helium = 
  object
    inherit Atom.atom "Helium" "He" 2
  end

class fluorine = 
  object
    inherit Atom.atom "Fluorine" "F" 9
  end

let () = 
  let h = new hydrogen in
  let c = new carbon in
  let o = new oxygen in
  let n = new nitrogen in
  let he = new helium in
  let f = new fluorine in

  let l = [h; c; o; n; he; f] in

  List.iter (fun x -> print_endline x#to_string) l;

  let h2 = new hydrogen in
  Printf.printf "%B\n" (h#equals h2);
  Printf.printf "%B\n" (h#equals c)