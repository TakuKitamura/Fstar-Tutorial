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

val fizz_buzz: len:U32.t -> Stack C.exit_code
  (requires fun _ -> true)
  (ensures fun _ _ _ -> true)
let fizz_buzz len =
  let inv h (i: nat) = bool in
  let body (i: U32.t{ 0 <= U32.v i /\ U32.v i < U32.v len }): Stack unit
    (requires (fun _ -> true))
    (ensures (fun _ _ _ -> true))
  =
    let count: U32.t = U32.(i +^ 1ul) in
    let u32Mod (a: U32.t) (b: U32.t{b <> 0ul}) = U32.uint_to_t (U.mod (U32.v a) (U32.v b)) in

    if u32Mod count 15ul = 0ul then printf "%ul: FizzBuzz\n" count done
    else if u32Mod count 3ul = 0ul then printf "%ul: Fizz\n" count done
    else if u32Mod count 5ul = 0ul then printf "%ul: Buzz\n" count done
    else printf "%ul: \n" count done
  in
  C.Loops.for 0ul len inv body;
  (* return *) C.EXIT_SUCCESSl

let main ()
=
  let _ = fizz_buzz 30ul in
  C.EXIT_SUCCESS
