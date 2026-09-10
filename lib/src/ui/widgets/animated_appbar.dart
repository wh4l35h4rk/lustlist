import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lustlist/src/config/constants/icons.dart';
import 'package:lustlist/src/config/theme/app_theme.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'change_theme_button.dart';
import 'package:texture/texture.dart';


class AnimatedAppBar extends StatelessWidget{
  final String title;
  final bool hasBackButton;

  const AnimatedAppBar({
    super.key,
    required this.title,
    required this.hasBackButton
  });

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 160.0;
    final double collapsedHeight = kToolbarHeight;

    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: context.theme.mainColors.bnb
      ),
      pinned: true,
      snap: false,
      floating: false,
      leading: hasBackButton ? IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(AppIconData.backButton),
        color: context.theme.appBarColors.icon
      ) : null,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      backgroundColor: context.theme.appBarColors.surface,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double currentHeight = constraints.maxHeight;

            final double t = (1 - (currentHeight - collapsedHeight) / (expandedHeight - collapsedHeight)).clamp(0.0, 1.0);
            final Alignment alignment = Alignment.lerp(Alignment(-0.95, 1), Alignment(0.0, 1.1), t)!;

            return FlexibleSpaceBar(
              title: AnimatedAlign(
                alignment: alignment,
                duration: const Duration(milliseconds: 250),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: AppSizes.appbarAnimated,
                      color: context.theme.appBarColors.title
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.theme.appBarColors.surface,
                          context.theme.appBarColors.surfaceGradient,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Image.asset(
                    TexturesGet.bedgeGrunge,
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                    color: context.theme.appBarColors.surface.withValues(alpha: 0.8),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ],
              ),
            );
          }
      ),
      titleTextStyle: TextStyle(
        color: context.theme.appBarColors.title,
      ),
      actions: [
        ChangeThemeButton()
      ],
    );
  }
}