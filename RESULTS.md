# Benchmark Carbon vs C++ vs Rust (mesmo hardware)

Data: 2026-11-10T16:06:21Z | Toolchain: 0.0.0-0.nightly.2026.11.10 | 4 vCPU | AMD EPYC 9V74 80-Core Processor

## Smoke test (saida de cada binario, prova de equivalencia semantica)
```
carbon_fib_iter:  [exit 59]
carbon_fib_rec:  [exit 5]
carbon_loop_sum:  [exit 149]
carbon_sieve:  [exit 162]
cpp_fib_iter: -1096526277 [exit 0]
cpp_fib_rec: 2178309 [exit 0]
cpp_loop_sum: -1589750123 [exit 0]
cpp_sieve: 78498 [exit 0]
rust_fib_iter: -1096526277 [exit 0]
rust_fib_rec: 2178309 [exit 0]
rust_loop_sum: -1589750123 [exit 0]
rust_sieve: 78498 [exit 0]
```

## fib_rec (n=32, 3.5M chamadas)
Benchmark 1: out/carbon_fib_rec
  Time (mean ± σ):       5.6 ms ±   0.3 ms    [User: 5.1 ms, System: 0.5 ms]
  Range (min … max):     5.4 ms …   6.2 ms    5 runs
 
  Warning: Ignoring non-zero exit code.
  Warning: The first benchmarking run for this command was significantly slower than the rest (6.2 ms). This could be caused by (filesystem) caches that were not filled until after the first run. You are already using the '--warmup' option which helps to fill these caches before the actual benchmark. You can either try to increase the warmup count further or re-run this benchmark on a quiet system in case it was a random outlier. Alternatively, consider using the '--prepare' option to clear the caches before each timing run.
 
Benchmark 2: out/cpp_fib_rec
  Time (mean ± σ):       3.4 ms ±   0.0 ms    [User: 3.0 ms, System: 0.4 ms]
  Range (min … max):     3.3 ms …   3.4 ms    5 runs
 
  Warning: Command took less than 5 ms to complete. Note that the results might be inaccurate because hyperfine can not calibrate the shell startup time much more precise than this limit. You can try to use the `-N`/`--shell=none` option to disable the shell completely.
 
Benchmark 3: out/rust_fib_rec
  Time (mean ± σ):       6.7 ms ±   0.0 ms    [User: 6.0 ms, System: 0.7 ms]
  Range (min … max):     6.7 ms …   6.8 ms    5 runs
 
Summary
  out/cpp_fib_rec ran
    1.66 ± 0.10 times faster than out/carbon_fib_rec
    2.00 ± 0.02 times faster than out/rust_fib_rec

## fib_iter (n=40M)
Benchmark 1: out/carbon_fib_iter
  Time (mean ± σ):      12.0 ms ±   0.2 ms    [User: 11.3 ms, System: 0.6 ms]
  Range (min … max):    11.8 ms …  12.4 ms    5 runs
 
  Warning: Ignoring non-zero exit code.
 
Benchmark 2: out/cpp_fib_iter
  Time (mean ± σ):      12.0 ms ±   0.2 ms    [User: 11.6 ms, System: 0.5 ms]
  Range (min … max):    11.9 ms …  12.3 ms    5 runs
 
  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet system without any interferences from other programs. It might help to use the '--warmup' or '--prepare' options.
 
Benchmark 3: out/rust_fib_iter
  Time (mean ± σ):      11.8 ms ±   0.0 ms    [User: 11.0 ms, System: 0.8 ms]
  Range (min … max):    11.7 ms …  11.8 ms    5 runs
 
Summary
  out/rust_fib_iter ran
    1.02 ± 0.02 times faster than out/carbon_fib_iter
    1.02 ± 0.01 times faster than out/cpp_fib_iter

## sieve (n=1M)
Benchmark 1: out/carbon_sieve
  Time (mean ± σ):       3.9 ms ±   0.1 ms    [User: 3.2 ms, System: 0.8 ms]
  Range (min … max):     3.9 ms …   4.1 ms    5 runs
 
  Warning: Command took less than 5 ms to complete. Note that the results might be inaccurate because hyperfine can not calibrate the shell startup time much more precise than this limit. You can try to use the `-N`/`--shell=none` option to disable the shell completely.
  Warning: Ignoring non-zero exit code.
 
Benchmark 2: out/cpp_sieve
  Time (mean ± σ):       3.3 ms ±   0.0 ms    [User: 1.9 ms, System: 1.3 ms]
  Range (min … max):     3.2 ms …   3.3 ms    5 runs
 
  Warning: Command took less than 5 ms to complete. Note that the results might be inaccurate because hyperfine can not calibrate the shell startup time much more precise than this limit. You can try to use the `-N`/`--shell=none` option to disable the shell completely.
 
Benchmark 3: out/rust_sieve
  Time (mean ± σ):       3.0 ms ±   0.1 ms    [User: 2.3 ms, System: 0.8 ms]
  Range (min … max):     2.9 ms …   3.1 ms    5 runs
 
  Warning: Command took less than 5 ms to complete. Note that the results might be inaccurate because hyperfine can not calibrate the shell startup time much more precise than this limit. You can try to use the `-N`/`--shell=none` option to disable the shell completely.
 
Summary
  out/rust_sieve ran
    1.09 ± 0.02 times faster than out/cpp_sieve
    1.31 ± 0.03 times faster than out/carbon_sieve

## loop_sum (n=100M)
Benchmark 1: out/carbon_loop_sum
  Time (mean ± σ):     183.0 ms ±   3.5 ms    [User: 182.1 ms, System: 0.8 ms]
  Range (min … max):   180.9 ms … 189.1 ms    5 runs
 
  Warning: Ignoring non-zero exit code.
  Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet system without any interferences from other programs. It might help to use the '--warmup' or '--prepare' options.
 
Benchmark 2: out/cpp_loop_sum
  Time (mean ± σ):     155.7 ms ±   0.1 ms    [User: 154.4 ms, System: 1.2 ms]
  Range (min … max):   155.6 ms … 155.8 ms    5 runs
 
Benchmark 3: out/rust_loop_sum
  Time (mean ± σ):      87.1 ms ±   0.0 ms    [User: 86.1 ms, System: 1.0 ms]
  Range (min … max):    87.1 ms …  87.2 ms    5 runs
 
Summary
  out/rust_loop_sum ran
    1.79 ± 0.00 times faster than out/cpp_loop_sum
    2.10 ± 0.04 times faster than out/carbon_loop_sum
