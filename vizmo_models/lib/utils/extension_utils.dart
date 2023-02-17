import 'package:get/get_utils/get_utils.dart';
import 'dart:math' show min, max;

T? stringToEnum<T>(List<T?> values, String? value, {T? defaultValue}) {
  if (value == null) {
    return null;
  }

  return values
          .firstWhereOrNull((element) => _describeEnum(element) == value) ??
      defaultValue;
}

String _describeEnum(dynamic enumEntry) {
  final String description = enumEntry.toString();
  final int indexOfDot = description.indexOf('.');
  assert(
    indexOfDot != -1 && indexOfDot < description.length - 1,
    'The provided object "$enumEntry" is not an enum.',
  );
  return description.substring(indexOfDot + 1);
}

extension ListUtils<E> on List<E> {
  ///Add custom [predicate] to evalute equality
  ///
  ///defaults to '==' on the [value]
  ///set update = true to update existing
  void addIfNotExists(E? value,
      {bool Function(E)? predicate, bool update: true}) {
    if (value == null) return;
    final _index = this.indexWhere(predicate ?? (val) => val == value);

    if (_index == -1) {
      this.add(value);
    } else if (_index > -1 && update) {
      this[_index] = value;
    }
  }

  void addAllIfNotExists(List<E> values,
      {required bool Function(E, E) predicate, bool update: true}) {
    values.forEach((_) {
      this.addIfNotExists(_, predicate: (val) {
        return predicate(_, val);
      }, update: update);
    });
  }
}

extension Refactor<T, E> on Map<T, E> {
  void removeEmpty({bool Function(T, E)? test}) {
    this.removeWhere(test ?? (key, value) => value == null);
  }
}

extension CalendarDate on DateTime {
  DateTime calendarDate() {
    return this.isUtc
        ? DateTime.utc(this.year, this.month, this.day)
        : DateTime(this.year, this.month, this.day);
  }

  bool isTomorrow() {
    final day = DateTime.now().add(Duration(days: 1));

    return this.calendarDate().compareTo(day.calendarDate()) == 0;
  }

  DateTime endOfDay() {
    final day = this.add(Duration(days: 1)).subtract(Duration(seconds: 1));

    return day;
  }

  bool currentDay() {
    final day = DateTime.now();
    if (this.isUtc) {
      return this.calendarDate().compareTo(day.toUtc().calendarDate()) == 0;
    } else {
      return this.calendarDate().compareTo(day.calendarDate()) == 0;
    }
  }

  bool isTodayOrTomorrow() {
    return this.currentDay() || this.isTomorrow();
  }

  bool isSameDay(DateTime other) {
    return this.calendarDate().compareTo(other.calendarDate()) == 0;
  }
}

extension DoubleUtils on double {
  bool inBetween(double a, double b) {
    final _min = min(a, b);
    final _max = max(a, b);
    if (this < _min || this > _max) return false;
    return true;
  }
}
