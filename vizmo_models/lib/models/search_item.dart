import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SearchItem<T> {
  bool? selected;
  RxBool? selectedRxn;
  String name;
  Widget? title;
  Widget? description;
  Widget? leading;
  T? value;
  SearchItem({
    this.selected: false,
    required this.name,
    this.title,
    this.description,
    this.leading,
    this.value,
    this.selectedRxn,
  });
}
