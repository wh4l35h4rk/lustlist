import 'package:flutter/material.dart';
import 'package:lustlist/widgets/loading_scaffold.dart';
import 'package:lustlist/widgets/main_bnb.dart';
import 'package:lustlist/widgets/main_appbar.dart';
import '../widgets/calendar_widgets/change_theme_button.dart';


class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}


class _StatsPageState extends State<StatsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScaffold(hasBackButton: false);
  }
}