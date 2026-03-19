import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/ui/controllers/date_controller.dart';
import 'package:lustlist/src/config/enums/gender.dart';


class AddPartnerDataController {
  String? name;
  DateTime date;
  Gender gender;
  File? pictureFile;

  AddPartnerDataController({
    required this.date,
    this.name,
    this.gender = Gender.nonbinary,
    this.pictureFile
  });

  late final DateController dateController = DateController(date: date);
  late final TextEditingController nameController = TextEditingController();

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