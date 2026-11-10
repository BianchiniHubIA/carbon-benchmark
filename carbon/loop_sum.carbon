import Core library "io";

fn Run() -> i32 {
  var sum: i32 = 0;
  for (i: i32 in Core.Range(100000000)) {
    sum += ((i * 3) / 7) % 1000;
  }
  return sum;
}
