// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vizmo_models/models/desk_booking/desk.dart';
import 'package:vizmo_models/models/host.dart';
import 'package:vizmo_models/models/invite.dart';

import '../parse_schemas/desk_booking/enum.dart' show DeskBookingStatus;

import '../parse_schemas/desk_booking/enum.dart' show DeskBookingStatus;
import '../parse_schemas/models.dart';

class DeskBooking {
  final String? id;
  final String? cid;
  final String? lid;
  final Desk? desk;
  final Recurrence? recurrence;
  final ParseHost? createdBy;
  final Host? assignedTo;
  final DeskBookingStatus? status;

  DeskBooking({
    this.id,
    this.cid,
    this.lid,
    this.desk,
    this.recurrence,
    this.createdBy,
    this.assignedTo,
    this.status,
  });

  bool get isCancelled => this.status == DeskBookingStatus.CANCELLED;

  @override
  bool operator ==(covariant DeskBooking other) {
    if (identical(this, other)) return true;

    return other.id == id && other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cid.hashCode ^
        lid.hashCode ^
        desk.hashCode ^
        recurrence.hashCode ^
        createdBy.hashCode ^
        assignedTo.hashCode ^
        status.hashCode;
  }
}
