class methane =
  object
    inherit Alkane.alkane "Methane" 1
  end

class ethane =
  object
    inherit Alkane.alkane "Ethane" 2
  end  

class octane =
  object
    inherit Alkane.alkane "Octane" 8
  end

class decane =
  object
    inherit Alkane.alkane "Decane" 10
  end

class triacontane =
  object
    inherit Alkane.alkane "Triacontane" 30
  end

let () = 
  let m = new methane in
  let e = new ethane in
  let o = new octane in
  let d = new decane in
  let t = new triacontane in

  print_endline m#to_string;
  print_endline e#to_string;
  print_endline o#to_string;
  print_endline d#to_string;
  print_endline t#to_string