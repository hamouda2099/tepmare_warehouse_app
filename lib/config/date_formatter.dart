import 'package:intl/intl.dart';

String dateFormatter(String date) {
  String formattedDate = '';

  try {
    var dateFormat = DateFormat("yyyy-MM-dd hh:mm aa");
    var utcDate = dateFormat.format(DateTime.parse(date).toLocal());
    var localDate = dateFormat.parse(utcDate, true).toString();
    formattedDate = dateFormat.format(DateTime.parse(localDate));
  } catch (_) {}

  return formattedDate;
}
