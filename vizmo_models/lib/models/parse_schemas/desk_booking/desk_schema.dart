import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/desk_booking/desk.dart';

import '../company_schema.dart';
import '../location_schema.dart';
import 'floor_schema.dart';
import 'zone_schema.dart';

class DeskSchema extends ParseObject {
  DeskSchema({ParseHTTPClient? client}) : super(_className, client: client);

  static DeskSchema fromObject(ParseObject object) {
    return DeskSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "Desk";

  static String companyKey = 'company';
  static String locationKey = 'location';
  static String nameKey = 'name'; //TODO: max 50
  static String descriptionKey = 'description'; //TODO: max 300
  static String floorKey = 'floor';
  static String zoneKey = 'zone';
  static String enabledKey = 'enabled';
  static String positionKey = 'position';

  CompanySchema? get company {
    var result = get(companyKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return CompanySchema()..fromJson(result.toJson(full: true));
    }
    return CompanySchema()..fromJson(result);
  }

  LocationSchema? get location {
    var result = get(locationKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return LocationSchema()..fromJson(result.toJson(full: true));
    }
    return LocationSchema()..fromJson(result);
  }

  FloorSchema? get floor {
    var result = get(floorKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return FloorSchema()..fromJson(result.toJson(full: true));
    }
    return FloorSchema()..fromJson(result);
  }

  ZoneSchema? get zone {
    var result = get(zoneKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return ZoneSchema()..fromJson(result.toJson(full: true));
    }
    return ZoneSchema()..fromJson(result);
  }

  set company(CompanySchema? company) => set(companyKey, company?.toPointer());

  set location(LocationSchema? value) => set(locationKey, value?.toPointer());

  String? get name => get<String?>(nameKey);

  String? get description => get<String?>(descriptionKey);

  bool get enabled => get<bool?>(enabledKey) ?? false;

  ParseGeoPoint? get position => get<ParseGeoPoint>(positionKey);

  Desk toDesk() {
    return Desk(
      id: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      name: this.name,
      description: this.description,
      enabled: this.enabled,
      floor: this.floor?.toFloor(),
      zone: this.zone?.toZone(),
      position: this.position,
    );
  }
}
