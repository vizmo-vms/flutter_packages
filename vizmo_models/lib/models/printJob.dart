import 'package:vizmo_pass/app/data/models/parse_schemas/models.dart';
import 'package:vizmo_pass/app/data/models/printer.dart';
import 'checkin_data.dart';
import 'enum.dart';

class PrintJob {
  String? key;
  String? cid;
  String? lid;
  String? kid;
  List<Printer> printers;
  CheckinData? visitorLog;
  PrintJobSource? source;
  PrintJobStatus? status;
  PrinterError? error;

  PrintJob({
    this.key,
    this.cid,
    this.lid,
    this.kid,
    List<Printer>? printers,
    this.visitorLog,
    this.source,
    this.status,
    this.error,
  }) : this.printers = printers ?? [];
}
