module type FIXED = 
sig
  type t
  val of_float : float -> t
  val of_int : int -> t
  val to_float : t -> float
  val to_int : t -> int
  val to_string : t -> string
  val zero : t
  val one : t
  val succ : t -> t
  val pred : t -> t
  val min : t -> t -> t
  val max : t -> t -> t
  val gth : t -> t -> bool
  val lth : t -> t -> bool
  val gte : t -> t -> bool
  val lte : t -> t -> bool
  val eqp : t -> t -> bool (** physical equality *)
  val eqs : t -> t -> bool (** structural equality *)
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
  val foreach : t -> t -> (t -> unit) -> unit 
end

(* How many bits reserved after the point *)
module type FRACTIONNAL_BITS = 
sig
  val bits : int
end

(* functor signature *)
module type MAKE = functor (X : FRACTIONNAL_BITS) -> FIXED

(* 
  functor 
  fixed-point number - stored as: x = X_real * 2^bits
*)
module Make : MAKE = functor (X : FRACTIONNAL_BITS) -> 
struct
  type t = int
  let round x = floor (x +. 0.5) 
  let of_float (x : float) = int_of_float (round (x *. float_of_int (1 lsl X.bits)))
  let to_float (x: t) =  float_of_int (x) /. float_of_int (1 lsl X.bits)
  let of_int (x: int) = x lsl X.bits (* lsl - shift left == * 2^n *)
  let to_int x : int = x asr X.bits (* asr - shift right == / 2^n *)
  let to_string x = string_of_float (to_float x)
  let zero = of_int 0
  let one = of_int 1
  let succ x = x + 1
  let pred x = x - 1
  let gth (x: t) y = if x > y then true else false
  let lth (x: t) y = if x < y then true else false
  let gte (x: t) y = if x >= y then true else false
  let lte (x: t) y = if x <= y then true else false
  let min x y = if lte x y then x else y
  let max x y = if gte x y then x else y
  let eqp (x: t) y = x == y
  let eqs (x : t) y = x = y
  let add x y = x + y
  let sub x y = x - y
  let mul x y = (x * y) asr X.bits
  let div x y = (x lsl X.bits) / y
  let foreach (from: t) (till: t) (f: (t -> unit)) =
    let rec aux x =
      if gth x till then ()
      else (
        f x;
        aux (succ x)
      )
    in

    aux from
    
end

module Fixed4 : FIXED = Make (struct let bits = 4 end)
module Fixed8 : FIXED = Make (struct let bits = 8 end)

let () =
  let x8 = Fixed8.of_float 21.10 in
  let y8 = Fixed8.of_float 21.32 in
  let r8 = Fixed8.add x8 y8 in
  print_endline (Fixed8.to_string r8);
  Fixed4.foreach (Fixed4.zero) (Fixed4.one) (fun f -> print_endline (Fixed4.to_string f));

  let x4 = Fixed4.of_int 10 in
  let y4 = Fixed4.of_int 30 in

  assert (Fixed4.eqs x4 x4);
  assert (Fixed4.eqp x4 x4);
  assert (300 = (Fixed4.to_int (Fixed4.mul x4 y4)));
  assert (3 = (Fixed4.to_int (Fixed4.div y4 x4)));
  assert (-20 = (Fixed4.to_int (Fixed4.sub x4 y4)));
  assert (30 = (Fixed4.to_int (Fixed4.max x4 y4)));
  assert (10 = (Fixed4.to_int (Fixed4.min x4 y4)));

