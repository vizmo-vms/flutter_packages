import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static MethodChannel get vizmoChannel =>
      const MethodChannel('com.vizmo.vizmo/vizmo');

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
