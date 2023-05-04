import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rrule/rrule.dart';
import 'package:vizmo_models/models/desk_booking/desk.dart';
import 'package:vizmo_models/models/desk_booking/desk_booking.dart';
import 'package:vizmo_models/models/parse_schemas/desk_booking/desk_schema.dart';
import 'package:vizmo_models/utils/extension_utils.dart';
import '../../invite.dart';
import '../company_schema.dart';
import '../location_schema.dart';
import '../models.dart';
import 'enum.dart';
import 'models.dart';

class DeskBookingSchema extends ParseObject {
  Rxn<RruleL10nEn>? rrulel10;
  DeskBookingSchema({ParseHTTPClient? client, this.rrulel10})
      : super(_className, client: client);

  static DeskBookingSchema fromObject(ParseObject object) {
    return DeskBookingSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "DeskBooking";

  static String companyKey = 'company';
  static String locationKey = 'location';
  static String deskKey = 'desk';
  static String recurrenceKey = 'recurrence';
  static String createdByKey = 'createdBy';
  static String assignedToKey = 'assignedTo';
  static String statusKey = 'status';

  static String deskPointerKey = 'desk.pointer';
  static String startDate = 'recurrence.range.startDate';
  static String endDate = 'recurrence.range.endDate';
  static String assignedToEmail = 'assignedTo.email';

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

  ParseDeskPointer? get desk {
    final _desk = get<Map<String, dynamic>>(deskKey);
    if (_desk == null) return null;
    return ParseDeskPointer.fromMap(_desk);
  }

  set desk(ParseDeskPointer? desk) =>
      set<Map<String, dynamic>?>(deskKey, desk?.toMap());

  Recurrence? get recurrence => Recurrence.fromMap(
        get<Map<String, dynamic>>(recurrenceKey) ?? {},
      );

  set recurrence(Recurrence? recurrence) =>
      set<Map<String, dynamic>?>(recurrenceKey, recurrence?.toMap());

  ParseHost? get createdBy {
    final _host = get<Map<String, dynamic>>(createdByKey);
    if (_host == null) return null;
    return ParseHost.fromMap(_host);
  }

  set createdBy(ParseHost? createdBy) =>
      set<Map<String, dynamic>?>(createdByKey, createdBy?.toMap());

  ParseHost? get assignedTo {
    final _host = get<Map<String, dynamic>>(assignedToKey);
    if (_host == null) return null;
    return ParseHost.fromMap(_host);
  }

  set assignedTo(ParseHost? assignedTo) =>
      set<Map<String, dynamic>?>(assignedToKey, assignedTo?.toMap());

  DeskBookingStatus? get status =>
      stringToEnum(DeskBookingStatus.values, get<String>(statusKey));

  set status(DeskBookingStatus? value) =>
      set<String?>(statusKey, value != null ? describeEnum(value) : null);

  DeskBooking toDeskBooking({Desk? desk}) {
    return DeskBooking(
      id: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      desk: this.desk?.toDesk(desk: desk),
      assignedTo: this.assignedTo?.toHost(),
      createdBy: this.createdBy?.toHost(),
      recurrence: this.recurrence,
      status: this.status,
    );
  }

  void fromBooking(DeskBooking booking) {
    this.company = CompanySchema()..objectId = booking.cid;
    this.location = LocationSchema()..objectId = booking.lid;

    final _desk = booking.desk;
    this.desk = ParseDeskPointer(
      pointer: DeskSchema()..objectId = _desk?.id,
      name: _desk?.name,
      floor: _desk?.floor?.name,
      zone: _desk?.zone?.name,
    );
    this.assignedTo = ParseHost.fromHost(booking.assignedTo!);
    this.createdBy = ParseHost.fromHost(booking.createdBy!);
    this.recurrence = booking.recurrence;
  }
}
