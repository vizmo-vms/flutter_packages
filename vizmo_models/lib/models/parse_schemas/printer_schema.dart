import 'package:flutter/foundation.dart' show describeEnum;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/parse_schemas/kiosk_schema.dart';
import 'package:vizmo_models/models/parse_schemas/models.dart';
import 'package:vizmo_models/utils/extension_utils.dart';

import '../enum.dart';
import '../printer.dart';
import 'company_schema.dart';
import 'location_schema.dart';

class PrinterSchema extends ParseObject {
  PrinterSchema() : super(_className);

  static PrinterSchema fromObject(ParseObject object) {
    final PrinterSchema _object =
        PrinterSchema().fromJson(object.toJson(full: true));

    // TODO:
    // bug in parse sdk,  parse_encode.dart file, while encoding object, if value is List, sdk is calling parseEncode(value); but full field is missing here
    _object.forApiRQ = false;
    _object.kiosks = List.from(object.get<List>(kiosksKey) ?? []).map((result) {
      if (result is ParseObject) {
        return KioskSchema()..fromJson(result.toJson(full: true));
      }
      return KioskSchema()..fromJson(result);
    }).toList();
    _object.forApiRQ = true;

    return _object;
  }

  static const String _className = "Printer";
  static const String companyKey = "company";
  static const String locationKey = "location";
  static const String kiosksKey = "kiosks";
  static const String nameKey = "name";
  static const String statusKey = "status";
  static const String interfaceKey = "interface";
  static const String modelKey = "model";
  static const String ipKey = "ip";
  static const String wmacKey = "wmac";
  static const String bmacKey = "bmac";
  static const String errorKey = "error";

  bool forApiRQ = true;

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

  List<KioskSchema>? get kiosks {
    var result = get(kiosksKey);
    if (result == null) return null;

    if (result is List) {
      return List.from(result).map((result) {
        if (result is ParseObject) {
          return KioskSchema()..fromJson(result.toJson(full: true));
        }
        return KioskSchema()..fromJson(result);
      }).toList();
    }
    return null;
  }

  set kiosks(List<KioskSchema>? value) => set(
      kiosksKey,
      value?.map((e) => e.toJson(full: true, forApiRQ: forApiRQ)).toList() ??
          []);

  String? get name => get<String>(nameKey);

  PrinterStatus? get status {
    final _val = get<String>(statusKey);
    if (_val?.isEmpty ?? true) return null;
    return stringToEnum(PrinterStatus.values, _val);
  }

  set status(PrinterStatus? status) {
    if (status == null) return;
    set<String>(statusKey, describeEnum(status));
  }

  PrinterInterface? get interface {
    final _val = get<String>(interfaceKey);
    if (_val?.isEmpty ?? true) return null;
    return stringToEnum(PrinterInterface.values, _val);
  }

  PrinterModel? get model {
    final _val = get<String>(modelKey);
    if (_val?.isEmpty ?? true) return null;
    return stringToEnum<PrinterModel>(PrinterModel.values, _val);
  }

  String? get ip => get<String>(ipKey);

  String? get wmac => get<String>(wmacKey);

  String? get bmac => get<String>(bmacKey);

  PrinterError? get error {
    final _val = get(errorKey);
    if (_val == null) return null;
    if (_val is Map) return PrinterError.fromMap(Map.from(_val));
    return null;
  }

  set error(PrinterError? error) {
    set(errorKey, error?.toMap());
  }

  Printer toPrinter() {
    return Printer(
      key: this.objectId!,
      cid: company?.objectId,
      lid: location?.objectId,
      name: name,
      status: status,
      model: model,
      interface: interface,
      bmac: bmac,
      wmac: wmac,
      ip: ip,
    );
  }
}
