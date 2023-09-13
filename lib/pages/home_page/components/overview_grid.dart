import 'package:flutter/material.dart';
import 'package:weather_app/pages/home_page/components/overview_card.dart';

class OverviewGrid extends StatelessWidget {
  const OverviewGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 120,
      ),
      itemBuilder: (_, int index) {
        Widget child;
        switch (index) {
          case 0:
            child = const OverviewCard(
              kind: CardKind.windSpeed,
            );
            break;
          case 1:
            child = const OverviewCard(
              kind: CardKind.rainChance,
            );
            break;
          case 2:
            child = const OverviewCard(
              kind: CardKind.temperature,
            );
            break;
          case 3:
            child = const OverviewCard(
              kind: CardKind.uvIndex,
            );
            break;
          default:
            throw Error();
        }
        return GridTile(
          child: child,
        );
      },
    );
  }
}
