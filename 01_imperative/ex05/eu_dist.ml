(* sqrt ( power(x1 - y1) + power(x2 - y2) + ... ) *)
let eu_dist (x: float array) (y: float array) : float =
  let len1 = Array.length x in
  let len2 = Array.length y in
  if len1 <> len2 then
    invalid_arg "Arrays must be of equal length";

  let acc = ref 0.0 in
  
  for i = 0 to len1 - 1 do
    acc := !acc +. (x.(i) -. y.(i)) ** 2.0
  done;
  
  sqrt !acc

let () = 
  try
    assert (0.0 = (eu_dist [|1.0; 2.0; 3.0|] [|1.0; 2.0; 3.0|]));
    assert (5.0 = (eu_dist [|0.0; 0.0|] [|3.0; 4.0|]));
    assert (3.0 = (eu_dist [|2.0|] [|5.0|]));
    assert ((sqrt 27.0) = (eu_dist [|0.0;0.0;0.0|] [|3.0;3.0;3.0|]));
    assert ((sqrt 18.0) = (eu_dist [| -1.0; -1.0 |] [|2.0; 2.0|]))
  with
  | Invalid_argument msg -> print_endline msg
  | Assert_failure (msg, d1, d2) -> 
    Printf.printf "%s: %d, %d\n" msg d1 d2
