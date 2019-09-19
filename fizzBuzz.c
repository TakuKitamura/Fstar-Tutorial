#include <stdio.h>
#include <string.h>

# define N 10

void create_fizzBuzz_array(char fizzBuzz_array[N][10], u_int32_t n) {
    u_int32_t i;
    for (i = 0; i < n; i++) {
        u_int32_t count = (i + 1);
        if (count % 15 == 0) {
            char fizzBuzz[] = "FizzBuzz";
            snprintf(fizzBuzz_array[i], strlen(fizzBuzz) + 1, "%s", fizzBuzz);
        } else if (count % 3 == 0) {
            char fizz[] = "Fizz";
            snprintf(fizzBuzz_array[i], strlen(fizz) + 1, "%s", fizz);
        } else if (count % 5 == 0) {
            char buzz[] = "Buzz";
            snprintf(fizzBuzz_array[i], strlen(buzz) + 1, "%s", buzz);
        } else {
            char empty[] = "";
            snprintf(fizzBuzz_array[i], strlen(empty) + 1, "%s", empty);
        }
    }
}

void decorate_fizzBuzz_array(char fizzBuzz_array[N][10], u_int32_t n) {
    u_int32_t i;
    for (i = 0; i < n; i++) { 
        if (strlen (fizzBuzz_array[i]) != 0) {
            printf("%s\n", fizzBuzz_array[i]);
        } else {
            printf("%d\n", (i+1));
        }
    }
}

int main(void) {
    char fizzBuzz_array[N][10];
    create_fizzBuzz_array(fizzBuzz_array, N);
    decorate_fizzBuzz_array(fizzBuzz_array, N);
    return 0;
}