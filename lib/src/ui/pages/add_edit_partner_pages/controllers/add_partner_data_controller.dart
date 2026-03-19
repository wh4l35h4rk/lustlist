import 'package:flutter/cupertino.dart';
import 'package:lustlist/src/config/enums/gender.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/controllers/partner_data_controller_base.dart';


class AddPartnerDataController extends PartnerDataControllerBase {
  AddPartnerDataController({
    required super.birthday,
    super.gender = Gender.unknown,
    super.name,
    super.pictureFile,
  });

  @override
  TextEditingController createNameController() {
    return TextEditingController();
  }
}