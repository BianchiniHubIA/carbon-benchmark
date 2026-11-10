import Core library "io";

class Sieve {
  impl as Core.UnformedInit {}

  fn Make() -> Sieve {
    returned var s: Sieve;
    for (n: i32 in Core.Range(1000000)) {
      s.is_prime[n] = true;
    }
    return var;
  }

  fn MarkMultiplesNotPrime(ref self, p: i32) {
    var n: i32 = p * 2;
    while (n < 1000000) {
      self.is_prime[n] = false;
      n += p;
    }
  }

  var is_prime: array(bool, 1000000);
}

fn Run() -> i32 {
  var s: Sieve = Sieve.Make();

  var number_of_primes: i32 = 0;
  for (n: i32 in Core.InclusiveRange(2, 999999)) {
    if (s.is_prime[n]) {
      ++number_of_primes;
      s.MarkMultiplesNotPrime(n);
    }
  }

  return number_of_primes;
}
