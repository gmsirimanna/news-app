import 'package:intl/intl.dart';

class Util {
  static String convertTime(String time) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(time);
    return DateFormat.yMMMMEEEEd('en_US').format(parseDate);
  }
}
