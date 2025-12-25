type 'a ft_ref = { mutable contents: 'a }

let return (x: 'a) : 'a ft_ref = 
  { contents = x }

let get (x: 'a ft_ref) : 'a =
  x.contents

let set (x : 'a ft_ref) (value : 'a) : unit =
  x.contents <- value

let bind (x : 'a ft_ref) (f : ('a -> 'b ft_ref)) : 'b ft_ref =
  f x.contents

let () = 
  let x = return 21 in
  Printf.printf "%i\n" (get x);
  set x 42;
  Printf.printf "%i\n" (get x);
  Printf.printf "%i\n" (get (bind x (fun x -> { contents = x * 2 })));
