/// {
///     country_code: 49,
///     e164: '+4930123123123',
///     national: '030 123 123 123',
///     type: 'mobile',
///     international: '+49 30 123 123 123',
///     national_number: '030123123123',
/// }
class PhoneNumber {
  final String? countryCode;
  final String? nationalNumber;
  final String? international;
  final String? e164;
  final String? type;
  final String? number;

  PhoneNumber.fromMap(Map map)
      : this.countryCode = map['country_code'],
        this.nationalNumber = map['national_number'],
        this.international = map['international'],
        this.type = map['type'],
        this.e164 = map['e164'],
        this.number = map['number'];
}
