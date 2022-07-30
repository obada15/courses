import 'package:date_format/date_format.dart';

class ArabicLocale implements Locale {
  const ArabicLocale();

  final List<String> monthsShort = const [
    'كانون الثاني',
    'شباط',
    'اذار',
    'نيسان',
    'ايار',
    'حزيران',
    'تموز',
    'اب',
    'ايلول',
    'تشرين الاول',
    'تشرين الثاني',
    'كانون الاول'
  ];

  final List<String> monthsLong = const [
    'كانون الثاني',
    'شباط',
    'اذار',
    'نيسان',
    'ايار',
    'حزيران',
    'تموز',
    'اب',
    'ايلول',
    'تشرين الاول',
    'تشرين الثاني',
    'كانون الاول'
  ];

  final List<String> daysShort = const [
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الاحد'
  ];

  final List<String> daysLong = const [
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الاحد'
  ];

  @override
  String get am => "ص";

  @override
  String get pm => "م";
}
