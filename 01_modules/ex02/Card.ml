module Color = struct
  type t = Spade | Heart | Diamond | Club
  let all = [Spade; Heart; Diamond; Club]
  let toString v =
    match v with
      | Spade -> "S"
      | Heart -> "H"
      | Diamond -> "D"
      | Club -> "C"
  let toStringVerbose v = 
    match v with
      | Spade -> "Spade"
      | Heart -> "Heart"
      | Diamond -> "Diamond"
      | Club -> "Club"
end

module Value = struct
  type t = T2 | T3 | T4 | T5 | T6 | T7 | T8 | T9 | T10 | Jack | Queen | King | As
  let all = [T2 ; T3 ; T4 ; T5 ; T6 ; T7 ; T8 ; T9 ; T10 ; Jack ; Queen ; King ; As]
  let toInt v =
    match v with
    | T2 -> 1
    | T3 -> 2
    | T4 -> 3
    | T5 -> 4
    | T6 -> 5
    | T7 -> 6
    | T8 -> 7
    | T9 -> 8
    | T10 -> 9
    | Jack -> 10
    | Queen -> 11
    | King -> 12
    | As -> 13
  let toString v =
    match v with
    | T2 -> "2"
    | T3 -> "3"
    | T4 -> "4"
    | T5 -> "5"
    | T6 -> "6"
    | T7 -> "7"
    | T8 -> "8"
    | T9 -> "9"
    | T10 -> "10"
    | Jack -> "J"
    | Queen -> "Q"
    | King -> "K"
    | As -> "A"
  let toStringVerbose v =
    match v with
    | T2 -> "2"
    | T3 -> "3"
    | T4 -> "4"
    | T5 -> "5"
    | T6 -> "6"
    | T7 -> "7"
    | T8 -> "8"
    | T9 -> "9"
    | T10 -> "10"
    | Jack -> "Jack"
    | Queen -> "Queen"
    | King -> "King"
    | As -> "As"
  let next v =
    match v with
    | T2 -> T3
    | T3 -> T4
    | T4 -> T5
    | T5 -> T6
    | T6 -> T7
    | T7 -> T8
    | T8 -> T9
    | T9 -> T10
    | T10 -> Jack
    | Jack -> Queen
    | Queen -> King
    | King -> As
    | As -> invalid_arg "cannot increment As"
  let previous v =
    match v with
    | T2 -> invalid_arg "cannot decrement T2"
    | T3 -> T2
    | T4 -> T3
    | T5 -> T4
    | T6 -> T5
    | T7 -> T6
    | T8 -> T7
    | T9 -> T8
    | T10 -> T9
    | Jack -> T10
    | Queen -> Jack
    | King -> Queen
    | As -> King
end

type t = Color.t * Value.t

let newCard (v: Value.t) (c: Color.t) : t = 
  (c, v)

let allSpades : t list = 
  List.map (fun x -> (Color.Spade, x)) Value.all

let allHearts : t list = 
  List.map (fun x -> (Color.Heart, x)) Value.all

let allDiamonds : t list = 
  List.map (fun x -> (Color.Diamond, x)) Value.all

let allClubs : t list = 
  List.map (fun x -> (Color.Club, x)) Value.all

let all = 
  let all_values = Value.all in
  let all_colors = Color.all in
  List.concat_map (fun color -> List.map (fun x -> (color, x)) all_values) all_colors
  
let getValue ((_, y): t) = 
  y

let getColor ((x, _): t) = 
  x

let toString ((x, y): t) = 
  Printf.sprintf "%s%s" (Color.toString x) (Value.toString y)

let toStringVerbose ((x, y): t) = 
  Printf.sprintf "Card(%s, %s)" (Color.toStringVerbose x) (Value.toStringVerbose y)

let compare ((_, x): t) ((_, y): t) = 
  Value.toInt x  - Value.toInt y

let max (x: t) (y: t) = 
  let (_, value1) = x in
  let (_, value2) = y in 
  let v1 = Value.toInt value1 in
  let v2 = Value.toInt value2 in

  if v1 >= v2 then x
  else y

let min (x: t) (y: t) = 
  let (_, value1) = x in
  let (_, value2) = y in 
  let v1 = Value.toInt value1 in
  let v2 = Value.toInt value2 in

  if v1 <= v2 then x
  else y

let best (l: t list) : t =
  match l with
  | [] -> invalid_arg "Empty list"
  | head :: tail -> (
      List.fold_left
      (fun best curr -> if Value.toInt (snd curr) > Value.toInt (snd best) then curr else best) 
      head tail
  )

let isOf ((x, _): t) color = 
  color = x

let isSpade (x: t) = 
  isOf x Color.Spade

let isHeart (x: t) = 
  isOf x Color.Heart

let isDiamond (x: t) = 
  isOf x Color.Diamond

let isClub (x: t) =
  isOf x Color.Club