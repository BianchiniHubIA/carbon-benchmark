fn main() {
    const N: usize = 1_000_000;
    let mut p = vec![true; N];
    let mut count = 0;
    for i in 2..N {
        if p[i] {
            count += 1;
            let mut j = i * 2;
            while j < N {
                p[j] = false;
                j += i;
            }
        }
    }
    println!("{}", count);
}
