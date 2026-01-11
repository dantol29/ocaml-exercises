module type MONOID =
sig
  type element
  val zero1 : element
  val zero2 : element
  val mul : element -> element -> element
  val add : element -> element -> element
  val div : element -> element -> element
  val sub : element -> element -> element
end

(* Division cannot have an identity element that works for all numbers *)
(* 1 / a = a / 1 = a - not a monoid *)
(* 1 * a = a * 1 = a - monoid *)
module INT : (MONOID with type element = int) =
struct
  type element = int
  let zero1 = 0
  let zero2 = 1
  let add (x: element) (y: element) = x + y
  let sub (x: element) (y: element) = x - y
  let mul (x: element) (y: element) = x * y
  let div (x: element) (y: element) = x / y
end

module FLOAT : (MONOID with type element = float) =
struct
  type element = float
  let zero1 = 0.0
  let zero2 = 1.0
  let add (x: element) (y: element) = x +. y
  let sub (x: element) (y: element) = x -. y
  let mul (x: element) (y: element) = x *. y
  let div (x: element) (y: element) = x /. y
end

module type CALC_SIG =
sig
  type element
  val add : element -> element -> element
  val sub : element -> element -> element
  val mul : element -> element -> element
  val div : element -> element -> element
  val power : element -> int -> element
  val fact : element -> element
end

module type CALC = functor (M : MONOID) -> (CALC_SIG with type element := M.element)

module Calc : CALC = functor (M : MONOID) ->
struct
  let add (x: M.element) (y: M.element) = M.add x y
  let sub (x: M.element) (y: M.element) = M.sub x y
  let mul (x: M.element) (y: M.element)= M.mul x y
  let div (x: M.element) (y: M.element) = M.div x y
  let power (x: M.element) (y: int) : M.element = 
    let rec aux n acc =
      if n = y then acc
      else aux (n + 1) (M.mul acc x)
    in

    aux 1 x
  let fact (x: M.element) : M.element = 
    let rec aux n acc =
      if n = M.zero2 then acc
      else aux (M.sub n M.zero2) (M.mul n acc)
    in

    aux x M.zero2
end

module Calc_int = Calc(INT)
module Calc_float = Calc(FLOAT)

let () =
  print_endline (string_of_int (Calc_int.power 3 3));
  print_endline (string_of_float (Calc_float.power 3.0 3));
  print_endline (string_of_int (Calc_int.mul (Calc_int.add 20 1) 2));
  print_endline (string_of_float (Calc_float.mul (Calc_float.add 20.0 1.0) 2.0));

  print_endline (string_of_int (Calc_int.power 2 4));
  print_endline (string_of_int (Calc_int.fact 4));
  print_endline (string_of_int (Calc_int.fact 5));
  print_endline (string_of_float (Calc_float.fact 3.0));

  print_endline (string_of_float (Calc_float.add 3.0 3.0));
  print_endline (string_of_float (Calc_float.sub 3.0 3.0));