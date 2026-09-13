import 'package:flutter/material.dart';
import 'package:lustlist/src/config/enums/scale_value.dart';
import 'package:lustlist/src/config/enums/theme_mode_extension.dart';
import 'package:lustlist/src/config/strings/data_strings.dart';
import 'package:lustlist/src/config/strings/page_title_strings.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/providers/scale_provider.dart';
import 'package:lustlist/src/ui/controllers/home_navigation_controller.dart';
import 'package:lustlist/src/ui/widgets/main_appbar.dart';
import 'package:lustlist/src/ui/widgets/main_bnb.dart';
import 'package:lustlist/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';


class AppearancePage extends StatefulWidget {
  const AppearancePage({super.key});

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  late final themeProvider = context.read<ThemeProvider>();
  late ThemeMode _themeMode = themeProvider.currentThemeMode;

  late final scaleProvider = context.read<ScaleProvider>();
  late ScaleValue _scaleValue = scaleProvider.currentScaleValue;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: PageTitleStrings.appearance,
        backButton: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(AppIconData.backButton),
          color: context.theme.appBarColors.icon,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
        child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

            children: [
              ListTile(
                leading: Icon(
                  _themeMode.iconData,
                  size: context.sizes.iconBasic,
                ),
                title: Text(
                  DataStrings.theme,
                  style: TextStyle(fontSize: context.sizes.titleSmall),
                ),
                trailing: buildThemeDropdownButton(),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.fullscreen,
                  size: context.sizes.iconBasic,
                ),
                title: Text(
                  DataStrings.scale,
                  style: TextStyle(fontSize: context.sizes.titleSmall),
                ),
                trailing: buildScalingDropdownButton(),
              )
            ]
        ),
      ),
      bottomNavigationBar: MainBottomNavigationBar(
          currentIndex: HomeNavigationController.pageIndex.value,
          context: context
      ),
    );
  }


  _DesignDropdownButton<ThemeMode> buildThemeDropdownButton() {
    return _DesignDropdownButton<ThemeMode>(
      value: _themeMode,
      onChanged: (ThemeMode? themeMode) {
        setState(() {
          _themeMode = themeMode!;
          themeProvider.setThemeMode(_themeMode);
        });
      },
      items: ThemeMode.values.map<DropdownMenuItem<ThemeMode>>((ThemeMode value) {
        return DropdownMenuItem<ThemeMode>(
          value: value,
          child: Text(
            value.label,
            style: TextStyle(
              fontSize: context.sizes.textBasic,
              color: context.theme.addEventColors.coloredText
            ),
          ));
      }).toList(),
    );
  }

  _DesignDropdownButton<ScaleValue> buildScalingDropdownButton() {
    return _DesignDropdownButton<ScaleValue>(
      value: _scaleValue,
      onChanged: (ScaleValue? scaleValue) {
        setState(() {
          _scaleValue = scaleValue!;
          scaleProvider.setFactor(_scaleValue);
        });
      },
      items: ScaleValue.values.map<DropdownMenuItem<ScaleValue>>((ScaleValue value) {
        return DropdownMenuItem<ScaleValue>(
            value: value,
            child: Text(
              value.label,
              style: TextStyle(
                  fontSize: context.sizes.textBasic,
                  color: context.theme.addEventColors.coloredText
              ),
            ));
      }).toList(),
    );
  }
  
}


class _DesignDropdownButton<T> extends StatelessWidget {
  const _DesignDropdownButton({
    required this.value,
    required this.onChanged,
    required this.items,
    super.key,
  });
  
  final T value;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;
  

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isDense: true,
      value: value,
      icon: const Icon(AppIconData.dropList),
      alignment: Alignment.centerLeft,
      style: TextStyle(
          color: context.theme.addEventColors.text,
          fontSize: context.sizes.textBasic
      ),
      underline: Container(height: 2, color: context.theme.addEventColors.border),
      onChanged: onChanged,
      items: items
    );
  }
}

