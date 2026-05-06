/// Hijri / Islamic calendar month for display and learning.
class ArabicMonthModel {
  final int id;
  /// Arabic script (e.g. المحرم)
  final String arabicName;
  /// Latin transliteration (e.g. Muharram)
  final String transliteration;
  /// Bangla name for learners
  final String banglaName;

  const ArabicMonthModel({
    required this.id,
    required this.arabicName,
    required this.transliteration,
    required this.banglaName,
  });
}
