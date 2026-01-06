class virtual molecule (n : string) (atoms : Atom.atom list) =
  object(self)
    val atoms = List.sort (fun x y -> String.compare x#symbol y#symbol) atoms

    method name : string = n
    method to_string = self#name ^ " : " ^ self#formula 
    method equals (m: molecule) = self#formula = m#formula
    method formula : string = 
      let rec contains(l : (Atom.atom * int) list) atom = 
        match l with
        | [] -> false
        | (a, b) :: tail -> (
          if atom#equals a then true
          else contains tail atom
        )
      in
      
      let r = 
        List.fold_right 
        (fun atom acc -> 
          if contains acc atom then acc 
          else (
            (atom, (
              List.fold_left 
              (fun acc a -> if atom#equals a then acc + 1 else acc) 
              0 atoms
            )) :: acc
          )
        )
        atoms [] in

        List.fold_left
        (fun acc (a, b) -> 
          acc ^ a#symbol ^ (if b > 1 then string_of_int (b) else ""))
        "" r
      
  end