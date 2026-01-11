module type PAIR = 
sig 
  val pair : (int * int)
end

module type VAL = 
sig 
  val x : int 
end

(* implements PAIR *)
module Pair : PAIR = 
struct 
  let pair = ( 21, 42 ) 
end

(* functor that accepts a module that implements PAIR and returns a module that implements VAL *)
module MakeFst (I : PAIR) : VAL =
struct
  let x = fst I.pair
end

module MakeSnd (I : PAIR) : VAL =
struct
  let x = snd I.pair
end

(* calls a functor that returns a module that implements VAL*)
module Fst : VAL = MakeFst (Pair)
module Snd : VAL = MakeSnd (Pair)

let () = Printf.printf "Fst.x = %d, Snd.x = %d\n" Fst.x Snd.x