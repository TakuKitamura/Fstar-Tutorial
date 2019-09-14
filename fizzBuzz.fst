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

val create_fizzBuzz_array: fizzBuzz_array:B.buffer string -> n:U32.t -> Stack C.exit_code
(requires fun h0 -> B.live h0 fizzBuzz_array /\ B.length fizzBuzz_array = U32.v n )
(ensures fun _ _ _ -> true)
let create_fizzBuzz_array fizzBuzz_array n =
  let inv h (i: nat) = B.live h fizzBuzz_array in
  let body (i: U32.t{ 0 <= U32.v i /\ U32.v i < U32.v n }): Stack unit
    (requires (fun h -> inv h (U32.v i)))
    (ensures (fun _ _ _ -> true))
  =
    let v : string = fizzBuzz_array.(i) in
    let count: U32.t = U32.(i +^ 1ul) in
    let fillStr (x:string) = fizzBuzz_array.(i) <- x in
    let u32Mod (a: U32.t) (b: U32.t{b <> 0ul}) = U32.uint_to_t (U.mod (U32.v a) (U32.v b)) in
      if u32Mod count 15ul = 0ul then (fillStr "FizzBuzz")  
      else if u32Mod count 3ul = 0ul then (fillStr "Fizz")  
      else if u32Mod count 5ul = 0ul then (fillStr "Buzz") 
  in
  C.Loops.for 0ul n inv body;
  C.EXIT_SUCCESS

val decorate_fizzBuzz_array: fizzBuzz_array:B.buffer string -> n:U32.t -> Stack C.exit_code
  (requires fun h0 -> B.live h0 fizzBuzz_array /\ B.length fizzBuzz_array = U32.v n )
  (ensures fun _ _ _ -> true)
let decorate_fizzBuzz_array fizzBuzz_array n =
  let inv h (i: nat) = B.live h fizzBuzz_array in
  let body (i: U32.t{ 0 <= U32.v i /\ U32.v i < U32.v n }): Stack unit
    (requires (fun h -> inv h (U32.v i)))
    (ensures (fun _ _ _ -> true))
  =
    let v : string = fizzBuzz_array.(i) in
    let count: U32.t = U32.(i +^ 1ul) in
    if v = "" then printf "%ul\n" count done
    else printf "%s\n" v  done
  in
  C.Loops.for 0ul n inv body;
  C.EXIT_SUCCESS

let main ()
=
  push_frame ();
  let n = 30ul in
  let fillData = "" in
  let fizzBuzz_array = B.alloca fillData n in
  let _ = create_fizzBuzz_array fizzBuzz_array n in
  let _ = decorate_fizzBuzz_array fizzBuzz_array n in
  pop_frame ();
  C.EXIT_SUCCESS
