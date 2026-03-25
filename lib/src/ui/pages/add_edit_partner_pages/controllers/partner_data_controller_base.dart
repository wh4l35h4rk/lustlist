import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';
import 'package:lustlist/src/config/enums/gender.dart';


abstract class PartnerDataControllerBase {
  String? name;
  int? age;
  DateTime? birthday;
  Gender gender;
  File? pictureFile;

  PartnerDataControllerBase({
    required this.birthday,
    required this.gender,
    this.name,
    this.age,
    this.pictureFile,
  });

  late final DateController birthdayController = DateController(date: birthday);
  late final TextEditingController nameController = createNameController();
  late final TextEditingController ageController = createAgeController();

  TextEditingController createNameController();
  TextEditingController createAgeController();

  int? get ageValue {
    String value = ageController.text;
    if (value == "") return null;

    try {
      int numericValue = int.parse(value);
      return numericValue;
    } catch (e) {
      return null;
    }
  }

  void setName(String newName) {
    name = newName;
  }

  void setGender(Gender newGender) {
    gender = newGender;
  }

  void setPictureFile(File? newFile) {
    pictureFile = newFile;
  }
}