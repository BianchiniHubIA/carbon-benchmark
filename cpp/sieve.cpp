#include <cstdio>
#include <vector>

int main() {
  const int n = 1000000;
  std::vector<char> p(n, 1);
  int count = 0;
  for (int i = 2; i < n; ++i) {
    if (p[i]) {
      ++count;
      for (int j = i * 2; j < n; j += i) p[j] = 0;
    }
  }
  printf("%d\n", count);
  return 0;
}
