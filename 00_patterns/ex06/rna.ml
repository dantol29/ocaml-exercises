type phosphate = string
type deoxyribose = string
type nucleobase = A | T | U | C | G | None
type nucleotide = {
  p: phosphate;
  d: deoxyribose;
  n: nucleobase
}

type helix = nucleotide list

type rna = nucleobase list

let nucleobase_to_string n = 
   match n with
   | A -> "A"
   | T -> "T"
   | C -> "C"
   | G -> "G"
   | U -> "U"
   | None -> "None"

let generate_helix n : helix =
   let rec aux count acc =
      if count = n then acc
      else (
         let _ = Random.self_init () in
         let nubase = 
            (match Random.int 4 with
            | 0 -> A
            | 1 -> T
            | 2 -> C
            | 3 -> G
            | _ -> None) in

         aux (count + 1) ({ p = "phosphate" ; d = "deoxyribose"; n = nubase } :: acc)
      )
   in

   aux 0 []

let helix_to_string (h: helix) : string =
   let rec aux l acc = 
      match l with
      | [] -> acc
      | head :: tail -> aux tail (acc ^ (nucleobase_to_string head.n))
   in

   aux h ""

let generate_rna (h: helix) : rna =
   let rec aux l acc =
      match l with
      | [] -> acc
      | head :: tail -> (
         let nubase = 
           (match head.n with
           | A -> U
           | T -> A
           | C -> G
           | G -> C
           | _ -> None) in
         aux tail (nubase :: acc)
      )
   in

   aux h []

let rna_to_string (r: rna) : string =
   let rec aux l acc = 
      match l with
      | [] -> acc
      | head :: tail -> aux tail (acc ^ (nucleobase_to_string head))
   in

   aux r ""

let () =
   let h = generate_helix 3 in
   print_endline (helix_to_string h);

   let r = generate_rna h in
   print_endline (rna_to_string (List.rev r));
