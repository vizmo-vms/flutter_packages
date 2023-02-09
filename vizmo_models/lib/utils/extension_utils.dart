import 'package:collection/collection.dart';
import 'package:vizmo_models/models/enum.dart';

T? stringToEnum<T>(List<T?> values, String? value, {T? defaultValue}) {
  if (value == null) {
    return null;
  }

  return values.firstWhereOrNull((element) {
    final _value = element is PrinterModel
        ? element.describeEnum()
        : _describeEnum(element);
    return _value == value;
  });
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
  void addIfNotExists(E value,
      {bool Function(E)? predicate, bool update: true}) {
    if (value == null) return;
    final _index = this.indexWhere(predicate ?? (val) => val == value);

    if (_index == -1) {
      this.add(value);
    } else if (_index > -1 && update) {
      this.removeAt(_index);
      this.insert(_index, value);
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

  bool currentDay() {
    final day = DateTime.now();
    if (this.isUtc) {
      return this.calendarDate().compareTo(day.toUtc().calendarDate()) == 0;
    } else {
      return this.calendarDate().compareTo(day.calendarDate()) == 0;
    }
  }
}

extension PrinterEnum on PrinterModel {
  String describeEnum() {
    switch (this) {
      case PrinterModel.QL720NW:
        return 'QL-720NW';
      case PrinterModel.QL820NWB:
        return 'QL-820NWB';
    }
  }
}
