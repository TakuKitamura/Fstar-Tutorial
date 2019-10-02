#include <stdio.h>
#include <stdlib.h>

#include "FizzBuzz.h"

#define MAX_N 100000U

int fizzBuzz(uint32_t n) {
    if (n == 0U || n > MAX_N) {
        printf("n is out of range. (n: U32.t{ 0 < U32.v n /\\ U32.v n < 100000})\n");
        return 1;
    }
    // val fizzBuzz : n: U32.t{ 0 < U32.v n /\ U32.v n < 100000} -> Stack C.exit_code (fun _ -> True) (fun _ _ _ -> True)
    return fizzBuzzLib(n);
}

int main(int argc, char *argv[]) {
    int r = fizzBuzz(30U);
    return r;
}
