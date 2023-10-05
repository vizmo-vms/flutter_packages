import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/location.dart';

import '../country.dart';
import 'company_schema.dart';

class LocationSchema extends ParseObject {
  LocationSchema() : super(_className);

  static LocationSchema fromObject(ParseObject object) {
    return LocationSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "Location";

  static const String geoLocationKey = 'geoLocation';
  static const String companyNameKey = 'companyName';
  static const String nameKey = 'name';
  static const String activeKey = 'active';
  static const String addressKey = 'address';
  static const String companyKey = 'company';
  static const String timezoneOffsetKey = 'timezoneOffset';
  static const String timezoneKey = 'timezone';
  static const String countryCodeKey = "countryCode";
  // static const String subscriptionKey = 'subscription';

  ParseGeoPoint? get geoLocation => get<ParseGeoPoint>(geoLocationKey);
  String? get companyName => get<String>(companyNameKey);
  String? get name => get<String>(nameKey);
  bool? get active => get<bool>(activeKey);
  String? get address => get<String>(addressKey);
  CompanySchema? get company {
    var result = get(companyKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return CompanySchema()..fromJson(result.toJson(full: true));
    }
    return CompanySchema()..fromJson(result);
  }

  int? get timezoneOffset => get<int>(timezoneOffsetKey);
  String? get timezone => get<String>(timezoneKey);
  String? get countryCode => get<String>(countryCodeKey);

  Location toLocation() {
    return Location(
        active: this.active,
        key: this.objectId,
        name: this.name,
        companyName: this.companyName,
        address: this.address,
        country: Country.findByIsoCode(this.countryCode ?? 'IN'));
  }
}
