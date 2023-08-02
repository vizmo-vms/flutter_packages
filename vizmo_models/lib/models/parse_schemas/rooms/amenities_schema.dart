import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../rooms/amenities.dart';
import '../company_schema.dart';

class AmenitiesSchema extends ParseObject {
  AmenitiesSchema({ParseHTTPClient? client})
      : super(_className, client: client);
  static AmenitiesSchema fromObject(ParseObject object) {
    return AmenitiesSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "Amenities";

  static const String companyKey = 'company';
  static const String descriptionKey = 'description';
  static const String nameKey = 'name';
  static String iconKey = 'icon';
  CompanySchema? get company {
    var result = get(companyKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return CompanySchema()..fromJson(result.toJson(full: true));
    }
    return CompanySchema()..fromJson(result);
  }

  set company(CompanySchema? company) => set(companyKey, company?.toPointer());

  String? get description => get<String?>(descriptionKey);
  set description(String? value) => set(descriptionKey, value);
  String? get name => get<String?>(nameKey);
  set name(String? value) => set(nameKey, value);
  String? get icon => get<String?>(iconKey);
  set icon(String? value) => set(iconKey, value);

  AmenitiesSchema fromMap(Map<dynamic, dynamic> map) {
    return AmenitiesSchema();
  }

  Amenities toAmenities() {
    return Amenities(
        id: this.objectId,
        cid: this.company?.objectId,
        icon: this.icon,
        description: this.description,
        name: this.name);
  }
}
