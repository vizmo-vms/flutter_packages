import 'package:flutter/foundation.dart';

class VizmoError extends FlutterError {
  VizmoError(String code, String message) : super.fromParts([ErrorSummary(message)]);
}

enum VizmoErrorCodes { InviteScanError }
