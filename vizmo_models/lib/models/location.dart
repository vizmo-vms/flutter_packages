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
}
