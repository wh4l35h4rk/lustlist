import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/controllers/partner_data_controller_base.dart';


class EditPartnerDataController extends PartnerDataControllerBase {
  EditPartnerDataController({
    required super.birthday,
    required super.name,
    required super.gender,
    required super.age,
    super.pictureFile
  });

  @override
  TextEditingController createNameController() {
    return TextEditingController(text: name);
  }

  @override
  TextEditingController createAgeController() {
    return TextEditingController(text: age.toString());
  }
}