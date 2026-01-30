import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/enums/gender.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/widgets/birthday_picker.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/widgets/name_form.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/core/widgets/info_row.dart';


class AddEditPartnerDataColumn extends StatefulWidget {
  final dynamic controller;

  const AddEditPartnerDataColumn({
    super.key,
    required this.controller
  });

  @override
  State<AddEditPartnerDataColumn> createState() => _AddEditPartnerDataColumnState();
}

class _AddEditPartnerDataColumnState extends State<AddEditPartnerDataColumn> {
  late Gender selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.controller.gender;
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = AppColors.addEvent.icon(context);
    Color titleColor = AppColors.addEvent.title(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              StringFormatter.colon(DataStrings.name),
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.addEvent.title(context),
                fontSize: AppSizes.titleLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.person,
              color: AppColors.addEvent.leadingIcon(context),
            ),
          ],
        ),
        SizedBox(height: 5),
        NameForm(controller: widget.controller.nameController),
        Padding(
          padding: AppInsets.dataDivider,
          child: Divider(),
        ),
        InfoRow(
            iconData: selectedGender.iconData,
            iconColor: iconColor,
            title: StringFormatter.colon(DataStrings.gender),
            titleColor: titleColor,
            child: Row(
              children: [
                SizedBox(width: 3),
                DropdownButton<Gender>(
                  isDense: true,
                  value: selectedGender,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  alignment: Alignment.centerLeft,
                  style: TextStyle(color: AppColors.addEvent.text(context), fontSize: AppSizes.textBasic),
                  underline: Container(height: 2, color: AppColors.addEvent.border(context)),
                  onChanged: (Gender? gender) {
                    setState(() {
                      selectedGender = gender!;
                      widget.controller.setGender(gender);
                    });
                  },
                  items: Gender.entries.map<DropdownMenuItem<Gender>>((Gender value) {
                    return DropdownMenuItem<Gender>(
                        value: value,
                        child: Text(
                          value.label,
                          style: TextStyle(
                            fontSize: AppSizes.textBasic,
                            color: AppColors.addEvent.coloredText(context)
                          ),
                        ));
                  }).toList(),
                ),
              ],
            )
        ),
        InfoRow(
          iconData: Icons.cake,
          iconColor: iconColor,
          title: StringFormatter.colon(DataStrings.birthday),
          titleColor: titleColor,
          child: BirthdayPicker(
            controller: widget.controller.dateController,
            initBirthday: widget.controller.dateController.date,
          )
        ),
      ],
    );
  }
}