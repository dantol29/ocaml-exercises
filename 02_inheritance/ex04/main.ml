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

class oxygen_m = 
  object
    inherit Molecule.molecule "Oxygen" [new oxygen; new oxygen]
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
    inherit Alkane.alkane "Methane" 1
  end

class ethane =
  object
    inherit Alkane.alkane "Ethane" 2
  end

class octane =
  object
    inherit Alkane.alkane "Octane" 8
  end

class alkane_combustion (alkanes: Alkane.alkane list) =
  object(self)
    val mutable start : (Molecule.molecule * int) list = []
    val mutable result : (Molecule.molecule * int) list = []

    initializer
      start <- (List.map (fun alk -> (alk, 1)) alkanes) @ [(new oxygen_m, 1)];
      result <- [(new carbon_dioxide, 1); (new water, 1)]

    inherit Reaction.reaction 
      ((List.map (fun alk -> (alk :> Molecule.molecule)) alkanes) @ [new oxygen_m]) 
      [new carbon_dioxide; new water]

    method get_start = start
    method get_result = result

    method is_balanced =    
      let count_atoms (molecules: (Molecule.molecule * int) list) =
        List.fold_left (fun acc (mol, coeff) ->
          let atoms = (List.length mol#get_atoms) * coeff in
          Printf.printf "%d%s(%d) " coeff mol#formula atoms;
          acc + atoms
        ) 0 molecules
      in

      let start_atoms = count_atoms start in
      print_string "-> ";
      let result_atoms = count_atoms result in
      Printf.printf "\n= %d and %d\n" start_atoms result_atoms;
      start_atoms = result_atoms

    method balance =
      let total_carbon = 
        List.fold_left (fun acc (alkane: Alkane.alkane) -> acc + (self#carbon_count alkane)) 0 alkanes
      in

      let multiply = if total_carbon mod 2 <> 0 then 1 else 2 in

      let alkane_coeff = multiply in
      let co2_coeff = total_carbon * multiply in
      let h2o_coeff = (total_carbon + 1) * multiply in
      let o2_coeff = ((3 * total_carbon + 1) * multiply) / 2 in
      
      start <- (List.map (fun alk -> (alk, alkane_coeff)) alkanes) @ [(new oxygen_m, o2_coeff)];
      result <- [(new carbon_dioxide, co2_coeff); (new water, h2o_coeff)];
      (self :> alkane_combustion)
    
    method private carbon_count alk = 
      List.fold_left 
      (fun acc (a: Atom.atom) -> if a#symbol = "C" then acc + 1 else acc) 
      0 alk#get_atoms
  end

let () = 
  let a = new alkane_combustion [new methane] in
  Printf.printf "%B\n" a#is_balanced;

  let a = a#balance in
  Printf.printf "%B\n" a#is_balanced;
  
  List.iter (fun (m, c) -> Printf.printf "%d%s " c m#formula) a#get_start;
  print_string "-> ";
  List.iter (fun (m, c) -> Printf.printf "%d%s " c m#formula) a#get_result;
  print_newline ()