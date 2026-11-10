import Core library "io";

fn Fib(n: i32) -> i32 {
  var a: i32 = 0;
  var b: i32 = 1;
  var i: i32 = 0;
  while (i < n) {
    var tmp: i32 = a + b;
    a = b;
    b = tmp;
    ++i;
  }
  return a;
}

fn Run() -> i32 {
  return Fib(40000000);
}
