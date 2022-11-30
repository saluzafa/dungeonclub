import 'dart:math';

import 'package:dungeonclub/measuring/ruleset.dart';
import 'package:grid/grid.dart';
import 'package:test/test.dart';

void main() {
  group('Default Hex Ruleset', () {
    final ruleset = MeasuringRuleset.hexDefault;
    final gridH = HexagonalGrid(1, horizontal: true);
    final gridV = HexagonalGrid(1, horizontal: false);

    test('Center with even Y', () {
      final expected = [
        [0x4, 3, 3, 3, 3, 4, 5],
        [4, 3, 2, 2, 2, 3, 4],
        [0x3, 2, 1, 1, 2, 3, 4],
        [3, 2, 1, 0, 1, 2, 3],
        [0x3, 2, 1, 1, 2, 3, 4],
        [4, 3, 2, 2, 2, 3, 4],
        [0x4, 3, 3, 3, 3, 4, 5],
      ];

      expect(
        getDistances(Point(-1, -1), Point(5, 5), Point(2, 2), gridV, ruleset),
        expected,
      );
    });

    test('Center with even Y (Horizontal)', () {
      final expected = [
        [0x4, 4, 3, 3, 3, 4, 4],
        [3, 3, 2, 2, 2, 3, 3],
        [0x3, 2, 1, 1, 1, 2, 3],
        [3, 2, 1, 0, 1, 2, 3],
        [0x3, 2, 2, 1, 2, 2, 3],
        [4, 3, 3, 2, 3, 3, 4],
        [0x5, 4, 4, 3, 4, 4, 5],
      ];

      expect(
        getDistances(Point(-1, -1), Point(5, 5), Point(2, 2), gridH, ruleset),
        expected,
      );
    });
  });
}

List<List<int>> getDistances<T extends Grid>(
  Point<int> from,
  Point<int> to,
  Point<int> center,
  T grid,
  MeasuringRuleset<T> ruleset,
) {
  final size = to - from;
  final out = List.generate(size.y + 1, (y) => List.filled(size.x + 1, 0));

  for (var y = 0; y <= size.y; y++) {
    for (var x = 0; x <= size.x; x++) {
      final tile = Point(from.x + x, from.y + y);
      final actual = ruleset.distanceBetweenCells(grid, center, tile);

      out[y][x] = actual;
    }
  }

  return out;
}
