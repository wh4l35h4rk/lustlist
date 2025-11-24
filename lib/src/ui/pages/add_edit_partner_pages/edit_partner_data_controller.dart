import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/ui/widgets/date_picker.dart';
import 'package:lustlist/src/config/enums/gender.dart';


class EditPartnerDataController {
  String name;
  DateTime? date;
  Gender gender;

  EditPartnerDataController({
    required this.date,
    required this.name,
    required this.gender,
  });

  late final DateController dateController = DateController(date ?? defaultDate);
  late final TextEditingController nameController = TextEditingController(text: name);

  void setName(String newName) {
    name = newName;
  }

  void setGender(Gender newGender) {
    gender = newGender;
  }
}