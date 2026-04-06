import 'dart:io';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/core/widgets/error_tile.dart';
import 'package:lustlist/src/ui/theme_provider.dart';
import 'package:provider/provider.dart';


class CropImagePage extends StatefulWidget {
  final File file;

  const CropImagePage({
    required this.file,
    super.key
  });

  @override
  State<CropImagePage> createState() => _CropImagePageState();
}

class _CropImagePageState extends State<CropImagePage> {
  final _cropController = CropController();
  late Future<Uint8List?> _imageData;

  Uint8List? _croppedData;

  @override
  void initState() {
    _imageData = widget.file.readAsBytes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late final themeProvider = context.read<ThemeProvider>();
    late bool isLight = themeProvider.themeMode == ThemeMode.light;
    Color itemsColor = isLight ? AppColors.surface(context) : AppColors.text(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            AppIconData.arrowLeft,
            color: itemsColor,
          )
        ),
        actions: [
          IconButton(
            onPressed: () => _cropController.crop(),
            icon: Icon(
              AppIconData.selected,
              color: itemsColor,
            )
          ),
        ],
        title: Text(
          PageTitleStrings.uploadPicture,
          style: TextStyle(
            color: itemsColor,
            fontSize: AppSizes.appbarBasic,
          )
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder(
          future: _imageData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: AppColors.surface(context));
            } else if (snapshot.hasError || !snapshot.hasData) {
              return ErrorTile();
            }
            final image = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Crop(
                willUpdateScale: (newScale) => newScale < 1,
                controller: _cropController,
                image: image,
                aspectRatio: 1,
                onCropped: (result) {
                  if (result is CropSuccess) {
                    _croppedData = result.croppedImage;
                    Navigator.pop(context, _croppedData);
                  }
                },
                withCircleUi: true,
                maskColor: Colors.black.withAlpha(100),
                baseColor: Colors.black,
                cornerDotBuilder: (size, edgeAlignment) => DotControl(
                  color: itemsColor,
                ),
                interactive: true,
                radius: 4,
                initialRectBuilder: InitialRectBuilder.withSizeAndRatio(
                  size: 0.95,
                  aspectRatio: 1,
                ),
                overlayBuilder: null,
              ),
            );
          }
        ),
      ),
    );
  }
}