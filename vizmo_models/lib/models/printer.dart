import 'package:vizmo_models/models/parse_schemas/models.dart'
    show PrinterError;
import 'enum.dart';
import 'enum.dart';
import 'parse_schemas/models.dart';
import 'package:another_brother/printer_info.dart' as another;

class Printer {
  String? key;
  String? cid;
  String? lid;
  String? name;
  PrinterStatus? status;
  String? model;
  PrinterInterface? interface;
  String? bmac;
  String? wmac;
  String? ip;

  PrinterError? error;
  PrintJobStatus? printStatus;

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
    this.printStatus,
  });
  another.Model getModel() {
    switch (model) {
      case 'QL-720NW':
        return another.Model.QL_720NW;
      case 'QL-810W':
        return another.Model.QL_810W;
      case 'QL-820NWB':
        return another.Model.QL_820NWB;
      default:
        return another.Model.getValues().firstWhere(
            (e) => e.getName() == this.model,
            orElse: () => another.Model.QL_820NWB);
    }
  }
}
