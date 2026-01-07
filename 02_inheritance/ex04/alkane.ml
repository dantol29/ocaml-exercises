class hydrogen = 
  object
    inherit Atom.atom "Hydrogen" "H" 1
  end

class carbon = 
  object
    inherit Atom.atom "Carbon" "C" 6
  end

class virtual alkane name count =
  object
    inherit Molecule.molecule name (
      let carbon = List.init count (fun _ -> new carbon) in
      let hydrogen = List.init (count * 2 + 2) (fun _ -> new hydrogen) in
      carbon @ hydrogen
    )
  end