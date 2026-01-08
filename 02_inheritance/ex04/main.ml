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

class butane =
  object
    inherit Alkane.alkane "Butane" 4
  end

let is_integer x = abs_float (x -. Float.trunc x) < 1e-9        

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
      Printf.printf "= %d and %d\n" start_atoms result_atoms;
      start_atoms = result_atoms

    (* formula: CnH2n+2 + (3n+1)/2 02 -> nCO2 + (n+1)H2O (where n = carbon count) *)
    method balance =
      let formula alkane =
        let carbon = self#carbon_count alkane in
        let o2 = ((3.0 *. float_of_int carbon +. 1.0)) /. 2.0 in
        let co2 = carbon in
        let h2o = carbon + 1 in
        Printf.printf "%s + %fO2 -> %dCO2 + %dH2O\n" alkane#formula o2 co2 h2o;
        (o2, co2, h2o)
      in

      let (o2, co2, h2o) = 
        List.fold_right 
        (fun alkane (o2, co2, h2o) -> (
          let (new_o2, new_co2, new_h2o) = formula alkane in
          (new_o2 +. o2, new_co2 + co2, new_h2o + h2o)
        )) 
        alkanes (0.0, 0, 0) 
      in

      Printf.printf "alkanes + %fO2 -> %dCO2 + %dH2O\n" o2 co2 h2o;
      let scale = if is_integer o2 then 1 else 2 in
  
      start <- (List.mapi (fun i alk -> (alk, scale)) alkanes) 
        @ [(new oxygen_m, int_of_float (o2 *. float_of_int scale))];
      result <- [(new carbon_dioxide, co2 * scale); (new water, h2o * scale)];    
      (self :> alkane_combustion)
    
    method private carbon_count alk = 
      List.fold_left 
      (fun acc (a: Atom.atom) -> if a#symbol = "C" then acc + 1 else acc) 
      0 alk#get_atoms
  end

let () = 
  let a = new alkane_combustion [new methane; new ethane; new methane; new butane] in
  Printf.printf "%B\n\n" a#is_balanced;

  let a = a#balance in
  print_newline ();

  Printf.printf "%B\n" a#is_balanced;
  
  print_newline ();
  List.iter (fun (m, c) -> Printf.printf "%d%s " c m#formula) a#get_start;
  print_string "-> ";
  List.iter (fun (m, c) -> Printf.printf "%d%s " c m#formula) a#get_result;
  print_newline ()

(* https://www.omnicalculator.com/chemistry/combustion-reaction *)