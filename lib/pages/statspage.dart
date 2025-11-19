import 'package:flutter/material.dart';
import '../widgets/animated_appbar.dart';


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
    return CustomScrollView(
        slivers: [
          AnimatedAppBar(title: "Statistics"),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 100),
              Center(child: CircularProgressIndicator())
            ]),
          ),
        ]
    );
  }
}