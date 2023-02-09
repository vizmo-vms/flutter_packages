import 'package:vizmo_models/models/parse_schemas/models.dart'
    show PrinterError;
import 'enum.dart';

class Printer {
  String? key;
  String? cid;
  String? lid;
  String? name;
  PrinterStatus? status;
  PrinterModel? model;
  PrinterInterface? interface;
  String? bmac;
  String? wmac;
  String? ip;
  PrinterError? error;

  Printer({
    this.key,
    this.cid,
    this.lid,
    this.name,
    this.status,
    this.model,
    this.interface,
    this.bmac,
    this.wmac,
    this.ip,
    this.error,
  });
}
