module Try :
sig
  type 'a t = Success of 'a | Failure of exn
  val return: 'a -> 'a t
  val bind: 'a t -> ('a -> 'b t) -> 'b t
  val recover: 'a t -> (exn -> 'a t) -> 'a t
  val filter: 'a t -> ('a -> bool) -> 'a t
  val flatten: 'a t t -> 'a t
end =
struct
  type 'a t = Success of 'a | Failure of exn
  let return (x: 'a) : 'a t = Success x
  
  let bind (x: 'a t) (f: ('a -> 'b t)) : 'b t =
    match x with
    | Failure e -> Failure e
    | Success v -> (
      try
        f v
      with
      | exn -> Failure exn
    )

  let recover (x: 'a t) (f: (exn -> 'a t)) : 'a t =
    match x with
    | Success v -> Success v
    | Failure e -> (
      try
        f e
      with
      | exn -> Failure exn
    )

    let filter (x: 'a t) (f: ('a -> bool)) : 'a t =
      bind x (fun v ->
        try
          match f v with
          | true -> Success v
          | false -> Failure (Failure "value does not match")
        with
        | e -> Failure e
      )

    let flatten (x: 'a t t) : 'a t = bind x (fun y -> y)
  
end

let () = 
  let x = Try.return 42 in
  let res = Try.bind x (fun x -> Try.return (x * 2)) in
  (match res with
  | Try.Success v -> print_endline ("Success: " ^ string_of_int v)
  | Try.Failure e -> print_endline ("Failure: " ^ Printexc.to_string e));

  let fail_x = Try.Failure (Failure "some fail") in
  let recovered = Try.recover fail_x (fun _ -> Try.return 99) in
  (match recovered with
  | Try.Success v -> print_endline ("Recovered: " ^ string_of_int v)
  | Try.Failure e -> print_endline ("Recovery failed: " ^ Printexc.to_string e));

  let nested = Try.Success (Try.Success 123) in
  let flat = Try.flatten nested in
  (match flat with
  | Try.Success v -> print_endline ("Flattened: " ^ string_of_int v)
  | Try.Failure e -> print_endline ("Flatten failed: " ^ Printexc.to_string e));

  let nested = Try.Success (Try.Failure (Failure "fail")) in
  let flat = Try.flatten nested in
  (match flat with
  | Try.Success v -> print_endline ("Flattened: " ^ string_of_int v)
  | Try.Failure e -> print_endline ("Flatten failed: " ^ Printexc.to_string e));

  let z = Try.return 5 in
  let res3 = Try.filter z (fun v -> v > 10) in
  (match res3 with
  | Try.Success v -> print_endline ("Filter success: " ^ string_of_int v)
  | Try.Failure e -> print_endline ("Filter failed: " ^ Printexc.to_string e));


  let y = Try.return 10 in
  let res2 = Try.bind y (fun v -> if v = 10 then failwith "nooooo" else Try.return v) in
  (match res2 with
  | Try.Success v -> print_endline ("Success: " ^ string_of_int v)
  | Try.Failure e -> print_endline ("Failure: " ^ Printexc.to_string e));
