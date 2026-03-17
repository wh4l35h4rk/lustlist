import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'package:lustlist/src/core/formatters/string_formatters.dart';
import 'package:lustlist/src/domain/entities/event_duration.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/ui/pages/add_edit_event_pages/widgets/time_picker.dart';


class DurationPicker extends TimePicker {
  final String label;
  final bool enabled;

  const DurationPicker({
    super.key,
    required super.controller,
    required this.label,
    required this.enabled,
    super.type = 1,
  });

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends TimePickerState<DurationPicker> {
  bool get enabled => widget.enabled;
  double width = 150;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            height: 60,
            width: width,
            child: OutlinedButton(
              onPressed: enabled ? () => super.showDialog() : null,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                StringFormatter.duration(
                  EventDuration.explicit(0, time.hour, time.minute),
                  true
                ),
                style: TextStyle(
                  fontSize: AppSizes.textBasic,
                  color: enabled ? AppColors.text(context) : AppColors.defaultTile(context),
                  fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 2,
          child: ColoredBox(
            color: AppColors.surface(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.label,
                style: TextStyle(
                    color: enabled ? AppColors.text(context) : AppColors.defaultTile(context),
                    fontSize: AppSizes.textSmall
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}