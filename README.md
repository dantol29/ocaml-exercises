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
