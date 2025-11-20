import 'package:flutter/material.dart';
import 'package:lustlist/src/config/constants/colors.dart';
import 'package:lustlist/src/config/constants/sizes.dart';
import 'calendar_widgets/change_theme_button.dart';
import 'package:texture/texture.dart';


class AnimatedAppBar extends StatelessWidget{
  final String title;

  const AnimatedAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 160.0;
    final double collapsedHeight = kToolbarHeight;

    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      backgroundColor: AppColors.appBar.surface(context),
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
                      color: AppColors.appBar.title(context)
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
                          AppColors.appBar.surface(context),
                          AppColors.appBar.surfaceGradient(context),
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
                    color: AppColors.appBar.surface(context).withValues(alpha: 0.8),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ],
              ),
            );
          }
      ),
      titleTextStyle: TextStyle(
        color: AppColors.appBar.title(context),
      ),
      actions: [
        ChangeThemeButton()
      ],
    );
  }
}