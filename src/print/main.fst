module Main

open FStar.IO
open FStar.Printf

let print_string s = print_string (sprintf "%s\n" s)
let print_int d = print_string (sprintf "%d" d)
let print_string_and_int s d = print_string (sprintf "%s%d" s d)

let _ = print_string "HELLO!"
let _ = print_int 123
let _ = print_string_and_int "errNo: " 123
