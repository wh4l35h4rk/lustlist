import 'package:flutter/material.dart';

class BasicTile extends StatelessWidget {
  final Color surfaceColor;
  final Widget child;
  final EdgeInsets margin;

  const BasicTile({
    super.key,
    required this.surfaceColor,
    required this.child,
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      margin: margin,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: child,
    );
  }
}