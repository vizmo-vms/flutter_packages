import 'package:vizmo_models/models/parse_schemas/models.dart'
    show PrintJobData, PrinterError;
import 'package:vizmo_models/models/parse_schemas/models.dart';
import 'package:vizmo_models/models/printer.dart';
import 'checkin_data.dart';
import 'enum.dart';

class PrintJob {
  String? key;
  String? cid;
  String? lid;
  String? kid;
  DateTime? createdAt;
  PrintJobData? data;
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
    this.data,
    this.source,
    this.status,
    this.error,
    this.createdAt,
    List<Printer>? printers,
    this.visitorLog,
  }) : this.printers = printers ?? [];
}
