abstract final class AgeValidator {
  /// Edad exacta en anos cumplidos a la fecha [asOf] (no solo resta de anos).
  static int ageAt(DateTime birthDate, DateTime asOf) {
    var age = asOf.year - birthDate.year;
    final hadBirthdayThisYear =
        asOf.month > birthDate.month ||
        (asOf.month == birthDate.month && asOf.day >= birthDate.day);
    if (!hadBirthdayThisYear) age--;
    return age;
  }

  static bool isAtLeast(int years, DateTime birthDate, {DateTime? asOf}) {
    final reference = asOf ?? DateTime.now();
    if (birthDate.isAfter(reference)) return false;
    return ageAt(birthDate, reference) >= years;
  }
}
