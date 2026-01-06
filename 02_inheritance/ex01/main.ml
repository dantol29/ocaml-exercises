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

class water =
  object
    inherit Molecule.molecule "Water" [new hydrogen; new oxygen; new hydrogen;]
  end

class carbon_dioxide =
  object
    inherit Molecule.molecule "Carbon dioxide" [new oxygen; new oxygen; new carbon]
  end

class methane =
  object
  inherit Molecule.molecule "Methane" [new carbon; new hydrogen; new hydrogen; new hydrogen; new hydrogen]
  end

class sucrose =
  object
    inherit Molecule.molecule "Sucrose"
      (
        let carbons = List.init 12 (fun _ -> new carbon) in
        let hydrogens = List.init 22 (fun _ -> new hydrogen) in
        let oxygens = List.init 11 (fun _ -> new oxygen) in
        hydrogens @ carbons @ oxygens
      )
  end

class glucose =
  object
    inherit Molecule.molecule "Glucose"
      (
        let carbons = List.init 6 (fun _ -> new carbon) in
        let hydrogens = List.init 12 (fun _ -> new hydrogen) in
        let oxygens = List.init 6 (fun _ -> new oxygen) in
        carbons @ hydrogens @ oxygens
      )
  end

let () = 
  let m = new water in
  let c = new carbon_dioxide in
  let met = new methane in
  let suc = new sucrose in
  let g = new glucose in

  print_endline m#to_string;
  print_endline c#to_string;
  print_endline met#to_string;
  print_endline suc#to_string;
  print_endline g#to_string