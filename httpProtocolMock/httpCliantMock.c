#include <stdio.h>
#include <stdlib.h>

#include "HttpProtocolMock.h"

int main(int argc, char *argv[]) {
  if (argc != 2) {
    puts("./a.out '(GET|POST) REQUEST'");
    return 1;
  }

  char response[2048];
  const char *request = argv[1];
  uint32_t n = server((char *) request, response);

  FILE *fp;

  fp = fopen("/tmp/response.txt", "w");
  if (fp == NULL) {
    puts("cannot open file.");
    return 1;
  }

  fprintf(fp, "%s", response);

  uint32_t r_count = 0;
  uint32_t n_count = 0;

  for (int i = 0; i < strlen(response); i++)
  {
    if (response[i] == '\r') {
      r_count++;
    } else if (response[i] == '\n') {
      n_count++;
    } else {
      if (r_count == 2 && n_count == 2) {
        for (int j = i; j < strlen(response); j++) {
          printf("%c", response[j]);
        }
        puts("");
        return 0;
      } else {
        r_count = 0;
        n_count = 0;
      }
    }
  }
  puts("request may be invalid.");
  return 1;
}
