import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/providers/weather_provider.dart';

enum CardKind { windSpeed, rainChance, temperature, uvIndex }

class OverviewCard extends ConsumerWidget {
  final CardKind kind;

  const OverviewCard({
    super.key,
    required this.kind,
  });

  IconData getIcon() {
    switch (kind) {
      case CardKind.windSpeed:
        return FontAwesomeIcons.wind;
      case CardKind.rainChance:
        return FontAwesomeIcons.cloudRain;
      case CardKind.temperature:
        return FontAwesomeIcons.temperatureEmpty;
      case CardKind.uvIndex:
        return FontAwesomeIcons.sun;
    }
  }

  String getTitle(BuildContext context) {
    switch (kind) {
      case CardKind.windSpeed:
        return FlutterI18n.translate(
          context,
          "overview.wind_speed",
        );
      case CardKind.rainChance:
        return FlutterI18n.translate(
          context,
          "overview.rain_chance",
        );
      case CardKind.temperature:
        return FlutterI18n.translate(
          context,
          "overview.temperature",
        );
      case CardKind.uvIndex:
        return FlutterI18n.translate(
          context,
          "overview.uv_index",
        );
    }
  }

  String getValue(WeatherForecast weather) {
    final hour = DateTime.now().hour;
    final currentTemperature = weather.temperatures[hour];
    final currentRainChance = weather.precipitation[hour];
    final currentWindSpeed = weather.windSpeed[hour];
    final currentUvIndex = weather.uvIndex;

    switch (kind) {
      case CardKind.windSpeed:
        return '$currentWindSpeed km/h';
      case CardKind.rainChance:
        return '$currentRainChance%';
      case CardKind.temperature:
        return '$currentTemperature°C';
      case CardKind.uvIndex:
        return '$currentUvIndex';
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final weather = ref.watch(weatherNotifierProvider);
    final title = getTitle(context);

    return weather.when(
      data: (data) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
            child: Row(
              children: [
                Icon(
                  getIcon(),
                  size: 25,
                  color: AppConstants.iconColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.black.withAlpha(150),
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        getValue(data),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Container();
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
