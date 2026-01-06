class virtual atom n s an =
  object(self)
    method name : string = n
    method symbol : string = s
    method atomic_number : int = an
    method equals (a : atom) = 
      a#name = self#name &&
      a#symbol = self#symbol &&
      a#atomic_number = self#atomic_number
    method to_string = 
      Printf.sprintf "%s:%s:%d" self#name self#symbol self#atomic_number 
  end