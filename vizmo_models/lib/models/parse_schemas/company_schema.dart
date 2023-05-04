import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CompanySchema extends ParseObject {
  CompanySchema() : super(_className);

  static const String _className = "Company";

  static const String countryNameKey = "countryName";
  static const String countryCodeKey = "countryCode";
  static const String nameKey = "name";
  static const String timezoneKey = "timezone";
  static const String timezoneOffsetKey = "timezoneOffset";
  static const String zsCustomerIdKey = "zsCustomerId";
  static const String setupKey = "setup";

  static CompanySchema fromObject(ParseObject object) {
    return CompanySchema().fromJson(object.toJson(full: true));
  }

  String? get countryName => get<String>(countryNameKey);
  String? get countryCode => get<String>(countryCodeKey);
  String? get name => get<String>(nameKey);
  String? get timezone => get<String>(timezoneKey);
  int? get timezoneOffset => get<int>(timezoneOffsetKey);
  Object? get setup => get<Object>(setupKey);
}
