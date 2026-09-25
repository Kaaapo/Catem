#!/usr/bin/env python3
"""Falla si la cobertura de lineas en las capas domain y data baja del minimo."""

import argparse
import sys
from pathlib import Path

LAYER_MARKERS = ("/domain/", "/data/")
GENERATED_SUFFIXES = (".g.dart", ".freezed.dart")


def parse_lcov(path: Path) -> dict[str, tuple[int, int]]:
    files: dict[str, tuple[int, int]] = {}
    current = None
    found = hit = 0
    for line in path.read_text().splitlines():
        if line.startswith("SF:"):
            current = line[3:]
            found = hit = 0
        elif line.startswith("LF:"):
            found = int(line[3:])
        elif line.startswith("LH:"):
            hit = int(line[3:])
        elif line == "end_of_record" and current:
            files[current] = (hit, found)
            current = None
    return files


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("lcov", type=Path)
    parser.add_argument("--min", type=float, default=70.0)
    args = parser.parse_args()

    if not args.lcov.exists():
        print(f"No existe {args.lcov}; corre `flutter test --coverage` primero.")
        return 1

    files = parse_lcov(args.lcov)
    per_layer: dict[str, list[int]] = {"domain": [0, 0], "data": [0, 0]}
    for name, (hit, found) in files.items():
        if name.endswith(GENERATED_SUFFIXES):
            continue
        for marker in LAYER_MARKERS:
            if marker in name:
                layer = marker.strip("/")
                per_layer[layer][0] += hit
                per_layer[layer][1] += found

    failed = False
    for layer, (hit, found) in per_layer.items():
        if found == 0:
            print(f"{layer}: sin archivos instrumentados")
            continue
        pct = 100.0 * hit / found
        status = "OK" if pct >= args.min else "BAJO"
        print(f"{layer}: {pct:.1f}% ({hit}/{found} lineas) {status}")
        failed |= pct < args.min

    if failed:
        print(f"Cobertura por debajo del minimo ({args.min:.0f}%).")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
