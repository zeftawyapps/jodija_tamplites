import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

extension DateTimeExtensionToString on DateTime {
  String toDateString() {
    return this.toIso8601String();
  }

  // uset format dd/MM/yyyy
  String toStringFormat({String formate= "dd/MM/yyyy"}) {
    return DateFormat(formate).format(this);
  }

  // date deffrence
  int Daydifference({DateTime? date  }) {
    if(date == null) date = DateTime.now();
    return this.difference(date).inDays;
  }
  int Monthdifference({DateTime? date}) {
    if(date == null) date = DateTime.now();
    return this.difference(date).inMinutes ~/ 30;
  }

  int YearDifference({DateTime? date}) {
    if(date == null) date = DateTime.now();
    return this.difference(date).inDays ~/ 365;
  }
  int HourDifference({DateTime? date}) {
    if(date == null) date = DateTime.now();
    return this.difference(date).inHours;
  }
  int MinuteDifference({DateTime? date}) {
    if(date == null) date = DateTime.now();
    return this.difference(date).inMinutes;
  }
  int SecondDifference({DateTime? date}) {
    if(date == null) date = DateTime.now();
    return this.difference(date).inSeconds;
  }

}

extension StringExtensionToDateTime on String {
  DateTime toDateTime() {
    return DateTime.parse(this);
  }

}

extension UrlExtension on int {

  DateTime toDateTimeFromSeconds(int secontd) {
    return DateTime.fromMillisecondsSinceEpoch(secontd * 1000);
  }

}
