import 'package:vizmo_models/models/parse_schemas/models.dart'
    show PrintJobData, PrinterError;
import 'enum.dart';

class PrintJob {
  String? key;
  String? cid;
  String? lid;
  String? kid;
  DateTime? createdAt;
  PrintJobData? data;
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
  });
}
