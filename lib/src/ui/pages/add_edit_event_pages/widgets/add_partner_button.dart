import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/providers/scale_provider.dart';


class AddPartnerButton extends StatefulWidget {
  const AddPartnerButton({
    super.key,
    required this.context,
    required this.onTap,
  });

  final BuildContext context;
  final Function onTap;

  @override
  State<AddPartnerButton> createState() => _AddPartnerButtonState();
}

class _AddPartnerButtonState extends State<AddPartnerButton> {
  bool isPressed = false;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await widget.onTap();
          },
          onTapDown: (_) => setState(() => isPressed = true),
          onTapUp: (_) => setState(() => isPressed = false),
          onTapCancel: () => setState(() => isPressed = false),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isPressed
                  ? context.theme.addEventColors.buttonOnTap
                  : context.theme.addEventColors.surface,
              border: Border.all(
                width: 1.2,
                color: context.theme.addEventColors.border,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              AppIconData.add,
              size: context.sizes.iconAdd,
              color: context.theme.addEventColors.icon,
            ),
          ),
        ),
      ),
    );
  }
}