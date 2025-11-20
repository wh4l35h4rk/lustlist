import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/strings/page_strings.dart';
import 'package:lustlist/src/presentation/widgets/main_appbar.dart';
import 'package:lustlist/src/presentation/widgets/main_bnb.dart';
import 'package:lustlist/src/presentation/controllers/home_navigation_controller.dart';


class LoadingScaffold extends StatefulWidget{
  final bool hasBackButton;

  const LoadingScaffold({
    super.key,
    required this.hasBackButton
  });

  @override
  State<LoadingScaffold> createState() => _LoadingScaffoldState();
}

class _LoadingScaffoldState extends State<LoadingScaffold> {
  late bool hasBackButton = widget.hasBackButton;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: PageStrings.loading,
        backButton: hasBackButton ?
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.appBar.icon(context),
        ) : null
      ),
      body: const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: MainBottomNavigationBar(
          context: context,
          currentIndex: HomeNavigationController.pageIndex.value
      ),
    );
  }
}