import 'package:intl/intl.dart';

class TimeUtil {
  /// format date
  static String formatDate(String date) {
    if (date.isEmpty) return 'N/A';
    DateTime dt = DateTime.parse(date);
    return DateFormat("MMM dd, yyyy").format(dt);
  }

  static String formatDateYYYMMDD(String date) {
    if (date.isEmpty) return 'N/A';
    DateTime dt = DateTime.parse(date);
    return DateFormat("yyyy-MM-dd").format(dt);
  }

  static String formatDateDDMMYYY(String date) {
    if (date.isEmpty) return 'N/A';
    DateTime dt = DateTime.parse(date);
    return DateFormat("dd-MM-yyyy").format(dt);
  }

  static String formatOperationsDate(String? date, int type) {
    final now = DateTime.parse(date ?? DateTime.now().toString());

    if (type == 2) {
      final DateFormat formatter = DateFormat('yyyy');
      final String formatted = formatter.format(now);

      return formatted;
    }
    if (type == 1) {
      final DateFormat formatter = DateFormat('MMMM yyyy');
      final String formatted = formatter.format(now);

      return formatted;
    }

    final DateFormat formatter = DateFormat('MMMM, d  kk:mm a');
    final String formatted = formatter.format(now);

    return formatted;
  }

  static String timeFormat(String? updatedAt) {
    if (updatedAt == null) return 'N/A';
    if (updatedAt.isEmpty) return 'N/A';

    final dt = DateTime.parse(updatedAt);
    return DateFormat('HH:mm a').format(dt);
    // return DateFormat('MMMM, d  kk:mm a').format(dt);
  }

  static String _returnOngoingTime(Duration difference) {
    if (difference.inHours > 24) return 'CLOSES IN: ${difference.inDays} DAYS';
    return 'CLOSES IN: ${difference.inHours}H : ${difference.inMinutes}M : ${difference.inSeconds}S';
  }

  static String _returnUpcomingTime(Duration difference) {
    if (difference.inHours > 24) return 'OPENS IN: ${difference.inDays} DAYS';
    return 'OPENS IN: ${difference.inHours}H : ${difference.inMinutes}M : ${difference.inSeconds}S';
  }
}
