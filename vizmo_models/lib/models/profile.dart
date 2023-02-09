import 'package:vizmo_models/models/settings.dart';
import 'kiosk.dart';
import 'location.dart';
import 'visitor_type.dart';

class Profile {
  String? cid;
  String? lid;
  String? uid;
  Kiosk? kiosk;
  String? totpSecret;
  Location? location;
  List<VisitorType?> visitorTypes = [];
  Settings? locationSettings;
  Profile();

  String? get kid => kiosk?.kid;
}
