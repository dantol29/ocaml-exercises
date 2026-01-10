module App :
sig
  type project = string * string * int
  val zero : project
  val combine : project -> project -> project
  val fail : project -> project
  val success : project -> project
end =
struct
  type project = string * string * int
  let zero = ("", "", 0)
  let fail (p: project) : project = 
    let (name, _, _) = p in
    (name, "failed", 0)
  
  let success (p: project) : project =
    let (name, _, _) = p in
    (name, "succeed", 80)
  
  let combine (x: project) (y: project) : project =
    let (name1, _, grade1) = x in
    let (name2, _, grade2) = y in
    let grade = (grade1 + grade2) / 2 in
    let status = if grade > 80 then "succeed" 
    else "failed" in
    (name1 ^ name2, status, grade)
end

let print_proj (p: App.project) =
  let (name, success, grade) = p in
  Printf.printf "%s - %d(%s)\n" name grade success

let () =
  let p1: App.project = ("project_x", "failed", 10) in
  print_proj p1;

  let p1 = App.success p1 in
  print_proj p1;

  let p1 = App.fail p1 in
  print_proj p1;

  let p2: App.project = ("good_one", "succeed", 99) in
  print_proj (App.combine p1 p2)