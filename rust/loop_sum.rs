fn main() {
    let n = std::hint::black_box(100_000_000i32);
    let mut sum = 0i32;
    for i in 0..n {
        sum += (i * 3) / 7 % 1000;
    }
    println!("{}", sum);
}
