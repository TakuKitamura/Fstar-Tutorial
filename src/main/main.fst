module Main
open FStar.IO
open FStar.Printf
open FStar.All

open FStar.String

// #set-options "--initial_fuel 1000 --initial_ifuel 1000 --max_fuel 1000 --max_ifuel 1000 --min_fuel 1000"

let print_string s =
     print_string (sprintf "%s" s)
let print_int d =
     print_string (sprintf "%d\n" d)
let print_bool b = 
     print_string (sprintf "%b\n" b)
     
let print_string_and_int s d =
     print_string (sprintf "%s%d\n" s d)

val strFixedN :
     n:nat -> 
     str:string{(List.length (list_of_string str)) = n} ->
     str:string{(List.length (list_of_string str)) = n}

let strFixedN n str = str

let strFixed str = strFixedN (List.length (list_of_string str)) str

// let subStr = let s = strFixed "ABCDE" in sub s 0 5

exception InvalidIntRange
val int_to_nat : x:int -> ML nat
let int_to_nat x = if x < 0 then raise InvalidIntRange else x

let data_from_client = "FROM: example2@icloud.com
To: example2@gmail.com
Subject: Test

Hello!!
...
Good by!!
.\n"

exception InvalidHeadField

let _ = print_string "---DATA FROM CLIENT---\n"
let _ = print_string data_from_client

let colon = ':'
let header_field = "To: example2@gmail.com"

// val checkedRead : filename -> ML string
// val is_exisist : str:string{length str > 0} -> char -> x:bool
val is_exisist : str:string -> char -> x:bool
let is_exisist str char = 
     let i = (index_of str char) in 
          if i = (-1) then 
               false
          else true

val get_index : str:string -> char -> ML int
let get_index str char = 
     let can_get_index = is_exisist str char in
          if can_get_index then
               index_of str char 
          else raise InvalidHeadField

val index : nat
let index = int_to_nat (get_index header_field colon)

val header_field_length : nat
let header_field_length = int_to_nat(length header_field)

let _ = print_int index

let _ = print_string_and_int "header_field_length: " ( length header_field ) // 29
let _ = print_string_and_int "index: " index // 2


let s = strFixed "ABCDEFGHIJKLMNOPQR"

val subStr : string
let subStr = sub s 0 5

let _ = print_string subStr
