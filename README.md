Resource: **https://courses.cs.cornell.edu/cs3110/2021sp/textbook/**

# 1. Side-effects

A side effect occurs when a function does something beyond just computing and returning a value from its inputs—it changes the outside world or observable state.

**Common Side Effects**

- Printing to console
- Modifying mutable state
- Reading/writing files, network I/O
- Global state changes
- Exceptions raised

**Performance Paradox**

- Side effects seem "faster" (mutation vs copying) but:
- Break compiler optimizations
- Prevent sharing (immutable data can be shared)
- Make parallelism impossible

# 2. Tail-recursion

Recursive call is performed as the `last instruction`(after we made a recursive call a program is done working and has nothing else to do).

When using not tail-recursive functions every call is placed on stack and may lead to stack-overflow. On the other hand, when using tail-recursive functions the stack is not growing at all since compiler knows that the previous function is over and new recursive call is taking place of the old one instead of polling up on top of it. Tail-recursion reaches the same level of performance as a C loop.

1. Not tail-recursive

```ocaml
let fact n =
    if n <= 1 then 1
    else n * fact (n-1)
```

2. Tail-recursive

```ocaml
let fact_tail n acc =
    if n <= 1 then acc
    else fact_tail (n-1) (n * acc)
```

# 3. Lambda expressions (anonymous functions)

Create functions without naming them, useful for short operations

```ocaml
fun x -> x * x

List.map (fun x -> x * x) [1; 2; 3]
```

# 4. Closures

TODO

# 5. Partial application

Pins some args to a function early, handing back a simpler function that just needs the rest

```ocaml
let add x y = x + y;;
let add_partial = add 3;; (* returns func with 1 arg *)
add 5;; (* result = 8 *)
```

# 6. Bindings vs Variables

| Aspect             | Variables (C)                   | Bindings (OCaml, Rust)                      |
| ------------------ | ------------------------------- | ------------------------------------------- |
| **Mutability**     | Mutable: `x = 10` changes value | Immutable: `let x = 10` creates new binding |
| **Reassignment**   | `x = new_value` (mutates)       | `let x = new_value` (shadows old binding)   |
| **Memory**         | Single location updated         | New value allocated, old persists           |
| **Predictability** | Order-dependent, side effects   | Pure, always same result                    |

**Core difference**: Variables mutate. Bindings map names to immutable values.

# 7. `;` operator

Used to separate expressions with `unit` return type.

```ocaml
let () =
  print_endline "Hello" ;
  print_endline "World"

let () =
  (match is_palindrome "madam" with true -> print_string "true" | false -> print_string "false") ;
  (match is_palindrome "car" with true -> print_string "true" | false -> print_string "false")
```

# 8. `in` keyword

`in` ends a local let binding so it can be used in expressions that follow it.

```ocaml
let len = String.length s in
if len > 0 then String.get s (len - 1)
```

# 9. `'a` polymorphic params

Function `let id x = x ` has type `'a -> 'a`, accepting any type input and returning it unchanged

```ocaml
(*Lists: 'a list holds any elements (ints, strings) *)

List.map (fun x -> x * 2) [1;2;3] (*infers 'a list where 'a supports all types*)
```

# 10. Polymorphic variants

TODO

# 11. List destructuring

`head :: tail` (at least 1 element), `head :: body :: tail` (at least 2 elements)

```ocaml
let rec sum lst =
  match lst with
  | [] -> 0
  | head :: tail -> head + sum tail
```

# 12. Interfaces

Describe what a module exposes without saying how it’s implemented

```ocaml
(* foo.mli *)
val add : int -> int -> int
```

```ocaml
(* foo.ml *)
let add x y = x + y
```

# 13. Abstract types

A type whose name is visible, but whose representation is hidden.
In practice:

- Users know that the type exists
- They don’t know what it’s made of
- The only way to interact with it is through functions you expose
- This is enforced by the compiler

```ocaml
(* user_id.mli *)
type t
val of_int : int -> t
val to_string : t -> string
```

```ocaml
(* user_id.ml *)
type t = int
let of_int x = x
let to_string = string_of_int
```

# 14. Modules

1. **Modules** - (like a class)

```ocaml
module ModuleName = struct
  (* definitions *)
end
```

Module names must begin with an uppercase letter. The part of the module definition that is written `struct (* definitions *) end` is called a structure. A structure is simply a sequence of definitions.

2. **Module types** - let us describe groups of related modules(interface in a way).

```ocaml
module type Stack = sig
  type 'a stack
  val empty    : 'a stack
  val is_empty : 'a stack -> bool
  val push     : 'a -> 'a stack -> 'a stack
  val peek     : 'a stack -> 'a
  val pop      : 'a stack -> 'a stack
end
```

The part of the module type that is written `sig (* declarations *) end` is called a signature. A signature is simply a sequence of declarations

# 15. `ignore` function

Used to ignore the return value. Ignore is a function that takes a polymorphic param and returns unit (`val ignore -> 'a -> unit`)

```ocaml
let addTwo x y =
  x + y

ignore (addTwo 2 2)
```

# 16. `mutable` keyword

The mutable keyword makes a record field changeable

```ocaml
type counter = { mutable value : int }

let c = { value = 0 }

c.value <- 1
```

# 17. `ref` type

A ref is like a pointer or reference in an imperative language. It is a location in memory whose contents may change. Refs are also called ref cells, the idea being that there's a cell in memory that can change.

Syntax:

- Ref creation: `ref e`

- Ref assignment: `e1 := e2`

- Dereference: `!e`

# 18. Physical Equality

OCaml has two equality operators, physical equality and structural equality. The documentation of `==` explains physical equality:

    e1 == e2 tests for physical equality of e1 and e2. On mutable types such as references, arrays, byte sequences, records with mutable fields and objects with mutable instance variables, e1 == e2 is true if and only if physical modification of e1 also affects e2. On non-mutable types, the behavior of ( == ) is implementation-dependent; however, it is guaranteed that e1 == e2 implies compare e1 e2 = 0.

One interpretation could be that == should be used only when comparing refs (and other mutable data types) to see whether they point to the same location in memory. Otherwise, don't use ==.

Structural equality is also explained in the documentation of `=`:

    e1 = e2 tests for structural equality of e1 and e2. Mutable structures (e.g. references and arrays) are equal if and only if their current contents are structurally equal, even if the two mutable objects are not the same physical object. Equality between functional values raises Invalid_argument. Equality between cyclic data structures may not terminate.

# 19. Command Line Arguments

Just use `Sys.argv` to retrieve them
