import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            child = OverviewCard(
              icon: FontAwesomeIcons.wind,
              title: FlutterI18n.translate(
                context,
                "overview.wind_speed",
              ),
              value: "51 km/h",
            );
            break;
          case 1:
            child = OverviewCard(
              icon: FontAwesomeIcons.cloudRain,
              title: FlutterI18n.translate(
                context,
                "overview.rain_chance",
              ),
              value: "18%",
            );
            break;
          case 2:
            child = OverviewCard(
              icon: FontAwesomeIcons.temperatureEmpty,
              title: FlutterI18n.translate(
                context,
                "overview.temperature",
              ),
              value: "18°C",
            );
            break;
          case 3:
            child = OverviewCard(
              icon: FontAwesomeIcons.sun,
              title: FlutterI18n.translate(
                context,
                "overview.uv_index",
              ),
              value: "2,3",
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
