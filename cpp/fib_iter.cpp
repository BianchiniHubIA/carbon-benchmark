#include <cstdio>

int main() {
  volatile int n = 40000000;
  int a = 0, b = 1;
  for (int i = 0; i < n; ++i) {
    int t = a + b;
    a = b;
    b = t;
  }
  printf("%d\n", a);
  return 0;
}
