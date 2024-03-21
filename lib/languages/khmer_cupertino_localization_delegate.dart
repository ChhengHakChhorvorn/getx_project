import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class _CupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return Get.locale!.languageCode == 'kh';
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      KhmerCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(_CupertinoLocalizationsDelegate old) => true;

  @override
  String toString() => 'DefaultCupertinoLocalizations.delegate(km)';
}

class KhmerCupertinoLocalizations extends CupertinoLocalizationKm {
  static const List<String> _months = <String>[
    'មករា',
    'កុម្ភៈ',
    'មីនា',
    'មេសា',
    'ឧសភា',
    'មិថុនា',
    'កក្កដា',
    'សីហា',
    'កញ្ញា',
    'តុលា',
    'វិច្ឆិកា',
    'ធ្នូ',
  ];

  KhmerCupertinoLocalizations()
      : super(
          fullYearFormat: DateFormat.y('km'),
          dayFormat: DateFormat.d('km'),
          mediumDateFormat: DateFormat.yMd('km'),
          singleDigitHourFormat: DateFormat('h'),
          singleDigitMinuteFormat: DateFormat('m'),
          doubleDigitMinuteFormat: DateFormat('mm'),
          singleDigitSecondFormat: DateFormat('s'),
          decimalFormat: NumberFormat(''),
        );

  @override
  String datePickerMonth(int monthIndex) {
    return _months[monthIndex - 1];
  }

  @override
  String get datePickerDateOrderString {
    return 'mdy';
  }

  /// Creates an object that provides US English resource values for the
  /// cupertino library widgets.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  static Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<CupertinoLocalizations>(
        KhmerCupertinoLocalizations());
  }

  /// A [LocalizationsDelegate] that uses [DefaultCupertinoLocalizations.load]
  /// to create an instance of this class.
  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _CupertinoLocalizationsDelegate();
}
