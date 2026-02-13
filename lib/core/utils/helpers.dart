class Helpers {
  static String ageFormatter(String? date) {
    if (date == null || date.isEmpty) return "";

    try {
      final dob = DateTime.parse(date);
      final now = DateTime.now();

      int years = now.year - dob.year;

      if (now.month < dob.month ||
          (now.month == dob.month && now.day < dob.day)) {
        years--;
      }

      if (years < 0) return "";

      return "$years Y";
    } catch (e) {
      return "";
    }
  }
}
