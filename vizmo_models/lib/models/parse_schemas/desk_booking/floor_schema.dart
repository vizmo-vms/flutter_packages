import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_pass/app/data/models/desk_booking/floor.dart';

import '../company_schema.dart';
import '../location_schema.dart';
import 'models.dart';

class FloorSchema extends ParseObject {
  FloorSchema({ParseHTTPClient? client}) : super(_className, client: client);

  static FloorSchema fromObject(ParseObject object) {
    return FloorSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "Floor";

  static String companyKey = 'company';
  static String locationKey = 'location';
  static String nameKey = 'name'; //TODO: max 50
  static String descriptionKey = 'description'; //TODO: max 300
  static String layoutKey = 'layout';

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

  String? get description => get<String?>(descriptionKey);

  FloorLayout? get layout {
    final _data = get(layoutKey);
    if (_data == null || !(_data is Map)) return null;

    return FloorLayout.fromMap(Map.from(_data));
  }

  Floor toFloor() {
    return Floor(
      id: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      name: this.name,
      description: this.description,
      layout: this.layout,
    );
  }
}
