class ['a] army (x : 'a list) = 
  object
    val members : 'a list = x

    method get_members = members
    method add (x : 'a) = new army (x :: members)
    method delete = 
      match members with
      | head :: tail -> new army tail
      | [] -> new army []
  end