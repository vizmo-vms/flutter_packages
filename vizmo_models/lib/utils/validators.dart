import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class Validators {
  Validators._();
  //TODO: use validators package instead
  static bool isValidPhone(String phone) {
    return RegExp(r"\d{10}").hasMatch(phone);
  }

  static bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
    return emailRegex.hasMatch(email.toLowerCase());
  }

  static String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) return 'Email is required.';
    // final RegExp emailExp = RegExp(r"^[a-z0-9][a-z0-9-_\.]+@[a-zA-Z0-9_]+?\.[a-z0-9]{2,10}(?:\.[a-z]{2,10})?$");
    if (!isValidEmail(value!)) return 'Invalid email address';
    return null;
  }

  static bool isValidNumber(String number) {
    return RegExp(r"^\d{1,}$").hasMatch(number);
  }

  static bool isValidBase64(String? base64String) {
    if (base64String?.isEmpty ?? true) return false;
    RegExp base64Regex = RegExp(
        r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');
    return base64Regex.hasMatch(base64String!);
  }

  static String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) return "Password can't be empty";
    return null;
  }

  static Future<String?> validatePhone(String val,
      {String? dialingCode: '', String? region}) async {
    if (val.isEmpty) return "Phone no. can't be empty";

    try {
      final parsed = await FlutterLibphonenumber().parse(
          '${val.startsWith(RegExp(r'(0|\+)')) ? '' : dialingCode}$val',
          region: region);

      if (parsed['type'] == 'fixedLine') {
        return 'Invalid Phone Number: Fixed Line';
      }
    } on Exception {
      return 'Invalid Phone Number';
    }

    return null;
  }
}
