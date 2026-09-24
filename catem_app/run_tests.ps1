# Corre la suite con cobertura y valida el umbral de domain/data (mismo criterio que el CI).
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

flutter test --coverage @args
python tool/check_coverage.py coverage/lcov.info --min 70
