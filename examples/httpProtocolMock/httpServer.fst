module HttpServer

module B = LowStar.Buffer
module M = LowStar.Modifies
module U32 = FStar.UInt32

open FStar.HyperStack.ST
open LowStar.BufferOps

module HS = FStar.HyperStack
module ST = FStar.HyperStack.ST

open LowStar.Printf

type pointer t =
  b:B.buffer t { B.length b = 1 }

assume val bufstrcpy (b: B.buffer C.char) (s: C.String.t): Stack U32.t
  (requires (fun h ->
    B.live h b /\
    B.length b >= C.String.length s - 1))
  (ensures (fun h0 ret h1 ->
    B.live h1 b /\
    B.length b >= C.String.length s /\
    M.(modifies (loc_buffer b) h0 h1) /\
    U32.v ret = C.String.length s - 1 /\
    Seq.equal (Seq.slice (B.as_seq h1 b) 0 (U32.v ret)) (Seq.slice (C.String.v s) 0 (U32.v ret))))

assume val print_u32 (dst: B.buffer C.char) (i: U32.t): Stack U32.t
  (requires (fun h ->
    B.live h dst /\ B.length dst >= 10))
  (ensures (fun h0 ret h1 ->
    M.(modifies (loc_buffer dst) h0 h1) /\
    U32.v ret <= 10 /\
    B.live h1 dst))

inline_for_extraction noextract
let (!$) = C.String.of_literal

let zero_terminated (h: HS.mem) (b: B.buffer C.char) =
  let s = B.as_seq h b in
  B.length b > 0 /\
  B.length b <= FStar.UInt.max_int 32 /\
  C.uint8_of_char (Seq.index s (B.length b - 1)) = 0uy

val bufstrcmp (b: B.buffer C.char) (s: C.String.t): Stack bool
  (requires (fun h ->
    B.live h b /\
    zero_terminated h b))
  (ensures (fun h0 ret h1 ->
    B.live h1 b /\
    M.(modifies loc_none h0 h1) /\
    (ret = true ==> (
      let l = C.String.length s in
      B.length b >= l /\ (
      let b = B.as_seq h1 b in
      let s = C.String.v s in
      Seq.length b >= l /\
      Seq.equal (Seq.slice b 0 (l - 1)) (Seq.slice s 0 (l - 1)))))))

