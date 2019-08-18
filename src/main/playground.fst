module Playground

open FStar.String
open FStar.All
open FStar.Printf
open FStar.IO

let print_string s =
     print_string (sprintf "%s" s)
let print_int d =
     print_string (sprintf "%d\n" d)
let print_bool b = 
     print_string (sprintf "%b\n" b)
     
let print_string_and_int s d =
     print_string (sprintf "%s%d\n" s d)

// exception InvalidIntRange
// val int_to_nat : x:int -> ML nat
// let int_to_nat x = if x < 0 then raise InvalidIntRange else x

// val int_to_nat : int -> bool
// let int_to_nat x = if x < 0 then false else true


// let _ = print_int i 
// let _ = assert_norm (i = 2)

let strA = "ABC"
let chrB = 'C'

val a : int
let a = index_of strA chrB


// exception InvalidIntRange
// val c : x:int -> bool
// let c x = if x < 0 then false else true

val e : nat
let e = assert_norm(a = 2); a

// let d = c e

// let _ = if d then assert(e > 0) else ()