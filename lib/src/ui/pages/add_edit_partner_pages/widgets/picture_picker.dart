import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/styles.dart';
import 'package:lustlist/src/config/strings/button_strings.dart';
import 'package:lustlist/src/config/strings/misc_strings.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/controllers/partner_data_controller_base.dart';
import 'package:lustlist/src/ui/pages/add_edit_partner_pages/widgets/crop_image_page.dart';

class PicturePicker extends StatefulWidget {
  final PartnerDataControllerBase controller;

  const PicturePicker({
    super.key,
    required this.controller
  });

  @override
  State<PicturePicker> createState() => _PicturePickerState();
}

class _PicturePickerState extends State<PicturePicker> {
  File? galleryFile;
  final picker = ImagePicker();

  late PartnerDataControllerBase controller = widget.controller;

  @override
  Widget build(BuildContext context) {
    galleryFile = controller.pictureFile;

    return Builder(
      builder: (BuildContext context) {
        return Center(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: galleryFile == null
                  ? null
                  : () => FullscreenImageViewer.open(
                    context: context,
                    child: Image.file(galleryFile!),
                  ),
                child: CircleAvatar(
                  radius: 100,
                  child: galleryFile == null
                      ? Icon(
                    Icons.person_outlined,
                    size: 100,
                    color: AppColors.avatarIcon(context),
                  )
                      : ClipOval(
                    child: Image.file(
                      width: 200,
                      height: 200,
                      galleryFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _SetPictureButton(
                    onPressed: () {
                      setState(() {
                        galleryFile = null;
                        controller.setPictureFile(null);
                      });
                    },
                    iconData: AppIconData.notSelected,
                    title: ButtonStrings.noPicture
                  ),
                  _SetPictureButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    iconData: AppIconData.gallery,
                    title: ButtonStrings.gallery
                  ),
                  _SetPictureButton(
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    iconData: AppIconData.camera,
                    title: ButtonStrings.camera
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(MiscStrings.noPictureSelected)),
      );
      return;
    }
    final file = File(pickedFile.path);

    final croppedBytes = await Navigator.push<Uint8List>(
      context,
      MaterialPageRoute(builder: (_) => CropImagePage(file: file)),
    );

    if (croppedBytes != null) {
      final tempFile = await File('${file.parent.path}/cropped_${file.uri.pathSegments.last}')
          .writeAsBytes(croppedBytes);

      setState(() {
        galleryFile = tempFile;
        controller.setPictureFile(galleryFile);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(MiscStrings.noPictureSelected)),
      );
      return;
    }
  }
}


class _SetPictureButton extends StatelessWidget {
  const _SetPictureButton({
    required this.onPressed,
    required this.iconData,
    required this.title,
  });

  final VoidCallback onPressed;
  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: AppStyles.outlinedButton(AppColors.surface(context), context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData),
          SizedBox(width: 6),
          Text(title)
        ],
      )
    );
  }
}