let bufstrcmp b s =
  let h0 = ST.get () in
  push_frame ();
  let h1 = ST.get () in
  let i: pointer U32.t = B.alloca 0ul 1ul in
  let h2 = ST.get () in
  let inv h stopped =
    B.live h i /\ B.live h b /\
    M.(modifies (loc_buffer i) h2 h) /\ (
    let i: U32.t = B.get h i 0 in
    U32.v i < B.length b /\ U32.v i < C.String.length s /\
    (forall (j: U32.t). {:pattern (B.get h b (U32.v j)) } U32.lt j i ==>
      B.get h b (U32.v j) = C.String.get s j) /\
    (if stopped then
      C.String.get s i = C.char_of_uint8 0uy \/ C.String.get s i <> B.get h b (U32.v i)
    else
      True))
  in
  let body (): Stack bool
    (requires (fun h -> inv h false))
    (ensures (fun h1 b h2 -> inv h1 false /\ inv h2 b))
  =
    let cb = b.(i.(0ul)) in
    let cs = C.String.get s i.(0ul) in
    if cb <> cs || cs = C.char_of_uint8 0uy then
      true
    else begin
      let h = ST.get () in
      assert (
        let i: U32.t = B.get h i 0 in
        U32.v i < C.String.length s - 1
      );
      assert (C.String.well_formed (C.String.v s));
      assert (
        let i: U32.t = B.get h i 0 in
        forall (j: U32.t). {:pattern (B.get h b (U32.v j)) } U32.lt j i ==>
          B.get h b (U32.v j) = C.String.get s j);
      i.(0ul) <- U32.( i.(0ul) +^ 1ul );
      let h' = ST.get () in
      assert (forall (j: U32.t). {:pattern (B.get h' b (U32.v j))}
        let i: U32.t = B.get h' i 0 in
        U32.lt j i /\ B.get h b (U32.v j) = C.String.get s j ==>
        U32.lt j i /\ B.get h' b (U32.v j) = C.String.get s j);
      assert (
        let iplus1: U32.t = B.get h' i 0 in
        (forall (j: U32.t). {:pattern (B.get h b (U32.v j)) } U32.lt j iplus1 ==>
          B.get h b (U32.v j) = C.String.get s j));
      assert (
        let iplus1: U32.t = B.get h' i 0 in
        (forall (j: U32.t). {:pattern (B.get h' b (U32.v j)) } U32.lt j iplus1 ==>
          B.get h' b (U32.v j) = C.String.get s j));
      false
    end
  in
  C.Loops.do_while inv body;
  let r = C.String.get s (i.(0ul)) = C.char_of_uint8 0uy in
  let h3 = ST.get () in
  assert (forall (b: B.buffer C.char) (i: nat{ i < B.length b }).
    {:pattern (Seq.index (B.as_seq h3 b) i)}
    Seq.index (B.as_seq h3 b) i == B.get h3 b i);
  assert (forall (s: C.String.t) (i: nat { i < C.String.length s }).
    {:pattern (Seq.index (C.String.v s) i)}
    Seq.index (C.String.v s) i == C.String.get s (U32.uint_to_t i));
  assert (
    let i = U32.v (B.get h3 i 0) in
    (forall (j: nat).
      {:pattern (Seq.index (B.as_seq h3 b) j)}
      j < i ==> Seq.index (B.as_seq h3 b) j == Seq.index (C.String.v s) j)
  );
  assert (
    let i = U32.v (B.get h3 i 0) in
    (forall (j: nat).
      {:pattern (Seq.index (Seq.slice (B.as_seq h3 b) 0 i) j)}
      j < i ==> Seq.index (Seq.slice (B.as_seq h3 b) 0 i) j == Seq.index (Seq.slice (C.String.v s) 0 i) j)
  );
  assert (
    let i = U32.v (B.get h3 i 0) in
    Seq.equal (Seq.slice (B.as_seq h3 b) 0 i) (Seq.slice (C.String.v s) 0 i)
  );
  pop_frame ();
  let h4 = ST.get () in
  r

val respond: (response: B.buffer C.char) -> (payload: B.buffer C.char) -> (payloadlen: U32.t) ->
  Stack U32.t
    (requires (fun h0 ->
      B.length payload >= U32.v payloadlen /\
      B.live h0 response /\
      B.live h0 payload /\
      B.disjoint response payload /\
      B.length response > 128 + U32.v payloadlen
    ))
    (ensures (fun h0 n h1 ->
      B.live h1 response /\
      B.live h1 payload /\
      B.disjoint response payload /\
      M.(modifies (M.loc_buffer response) h0 h1) /\
      U32.v n <= 128 + U32.v payloadlen
    ))

let respond response payload payloadlen =
  let n1 = bufstrcpy response !$"HTTP/1.1 200 OK\r\nConnection: closed\r\nContent-Length:" in
  let response = B.offset response n1 in
  let n2 = print_u32 response payloadlen in
  let response = B.offset response n2 in
  let n3 = bufstrcpy response !$"\r\nContent-Type: text/html; charset=utf-8\r\n\r\n" in
  let response = B.offset response n3 in
  let t = blit payload 0ul response 0ul payloadlen in
  U32.(n1 +^ n2 +^ n3 +^ payloadlen)

#reset-options "--z3cliopt smt.arith.nl=false --z3rlimit 50 --max_ifuel 0 --max_fuel 0"

let respond_404 (response: B.buffer C.char): Stack U32.t
  (requires (fun h0 ->
    B.live h0 response /\
    B.length response >= 512))
  (ensures (fun h0 n h1 ->
    B.live h1 response /\
    M.(modifies (loc_buffer response) h0 h1) /\
    U32.v n <= 512)) =
  push_frame ();
  let payload = B.alloca (C.char_of_uint8 0uy) 256ul in
  let payloadlen = bufstrcpy payload !$"<html>Page not found</html>" in
  let n1 = bufstrcpy response !$"HTTP/1.1 404 Not Found\r\nConnection: closed\r\nContent-Length:" in
  let response = B.offset response n1 in
  let n2 = print_u32 response payloadlen in
  let response = B.offset response n2 in
  let n3 = bufstrcpy response !$"\r\nContent-Type: text/html; charset=utf-8\r\n\r\n" in
  let response = B.offset response n3 in
  let t = blit payload 0ul response 0ul payloadlen in
  let n = U32.(n1+^n2+^n3+^payloadlen) in
  pop_frame ();
  n

unfold noextract
let request_length = 2048

unfold noextract
let response_length = 2048

val httpServerLib (request response: B.buffer C.char):
  Stack U32.t
    (requires (fun h ->
      B.live h request /\ B.live h response /\
      B.disjoint request response /\
      zero_terminated h request /\
      B.length request = request_length /\
      B.length response = response_length))
    (ensures (fun h0 _ h1 ->
      B.live h1 request /\ B.live h1 response))

let httpServerLib request response =
  push_frame ();
  let n =
    let payload = B.alloca (C.char_of_uint8 0uy) 256ul in
      if (bufstrcmp request !$"GET ") then
        let request = B.offset request 4ul in
        if bufstrcmp request !$"/ " then
          let payloadlen = bufstrcpy payload !$"<html><h1>Hi.<br>It works!</h1></html>" in
          respond response payload payloadlen 
        else if bufstrcmp request !$"/hello" then
          let payloadlen = bufstrcpy payload !$"<html><script>alert('Hello F*!')</script><h1>Hello!</h1></html>" in
          respond response payload payloadlen 
        else
          respond_404 response
      else if (bufstrcmp request !$"POST ") then
        let request = B.offset request 5ul in
        if bufstrcmp request !$"/data" then
          let payloadlen = bufstrcpy payload !$"<html><h1>I received data!</h1></html>" in
          respond response payload payloadlen 
        else
          respond_404 response
      else
        let n = bufstrcpy response !$"invalid request." in
        n
  in
  pop_frame ();
  n