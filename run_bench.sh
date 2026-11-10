#!/usr/bin/env bash
set -uo pipefail

cd "$(dirname "$0")"

CARBON_VERSION="0.0.0-0.nightly.2026.11.10"
CARBON_TAR="carbon_toolchain-${CARBON_VERSION}.tar.gz"
CARBON_DIR="carbon_toolchain-${CARBON_VERSION}"

echo "==> CPU: $(lscpu | grep 'Model name' | sed 's/.*: *//') | $(nproc) vCPU"

# 1. Toolchain Carbon
if [ ! -d "$CARBON_DIR" ]; then
  echo "==> Baixando toolchain Carbon ${CARBON_VERSION}"
  wget -q "https://github.com/carbon-language/carbon-lang/releases/download/v${CARBON_VERSION}/${CARBON_TAR}" || exit 1
  tar -xf "$CARBON_TAR" || exit 1
fi

# 2. Dependencia de link
sudo apt-get install -y -qq libgcc-11-dev >/dev/null 2>&1 || sudo apt-get install -y -qq libgcc-12-dev >/dev/null 2>&1 || true

# 3. hyperfine
if ! command -v hyperfine >/dev/null 2>&1; then
  sudo apt-get install -y -qq hyperfine >/dev/null 2>&1 || true
fi

mkdir -p out

# 4. Compila Carbon
for f in carbon/*.carbon; do
  name=$(basename "$f" .carbon)
  echo "==> Compilando Carbon: $name"
  if "./${CARBON_DIR}/bin/carbon" compile --output="out/${name}.o" "$f" 2> "out/${name}.compile.log"; then
    "./${CARBON_DIR}/bin/carbon" link --output="out/carbon_${name}" "out/${name}.o" 2>> "out/${name}.compile.log" || echo "FALHOU LINK: $name"
  else
    echo "FALHOU COMPILE: $name (log em out/${name}.compile.log)"
  fi
done

# 5. Compila C++
for f in cpp/*.cpp; do
  name=$(basename "$f" .cpp)
  echo "==> Compilando C++: $name"
  g++ -O2 -o "out/cpp_${name}" "$f" || echo "FALHOU: $name"
done

# 6. Compila Rust
if command -v rustc >/dev/null 2>&1; then
  for f in rust/*.rs; do
    name=$(basename "$f" .rs)
    echo "==> Compilando Rust: $name"
    rustc -O -o "out/rust_${name}" "$f" || echo "FALHOU: $name"
  done
fi

# 7. Smoke test: rodar cada um 1x (confere saida igual)
echo ""
echo "==> Smoke test (saidas)"
for exe in out/carbon_* out/cpp_* out/rust_*; do
  [ -x "$exe" ] || continue
  echo "$(basename "$exe"): $(timeout 120 "$exe" 2>&1 | head -c 80)"
done

# 8. Benchmark
run_one() {
  local label="$1"; shift
  local cmds=()
  for exe in "$@"; do
    [ -x "$exe" ] && cmds+=("$exe")
  done
  if [ ${#cmds[@]} -gt 0 ]; then
    echo ""
    echo "## $label"
    hyperfine --warmup 1 --runs 5 "${cmds[@]}" 2>&1 || true
  fi
}

{
  echo "# Benchmark Carbon vs C++ vs Rust (mesmo hardware)"
  echo ""
  echo "Data: $(date -u +%Y-%m-%dT%H:%M:%SZ) | Toolchain: ${CARBON_VERSION} | $(nproc) vCPU | $(lscpu | grep 'Model name' | sed 's/.*: *//')"
  echo ""
  run_one "fib_rec (n=32, 3.5M chamadas)" out/carbon_fib_rec out/cpp_fib_rec out/rust_fib_rec
  run_one "fib_iter (n=40M)" out/carbon_fib_iter out/cpp_fib_iter out/rust_fib_iter
  run_one "sieve (n=1M)" out/carbon_sieve out/cpp_sieve out/rust_sieve
  run_one "loop_sum (n=100M)" out/carbon_loop_sum out/cpp_loop_sum out/rust_loop_sum
} | tee RESULTS.md

echo ""
echo "==> FIM"
