#include <cstdio>

int main() {
  volatile int n = 100000000;
  int sum = 0;
  for (int i = 0; i < n; ++i) sum += (i * 3) / 7 % 1000;
  printf("%d\n", sum);
  return 0;
}
