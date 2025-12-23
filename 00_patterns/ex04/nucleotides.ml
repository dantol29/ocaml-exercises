type phosphate = string
type deoxyribose = string
type nucleobase = A | T | C | G | None
type nucleotide = {
  p: phosphate;
  d: deoxyribose;
  n: nucleobase
}

let generate_nucleotide nucleobase_char : nucleotide =
  let char_to_nucleobase n = 
    match n with
    | 'A' -> A
    | 'T' -> T
    | 'C' -> C
    | 'G' -> G
    | _ -> None 
  in

  {
    p = "phosphate";
    d = "deoxyribose";
    n = char_to_nucleobase nucleobase_char
  }

let () = 
  let print_nucleotid n = 
    let nucleobase_to_string n: string = 
      match n with
      | A -> "A"
      | T -> "T"
      | C -> "C"
      | G -> "G"
      | None -> "None"
    in

    Printf.printf "%s, %s, %s\n" n.p n.d (nucleobase_to_string n.n)
  in
    
  print_nucleotid (generate_nucleotide 'A');
  print_nucleotid (generate_nucleotide 'T');
  print_nucleotid (generate_nucleotide 'C');
  print_nucleotid (generate_nucleotide 'G');
  print_nucleotid (generate_nucleotide 'Q')

