let iter (f: int -> int) (x: int) (n: int) =
   if n < 0 then -1
   else if n = 0 then x
   else (
      let rec aux i acc =
         if i = n then acc
         else aux (i + 1) (f acc)
      in

      aux 0 x
   )

let () =
   print_int (iter (fun x -> x * x) 2 4);
   print_newline ();

   print_int (iter (fun x -> x * 2) 2 4);
   print_newline ();

