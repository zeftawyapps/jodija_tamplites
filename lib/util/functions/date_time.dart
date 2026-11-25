import 'package:intl/intl.dart';

extension DateTimeExtensionToString on DateTime {
  String toDateString() {
    return toIso8601String();
  }

  // uset format dd/MM/yyyy
  String toStringFormat({String formate= "dd/MM/yyyy"}) {
    return DateFormat(formate).format(this);
  }

  // date deffrence
  int Daydifference({DateTime? date  }) {
    date ??= DateTime.now();
    return difference(date).inDays;
  }
  int Monthdifference({DateTime? date}) {
    date ??= DateTime.now();
    return difference(date).inMinutes ~/ 30;
  }

  int YearDifference({DateTime? date}) {
    date ??= DateTime.now();
    return difference(date).inDays ~/ 365;
  }
  int HourDifference({DateTime? date}) {
    date ??= DateTime.now();
    return difference(date).inHours;
  }
  int MinuteDifference({DateTime? date}) {
    date ??= DateTime.now();
    return difference(date).inMinutes;
  }
  int SecondDifference({DateTime? date}) {
    date ??= DateTime.now();
    return difference(date).inSeconds;
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
