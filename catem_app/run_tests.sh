#!/usr/bin/env bash
# Corre la suite con cobertura y valida el umbral de domain/data (mismo criterio que el CI).
set -euo pipefail
cd "$(dirname "$0")"

flutter test --coverage "$@"
python3 tool/check_coverage.py coverage/lcov.info --min 70
