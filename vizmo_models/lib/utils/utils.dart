import 'package:flutter/material.dart' show ModalRoute, RouteObserver;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rrule/rrule.dart';

class Utils {
  static RruleL10nEn? rruleL10nEn;
  MethodChannel get vizmoChannel =>
      const MethodChannel('com.vizmo.vizmo/vizmo');
  static Uri get knowledgeBaseUrl => Uri.parse('https://help.vizmo.in');
  static Uri get termsAndConditions =>
      Uri.parse('https://vizmo.in/terms-and-conditions');
  static Uri get privacyPolicy => Uri.parse('https://vizmo.in/privacy-policy');

  static DateTime now({bool dateOnly: false}) {
    if (dateOnly) {
      final _now = DateTime.now();

      return DateTime(_now.year, _now.month, _now.day);
    }
    return DateTime.now();
  }

  static final routeObserver = RouteObserver<ModalRoute>();

  static DateTime? getDateTime(dynamic date) {
    if (date == null) return null;

    switch (date.runtimeType) {
      case DateTime:
        return date;
      case int:
        return DateTime.fromMillisecondsSinceEpoch(date);
      case String:
        return DateTime.parse(date).toLocal();
      case Map:
        return DateTime.parse(date['iso']).toLocal();
      default:
        if (date is Map) return DateTime.parse(date['iso']).toLocal();
        return date?.toDate();
    }
  }

  static Future<String?> tempFilePath(String id, String path) async {
    try {
      final _path = '/${id.replaceAll('+', '')}' + '_' + (path);
      return (await getTemporaryDirectory()).path + _path;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String dateHeader(DateTime? date, {bool showTime: false}) {
    if (date == null) return '';
    final _now = DateTime.now();

    if (_now.year == date.year) {
      String? _date;
      if (_now.month == date.month) {
        if (_now.day == date.day) {
          _date = 'Today';
        } else if (_now.day == date.day + 1) {
          _date = 'Yesterday';
        } else if (_now.day == date.day - 1) {
          _date = 'Tomorrow';
        }

        if (_date != null) {
          if (showTime)
            return _date + ', ${DateFormat.jm().format(date.toLocal())}';

          return _date;
        }
      }
      if (showTime)
        return DateFormat('d MMM, ').add_jm().format(date.toLocal());
      return DateFormat('d MMM').format(date.toLocal());
    }
    if (showTime)
      return DateFormat('d MMM yy, ').add_jm().format(date.toLocal());
    return DateFormat('d MMM yy').format(date.toLocal());
  }

  static DateTime? stringToDateTime(String date) {
    if (date.isEmpty) return null;

    switch (date) {
      case 'Today':
        return now(dateOnly: true);
      case 'Yesterday':
        return now(dateOnly: true).subtract(Duration(days: 1));
      case 'Tomorrow':
        return now(dateOnly: true).add(Duration(days: 1));
      default:
        if ((date.split(' ').length) == 2) {
          date += ' ${DateTime.now().year.toString()}';
        }
        return DateFormat('d MMM yy').parse(date);
    }
  }

  static DateTime? parseDate(dynamic date) {
    if (date == null) return null;

    if (date is DateTime) {
      return date;
    }

    if (date is int) {
      return DateTime.fromMillisecondsSinceEpoch(date);
    }

    if (date is Map) {
      return DateTime.tryParse(date['iso']);
    }
    return date?.toDate();
  }
}
