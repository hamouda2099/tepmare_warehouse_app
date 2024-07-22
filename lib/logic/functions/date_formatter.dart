import 'package:easy_localization/easy_localization.dart';

class DateFormatter {
  static String customFormat = 'MMM d, y - hh:mm aa';
  static String customFormat2 = 'yyyy-MM-dd hh:mm aa';

  String format(String date, {String? format}) {
    String formattedDate = '';
    try {
      var dateFormat = DateFormat(format ?? 'yyyy-MM-dd hh:mm:ss');
      var utcDate = dateFormat.format(DateTime.parse(date).toLocal());
      var localDate = dateFormat.parse(utcDate, true).toString();
      formattedDate = dateFormat.format(DateTime.parse(localDate));
    } catch (_) {
      return date;
    }

    return formattedDate;
  }
}
