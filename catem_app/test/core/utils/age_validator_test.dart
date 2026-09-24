import 'package:catem_app/core/utils/age_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final asOf = DateTime(2026, 9, 24);

  test('calcula la edad exacta segun si ya paso el cumpleanos', () {
    expect(AgeValidator.ageAt(DateTime(2000, 9, 24), asOf), 26);
    expect(AgeValidator.ageAt(DateTime(2000, 9, 25), asOf), 25);
    expect(AgeValidator.ageAt(DateTime(2000, 12, 31), asOf), 25);
    expect(AgeValidator.ageAt(DateTime(2000), asOf), 26);
  });

  test('isAtLeast usa la fecha exacta, no solo el ano', () {
    expect(AgeValidator.isAtLeast(18, DateTime(2008, 9, 24), asOf: asOf), isTrue);
    expect(AgeValidator.isAtLeast(18, DateTime(2008, 9, 25), asOf: asOf), isFalse);
  });

  test('una fecha de nacimiento futura nunca cumple', () {
    expect(AgeValidator.isAtLeast(0, DateTime(2027), asOf: asOf), isFalse);
  });

  test('29 de febrero se maneja sin excepciones', () {
    expect(AgeValidator.ageAt(DateTime(2008, 2, 29), DateTime(2026, 2, 28)), 17);
    expect(AgeValidator.ageAt(DateTime(2008, 2, 29), DateTime(2026, 3)), 18);
  });
}
