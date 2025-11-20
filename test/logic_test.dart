import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Days in month logic test', () {
    // Test December 2025
    DateTime dec = DateTime(2025, 12, 15);

    // This creates DateTime(2025, 13, 0) -> Last day of Dec 2025
    int days = DateTime(dec.year, dec.month + 1, 0).day;

    // ...and 'expect' to verify the result automatically.
    expect(days, 31);
  });
}
