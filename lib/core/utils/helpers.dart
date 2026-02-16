import 'package:url_launcher/url_launcher.dart';

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


  static Future<void> launchURL(String urlString) async {
    // Ensure the URL has a scheme
    final String fullUrl = urlString.startsWith('http')
        ? urlString
        : 'https://$urlString';

    final Uri url = Uri.parse(fullUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $fullUrl');
    }
  }
}
