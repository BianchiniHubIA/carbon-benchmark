fn main() {
    let n = std::hint::black_box(40_000_000i32);
    let (mut a, mut b) = (0i32, 1i32);
    for _ in 0..n {
        let t = a + b;
        a = b;
        b = t;
    }
    println!("{}", a);
}
