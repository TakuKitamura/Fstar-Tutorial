module FizzBuzz

open LowStar.Printf
open LowStar.BufferOps
open FStar.HyperStack.ST

module S = FStar.Seq
module B = LowStar.Buffer
module LB = LowStar.Monotonic.Buffer
module M = LowStar.Modifies
module U = FStar.UInt
module U32 = FStar.UInt32
module ST = FStar.HyperStack.ST

val create_fizzBuzz_array: src:B.buffer string -> n:U32.t -> Stack C.exit_code
(requires fun h0 -> B.live h0 src /\ B.length src = U32.v n )
(ensures fun _ _ _ -> true)
let create_fizzBuzz_array src n =
  let inv h (i: nat) = B.live h src in
  let body (i: U32.t{ 0 <= U32.v i /\ U32.v i < U32.v n }): Stack unit
    (requires (fun h -> inv h (U32.v i)))
    (ensures (fun _ _ _ -> true))
  =
    let v : string = src.(i) in
    let count: U32.t = U32.(i +^ 1ul) in
    let fillStr (x:string) = src.(i) <- x in
    let u32Mod (a: U32.t) (b: U32.t{b <> 0ul}) = U32.uint_to_t (U.mod (U32.v a) (U32.v b)) in
      if u32Mod count 15ul = 0ul then (fillStr "FizzBuzz")  
      else if u32Mod count 3ul = 0ul then (fillStr "Fizz")  
      else if u32Mod count 5ul = 0ul then (fillStr "Buzz") 
  in
  C.Loops.for 0ul n inv body;
  (* return *) C.EXIT_SUCCESS

val decorate_fizzBuzz_array: src:B.buffer string -> n:U32.t -> Stack C.exit_code
  (requires fun h0 -> B.live h0 src /\ B.length src = U32.v n )
  (ensures fun _ _ _ -> true)
let decorate_fizzBuzz_array src n =
  let inv h (i: nat) = B.live h src in
  let body (i: U32.t{ 0 <= U32.v i /\ U32.v i < U32.v n }): Stack unit
    (requires (fun h -> inv h (U32.v i)))
    (ensures (fun _ _ _ -> true))
  =
    let v : string = src.(i) in
    let count: U32.t = U32.(i +^ 1ul) in
    printf "%ul: %s\n" count v done
  in
  C.Loops.for 0ul n inv body;
  (* return *) C.EXIT_SUCCESS

let main ()
=
  push_frame ();
  let n = 10ul in
  let fillData = "" in
  let src = B.alloca fillData n in
  let _ = create_fizzBuzz_array src n in
  let _ = decorate_fizzBuzz_array src n in
  pop_frame ();
  C.EXIT_SUCCESS
