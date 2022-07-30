
import 'dart:ffi';
import 'dart:math';

import 'package:intl/intl.dart';

extension StringExtension on String{
  get firstLetterToUpperCase {
    if (this != null)
      return this[0].toUpperCase() + this.substring(1);
    else
      return null;
  }
}

extension Assets on String{
  get assets {
    return "assets/$this";
  }
}

extension DateFormatteString on String{
  DateTime get toDate {
    String strDt = this;
    DateTime parseDt = DateTime.parse(strDt);
    return parseDt!=null?parseDt:DateTime.now();
    print(parseDt); // 1984–04–02 00:00:00.000
  }
}
extension DateFormatteDate on DateTime{
  String get toDateDDMMYY {
    var newFormat = DateFormat("dd-MM-yyyy");
    return newFormat.format(this) ?? "date unKnown";
  }
  String get toDateYYMMDD {
    var newFormat = DateFormat("yyyy-MM-dd");
    return newFormat.format(this) ?? "date unKnown";
  }
  String get toDateDDMMYYYY {
    var newFormat = DateFormat("dd-MM-yyyy h:mm aa");
    return newFormat.format(this) ?? "date unKnown";
  }
  String get toDateHHMM {
    var newFormat = DateFormat("h:mm aa");
    return newFormat.format(this) ?? "date unKnown";
  }
}
