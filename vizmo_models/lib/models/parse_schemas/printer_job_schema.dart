import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/parse_schemas/models.dart'
    show PrintJobData, PrinterError;
import 'package:vizmo_models/utils/extension_utils.dart';

import '../enum.dart';
import '../printJob.dart';
import 'company_schema.dart';
import 'kiosk_schema.dart';
import 'location_schema.dart';

class PrintJobSchema extends ParseObject {
  PrintJobSchema() : super(_className);

  static PrintJobSchema fromObject(ParseObject object) {
    return PrintJobSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "PrintJob";
  static const String companyKey = "company";
  static const String locationKey = "location";
  static const String kioskKey = "kiosk";
  static const String sourceKey = "source";
  static const String statusKey = "status";
  static const String dataKey = "data";
  static const String errorKey = "error";

  CompanySchema? get company {
    var result = get(companyKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return CompanySchema()..fromJson(result.toJson(full: true));
    }
    return CompanySchema()..fromJson(result);
  }

  // set company(CompanySchema? company) => set(companyKey, company?.toPointer());

  LocationSchema? get location {
    var result = get(locationKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return LocationSchema()..fromJson(result.toJson(full: true));
    }
    return LocationSchema()..fromJson(result);
  }

  // set location(LocationSchema? location) =>
  //     set(locationKey, location?.toPointer());

  KioskSchema? get kiosk {
    var result = get(kioskKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return KioskSchema()..fromJson(result.toJson(full: true));
    }
    return KioskSchema()..fromJson(result);
  }

  // set kiosk(KioskSchema? value) => set(kioskKey, value?.toPointer());

  PrintJobData? get data {
    return PrintJobData.fromMap(Map.from(get(dataKey) ?? {}));
  }

  PrintJobStatus? get status {
    var result = get(statusKey);
    if (result == null) return null;

    if (result is String) {
      return stringToEnum(PrintJobStatus.values, result);
    }
    return null;
  }

  set status(PrintJobStatus? value) {
    set(statusKey, value == null ? null : describeEnum(value));
  }

  PrintJobSource? get source {
    var result = get(sourceKey);
    if (result == null) return null;

    if (result is String) {
      return stringToEnum(PrintJobSource.values, result);
    }
    return null;
  }

  set source(PrintJobSource? value) {
    set(sourceKey, value == null ? null : describeEnum(value));
  }

  PrinterError? get error {
    var result = get(errorKey);
    if (result == null) return null;

    return PrinterError.fromMap(Map.from(result));
  }

  set error(PrinterError? value) {
    set(errorKey, value?.toMap());
  }

  PrintJob toPrintJob() {
    return PrintJob(
      key: this.objectId,
      cid: company?.objectId,
      lid: location?.objectId,
      kid: kiosk?.objectId,
      data: data,
      source: source,
      status: status,
      error: error,
      createdAt: this.createdAt,
    );
  }
}
