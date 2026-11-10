import Core library "io";

fn Fib(n: i32) -> i32 {
  if (n < 2) {
    return n;
  }
  return Fib(n - 1) + Fib(n - 2);
}

fn Run() -> i32 {
  return Fib(32);
}
