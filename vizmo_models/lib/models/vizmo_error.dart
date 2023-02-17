import 'package:flutter/foundation.dart' show ErrorSummary, FlutterError;

class VizmoError extends FlutterError {
  VizmoError(String code, String message)
      : super.fromParts([ErrorSummary(message)]);
}

enum VizmoErrorCodes { InviteScanError }
