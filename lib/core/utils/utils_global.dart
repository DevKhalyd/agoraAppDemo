abstract class UtilsGloabals {
  static String generateId(String prefix) =>
      '${prefix}_${DateTime.now().millisecondsSinceEpoch.toString()}';
}
