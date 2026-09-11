import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/layout.dart';
import 'package:lustlist/src/providers/scale_provider.dart';

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.divider,
      child: Divider(height: context.sizes.dividerMinimal,),
    );
  }
}