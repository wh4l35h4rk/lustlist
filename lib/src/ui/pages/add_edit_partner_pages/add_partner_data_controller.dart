import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/ui/widgets/date_picker.dart';
import 'package:lustlist/src/config/enums/gender.dart';


class AddPartnerDataController {
  String? name;
  DateTime date;
  Gender gender;

  AddPartnerDataController({
    required this.date,
    this.name,
    Gender? gender
  }) : gender = gender ?? Gender.nonbinary;

  late final DateController dateController = DateController(date);
  late final TextEditingController nameController = TextEditingController();

  void setName(String newName) {
    name = newName;
  }

  void setGender(Gender newGender) {
    gender = newGender;
  }
}