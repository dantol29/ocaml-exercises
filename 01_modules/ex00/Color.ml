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