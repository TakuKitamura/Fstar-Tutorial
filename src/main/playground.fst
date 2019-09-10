module Playground

open FStar.Int32
open LowStar.Printf

val three : Int32.t
let three = 1l +^ 2l

let main () =
printf "%s %l" "Hello LowStar!" three done;
C.EXIT_SUCCESS