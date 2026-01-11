module MyHash = 
struct 
  type t = string
  let equal (x: string) (y: string) = x = y  
  (* djb2 - http://www.cse.yorku.ca/~oz/hash.html *)
  let hash (s: string) : int = 
    let len = String.length s in
    let rec aux i hash = 
      if i < len then
        aux (i + 1) (((hash lsl 5) + hash) + int_of_char s.[i])
      else
        hash
    in

    aux 0 5381
end

module StringHashtbl = Hashtbl.Make(MyHash)

let () =
  let ht = StringHashtbl.create 5 in
  let values = [ "Hello"; "world"; "42"; "Ocaml"; "H" ] in
  let pairs = List.map (fun s -> (s, String.length s)) values in
  List.iter (fun (k,v) -> StringHashtbl.add ht k v) pairs;
  StringHashtbl.iter (fun k v -> Printf.printf "k = \"%s\", v = %d\n" k v) ht