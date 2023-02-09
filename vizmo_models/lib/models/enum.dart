enum InviteSource {
  dashboard,
  vizmoid,
  api,
}

enum RecurrencePatternType {
  day,
  week,
  month,
}

enum RecurrenceRangeType {
  numbered,
  endDate,
}

enum RSVP { Yes, No, Maybe }

enum InviteType { internal, external }

enum SourceEnum {
  dashboard,
  kiosk,
  vizmopass,
  api,
  touchless,
}

enum AcceptRejectStatus {
  accepted,
  rejected,
  no_response,
}

enum InviteStatus { CONFIRMED, CANCELLED }

enum PrinterStatus { online, offline, error }

enum PrinterInterface { BLUETOOTH, WIFI }

/// call PrinterModel.QL720NW.describeEnum() to get the string representation of the enum.
enum PrinterModel { QL720NW, QL820NWB }

enum PrintJobStatus { pending, processing, success, error, cancelled }

enum PrintJobSource { vizmo, portal }
