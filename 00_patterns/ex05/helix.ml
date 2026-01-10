type phosphate = string
type deoxyribose = string
type nucleobase = A | T | C | G | None
type nucleotide = {
  p: phosphate;
  d: deoxyribose;
  n: nucleobase
}

type helix = nucleotide list

let nucleobase_to_string n: string = 
   match n with
   | A -> "A"
   | T -> "T"
   | C -> "C"
   | G -> "G"
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

let complimentary_helix (h: helix) : helix = 
   let rec aux l acc =
      match l with
      | [] -> acc
      | head :: tail -> (
         let nubase = 
           (match head.n with
           | A -> T
           | T -> A
           | C -> G
           | G -> C
           | None -> None) in
         aux tail ({ p = head.p; d = head.d; n = nubase } :: acc)
      )
   in

   aux h []


let () =
   let h = generate_helix 3 in
   print_endline (helix_to_string h);

   let h2 = complimentary_helix h in
   print_endline (helix_to_string h2);
