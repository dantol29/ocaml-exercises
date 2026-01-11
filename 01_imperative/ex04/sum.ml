let sum (x: float) (y: float) : float =
  x +. y

let () = 
  Printf.printf "%f\n" (sum 1.0  1.0);
  Printf.printf "%f\n" (sum 1.0  0.1);
  Printf.printf "%f\n" (sum (-1.0) 0.1);