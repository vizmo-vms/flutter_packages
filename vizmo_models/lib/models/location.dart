// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'country.dart';

class Location {
  String? key;
  String? name;
  String? companyName;
  String? address;
  Country? country;
  bool? active;
  String? subscriptionStatus;
  String? sid;
  String? timezone;

  //computed
  // Plans plan;

  Location({
    this.key,
    this.name,
    this.companyName,
    this.address,
    this.active,
    this.subscriptionStatus,
    this.sid,
    this.country,
    this.timezone = 'Asia/Kolkata',
  });

  // : assert(name != null),
  //   assert(companyName != null),
  //   assert(active != null);

  Location.fromMap(String key, Map<String, dynamic> map)
      : this.key = key,
        name = map['locationName'],
        companyName = map['companyName'],
        address = map['address'],
        country = Country.findByIsoCode(map['countryCode'] ?? 'IN'),
        active = map['active'],
        subscriptionStatus = map['subscriptionStatus'],
        sid = map['sid'];

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.key == key && other.name == name;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        name.hashCode ^
        companyName.hashCode ^
        address.hashCode ^
        country.hashCode ^
        active.hashCode ^
        subscriptionStatus.hashCode ^
        sid.hashCode ^
        timezone.hashCode;
  }
}
