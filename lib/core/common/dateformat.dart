import 'package:intl/intl.dart';

class CustomDateTimeFormatter {
  static String? newsDateTimeFormat({required String dateTime}) {
    // String date = '2023-08-19T12:00:00Z';

    String formated =
        DateFormat('dd MMM,yyyy ').format(DateTime.parse(dateTime));

    return formated;
  }
}