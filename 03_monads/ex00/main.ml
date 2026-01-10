type clock = One | Two

module Watchtower :
sig
  type hour = int
  val zero : int
  val add : hour -> hour -> hour
  val sub : hour -> hour -> hour
end =
struct
  type hour = int
  let zero = 12
  let add x y = (x + y - 1) mod zero + 1
  let sub x y = (x - y - 1 + zero) mod zero + 1
end

let () = 
  Printf.printf "add(%d, %d) = %d\n" 10 1 (Watchtower.add 10 1);
  Printf.printf "add(%d, %d) = %d\n" 2 2 (Watchtower.add 2 2);
  Printf.printf "add(%d, %d) = %d\n" 7 7 (Watchtower.add 7 7);
  Printf.printf "add(%d, %d) = %d\n" 12 1 (Watchtower.add 12 1);
  Printf.printf "add(%d, %d) = %d\n" 12 12 (Watchtower.add 12 12);
  Printf.printf "sub(%d, %d) = %d\n" 5 3 (Watchtower.sub 5 3);
  Printf.printf "sub(%d, %d) = %d\n" 10 12 (Watchtower.sub 10 12);
  Printf.printf "sub(%d, %d) = %d\n" 1 11 (Watchtower.sub 1 11);
  Printf.printf "sub(%d, %d) = %d\n" 1 1 (Watchtower.sub 1 1);