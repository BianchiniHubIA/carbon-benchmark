# Carbon Benchmark

Benchmark comparativo: **Carbon Language** (toolchain nightly) vs **C++** (g++ -O2) vs **Rust** (rustc -O), no mesmo hardware (GitHub Codespaces).

4 microbenchmarks com a mesma semântica nas 3 linguagens:

| Benchmark | O que mede |
|---|---|
| `fib_rec` (n=32) | Chamadas de função + recursão (~3,5M chamadas) |
| `fib_iter` (n=40M) | Loop com carry dependency |
| `sieve` (n=1M) | Crivo de Eratóstenes, acesso aleatório a memória |
| `loop_sum` (n=100M) | Aritmética de inteiros em loop massivo |

## Como rodar

```bash
bash run_bench.sh
```

Resultados em `RESULTS.md`. O script baixa o toolchain nightly do Carbon, compila tudo e roda `hyperfine` (5 runs, 1 warmup).

## Estrutura

```
carbon/  fib_rec.carbon  fib_iter.carbon  sieve.carbon  loop_sum.carbon
cpp/     fib_rec.cpp     fib_iter.cpp     sieve.cpp     loop_sum.cpp
rust/    fib_rec.rs      fib_iter.rs      sieve.rs      loop_sum.rs
run_bench.sh  RESULTS.md
```
