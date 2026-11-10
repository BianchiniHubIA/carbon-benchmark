#include <cstdio>

int fib(int n) {
  return n < 2 ? n : fib(n - 1) + fib(n - 2);
}

int main() {
  volatile int n = 32;
  int r = fib(n);
  printf("%d\n", r);
  return 0;
}
