#include <stdio.h>
#include <stdlib.h>
#include <sys/fcntl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>

#include "HttpServer.h"

static int sockfd;
static int new_sockfd;

void http(int sockfd) {
  char request[2048] = {0};
  char response[2048] = {0};

  if ((read(sockfd, request, sizeof(request))) <= 0) {
    perror("reading a request.");
    return;
  }


  // val httpServerLib (request response: B.buffer C.char):
  //   Stack U32.t
  //     (requires (fun h ->
  //       B.live h request /\ B.live h response /\
  //       B.disjoint request response /\
  //       zero_terminated h request /\
  //       B.length request = request_length /\
  //       B.length response = response_length))
  //     (ensures (fun h0 _ h1 ->
  //       B.live h1 request /\ B.live h1 response))
  httpServerLib((char *) request, response);

  if (write(sockfd, response, strlen(response)) != strlen(response)) {
    perror("writing a response .");
    return;
  }

  if (close(sockfd) == -1) {
    perror("close socket in http()");
  }

  return;
}

void signalHandler(int signal){
    fprintf(stderr,"\nEXIT SIGNAL:%d\n",signal);

    if (close(sockfd) == -1) {
        perror("close sockfd in signalHandler().");
    }

    puts("HTTP Server Stop.");
    exit(EXIT_SUCCESS);
}

int main(int argc, char *argv[]) {

  signal( SIGINT, signalHandler);

  int writer_len;

  struct sockaddr_in reader_addr;
  struct sockaddr_in writer_addr;

  memset(&reader_addr, 0, sizeof(reader_addr));
  memset(&writer_addr, 0, sizeof(writer_addr));

  reader_addr.sin_family      = AF_INET;
  reader_addr.sin_addr.s_addr = htonl(INADDR_ANY);
  reader_addr.sin_port        = htons(80);

  if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
      perror("socket()");
      return 1;
  }

  int optval = 1;
  if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, (const char *)&optval, sizeof(optval)) == -1) {
      perror("setsockopt()");
      return 1;
  }

  if (bind(sockfd, (struct sockaddr *)&reader_addr, sizeof(reader_addr)) < 0) {
      perror("bind()");
      if (close(sockfd) == -1) {
        perror("close socket.");
      }
      return 1;
  }

  if (listen(sockfd, 5) < 0) {
      perror("listen()");
      if (close(sockfd) == -1) {
        perror("close socket.");
      }
      return 1;
  }

  puts("Listening on http://localhost");

  while(1) {
      if ((new_sockfd = accept(sockfd, (struct sockaddr *)&writer_addr, (socklen_t *)&writer_len)) < 0) {
          perror("accepting a socket.");

          if (close(sockfd) == -1) {
              perror("close sockfd.");
          }
          break;
      }

      http(new_sockfd);
  }

  return 1;
}