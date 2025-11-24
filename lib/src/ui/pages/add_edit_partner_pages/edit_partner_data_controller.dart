import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';
import 'package:lustlist/src/config/enums/gender.dart';


class EditPartnerDataController {
  String name;
  DateTime? birthday;
  bool isBirthdayUnknown;
  Gender gender;

  EditPartnerDataController({
    required this.birthday,
    required this.isBirthdayUnknown,
    required this.name,
    required this.gender,
  });

  late final DateController dateController = DateController(date: birthday);
  late final TextEditingController nameController = TextEditingController(text: name);

  void setName(String newName) {
    name = newName;
  }

  void setGender(Gender newGender) {
    gender = newGender;
  }
}