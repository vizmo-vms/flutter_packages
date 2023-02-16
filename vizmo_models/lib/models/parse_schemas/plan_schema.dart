import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_pass/app/data/models/enum.dart';
import 'package:vizmo_pass/app/utils/extension_utils.dart';

import '../plan.dart';
import 'company_schema.dart';
import 'location_schema.dart';

class PlanSchema extends ParseObject {
  PlanSchema({ParseHTTPClient? client}) : super(_className, client: client);

  static PlanSchema fromObject(ParseObject object) {
    return PlanSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "Plan";

  static String companyKey = 'company';
  static String locationKey = 'location';
  static String nameKey = 'name';
  static String featuresKey = 'features';

  CompanySchema? get company {
    final result = get(companyKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return CompanySchema()..fromJson(result.toJson(full: true));
    }
    return CompanySchema()..fromJson(result);
  }

  LocationSchema? get location {
    final result = get(locationKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return LocationSchema()..fromJson(result.toJson(full: true));
    }
    return LocationSchema()..fromJson(result);
  }

  PlanCode? get name {
    final result = get<String?>(nameKey);
    return stringToEnum(PlanCode.values, result);
  }

  Plan? get features {
    final result = get(featuresKey);
    return result != null ? Plan.fromJson(Map.from(result)) : null;
  }

  Plan? toPlan() {
    return features
      ?..cid = this.company?.objectId
      ..lid = this.location?.objectId
      ..planCode = this.name;
  }
}
