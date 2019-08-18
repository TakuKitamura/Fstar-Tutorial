module Main
open FStar.IO
open FStar.Printf

open FStar.String

let print_string s =
     print_string (sprintf "%s" s)
let print_int d =
     print_string (sprintf "%d\n" d)
let print_bool b = 
     print_string (sprintf "%b\n" b)
let print_string_and_int s d =
     print_string (sprintf "%s%d\n" s d)

let is_nat x = if x >= 0 then true else false

val is_exisist : str:string -> char -> x:bool
let is_exisist str char = 
     let i = (index_of str char) in 
          if i = (-1) then 
               false
          else true

let data_from_client = "FROM: example2@icloud.com
To: example2@gmail.com
Subject: Test

Hello!!
...
Good by!!
.\n"

let _ = print_string "---DATA FROM CLIENT---\n"
let _ = print_string data_from_client
let _ = print_string "----------------------\n"

let colon = ':'
let header_field = "To: example2@gmail.com"

val int_index : int
let int_index = index_of header_field colon

val nat_index : nat
let nat_index =
     assert_norm(is_nat int_index);
     int_index + 1

val header_field_length : nat
let header_field_length = length header_field

val int_len_minus_index : int
let int_len_minus_index = header_field_length - nat_index

val nat_len_minus_index : nat
let nat_len_minus_index =
     assert_norm(is_nat int_len_minus_index);
     int_len_minus_index

let subStr =
     assert_norm(nat_index + nat_len_minus_index <= header_field_length);
     sub header_field nat_index nat_len_minus_index

let _ = print_string "subStr"; print_string subStr