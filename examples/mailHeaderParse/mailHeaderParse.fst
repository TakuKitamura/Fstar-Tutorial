module MailHeaderParse
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

let is_nat x = if x >= 0 then true else false // x >= 0 であるか判定
let colon = ':' // セパレート文字
let header_field = "To: example@mail.com" // □example@mail.comを切り出したい

val int_index : int // colon のインデックスを取得(存在しなければ-1が返る)
let int_index = index_of header_field colon

val nat_index : nat // 文字列切り出しの､初めのインデックス
let nat_index = assert_norm(is_nat int_index); // 0以上であるか確認
     int_index + 1

val header_field_length : nat // header_field の文字長
let header_field_length = length header_field

val nat_len_minus_index : nat // nat_index から末尾までの文字長
let nat_len_minus_index = 
     assert_norm(is_nat (header_field_length - nat_index)); // 0以上であるか確認
     (header_field_length - nat_index)

let _ = print_int nat_index
let _ = print_int nat_len_minus_index
let _ = print_int header_field_length
let subStr = assert_norm(header_field_length = nat_index + nat_len_minus_index); sub header_field nat_index nat_len_minus_index // 文字列切り出し
let _ = print_string "subStr"; print_string subStr // 出力: subStr example@gmail.com

