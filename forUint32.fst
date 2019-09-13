module ForUint32

open LowStar.Printf
open LowStar.BufferOps
open FStar.HyperStack.ST

module S = FStar.Seq
module B = LowStar.Buffer
module LB = LowStar.Monotonic.Buffer
module M = LowStar.Modifies
module U32 = FStar.UInt32
module ST = FStar.HyperStack.ST

val normal_loop: src:B.buffer U32.t -> len:U32.t -> Stack string
  (requires fun h0 -> B.live h0 src /\ B.length src = U32.v len )
  (ensures fun _ _ _ -> true)
let normal_loop src len =
  let inv h (i: nat) = B.live h src in
  let body (i: U32.t{ 0 <= U32.v i /\ U32.v i < U32.v len }): Stack unit
    (requires (fun h -> inv h (U32.v i)))
    (ensures (fun _ _ _ -> true))
  =
    let v : U32.t = src.(i) in
    printf "%ul\n" v done
  in
  C.Loops.for 0ul len inv body;
  (* return *) "r='LOOP DONE!'\n"

let main ()
=
  push_frame ();
  // let src = B.alloca_of_list a in
  // let len: U32.t = U32.uint_to_t (FStar.List.Tot.length a)  in
  let listSize = 10ul in
  let fillData = 777ul in
  let src = B.alloca fillData listSize in
  let r = (normal_loop src listSize) in
  print_string r;
  pop_frame ();
  C.EXIT_SUCCESS
