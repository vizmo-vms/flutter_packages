import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/desk_booking/zone.dart';

import '../company_schema.dart';
import '../location_schema.dart';
import 'floor_schema.dart';

class ZoneSchema extends ParseObject {
  ZoneSchema({ParseHTTPClient? client}) : super(_className, client: client);

  static ZoneSchema fromObject(ParseObject object) {
    final json = object.toJson(full: true);
    json[floorsKey] =
        List.from(object.get<List>(floorsKey) ?? []).map((result) {
      if (result is ParseObject) {
        return result.toJson(full: true);
      }
      return result;
    }).toList();
    final ZoneSchema _object = ZoneSchema().fromJson(json);
    // // TODO:
    // // bug in parse sdk,  parse_encode.dart file, while encoding object, if value is List, sdk is calling parseEncode(value); but full field is missing here
    return _object;
  }

  static const String _className = "Zone";

  static String companyKey = 'company';
  static String locationKey = 'location';
  static String nameKey = 'name'; //TODO: max 50
  static String floorsKey = 'floors';

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

  set company(CompanySchema? company) => set(companyKey, company?.toPointer());

  set location(LocationSchema? value) => set(locationKey, value?.toPointer());

  String? get name => get<String?>(nameKey);

  List<FloorSchema>? get floors =>
      List.from(get<List>(floorsKey) ?? []).map((result) {
        if (result is ParseObject) {
          return FloorSchema()..fromJson(result.toJson(full: true));
        }
        return FloorSchema()..fromJson(result);
      }).toList();

  ParseZone toZone() {
    return ParseZone(
      id: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      name: this.name,
      floors: this.floors?.map((e) => e.toFloor()).toList() ?? [],
    );
  }
}
