import 'package:flutter/widgets.dart';
import 'package:vizmo_models/models/attendee.dart';
import 'package:vizmo_models/models/checkin_data.dart';
import 'package:vizmo_models/models/desk_booking/desk_booking.dart';

import 'desk_booking/desk.dart';
import 'invite.dart';

abstract class GetArguments {
  @protected
  Map<String, dynamic> arguments = {};
}

class InviteGetArguments implements GetArguments {
  InviteGetArguments({
    // bool individual: false,
    Attendee? attendee,
    Invite? invite,
  }) : arguments = {
          'attendee': attendee,
          'invite': invite,
        };
  Attendee? get attendee => arguments['attendee'];

  // set attendee(Attendee attendee) {
  //   arguments['attendee'] = attendee;
  // }

  bool get individual => arguments['individual'] ?? false;

  // set selfRegister(bool selfRegister) {
  //   arguments['selfRegister'] = selfRegister;
  // }

  Invite? get invite => arguments['invite'];

  @override
  @protected
  Map<String, dynamic> arguments = {};
}

class CheckinGetArguments implements GetArguments {
  Invite? get invite => arguments['invite'];

  set invite(Invite? invite) {
    arguments['invite'] = invite;
  }

  bool get prefill => arguments['prefill'] ?? false;

  set prefill(bool prefill) {
    arguments['prefill'] = prefill;
  }

  bool get checkout => arguments['checkout'] ?? false;

  set checkout(bool checkout) {
    arguments['checkout'] = checkout;
  }

  CheckinData? get checkinData => arguments['checkinData'];

  set checkinData(CheckinData? checkinData) {
    arguments['checkinData'] = checkinData;
  }

  @override
  @protected
  Map<String, dynamic> arguments = {};
}

class DeskGetArguments implements GetArguments {
  DeskBooking? get deskBooking => arguments['deskBooking'];
  set deskBooking(DeskBooking? deskBooking) {
    arguments['deskBooking'] = deskBooking;
  }

  Desk? get desk => arguments['desk'];
  set desk(Desk? desk) {
    arguments['desk'] = desk;
  }

  @override
  Map<String, dynamic> arguments = {};
}
