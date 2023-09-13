import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HourlyForecast extends ConsumerWidget {
  const HourlyForecast({
    super.key,
  });

  Widget getWidgetWithData(BuildContext context, WeatherForecast data) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemCount: 24,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => HourlyCard(
          hour: index,
          temperature: data.temperatures[index].toInt(),
          rainChance: data.precipitation[index].toInt(),
          wmoCode: data.wmoCodes[index],
          sunset: data.sunsetHour,
          sunrise: data.sunriseHour,
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  @override
  Widget build(context, ref) {
    final weather = ref.watch(weatherNotifierProvider);

    return Skeletonizer(
      enabled: weather.isLoading,
      child: weather.when(
        data: (WeatherForecast data) => getWidgetWithData(context, data),
        error: (Object error, StackTrace stackTrace) {
          Logger.root
              .severe('Error building HourlyForecast', error, stackTrace);
          throw error;
        },
        loading: () => getWidgetWithData(context, mockedWeatherForecast),
      ),
    );
  }
}

class HourlyCard extends StatelessWidget {
  final int hour;
  final int temperature;
  final int rainChance;
  final int wmoCode;
  final int sunset;
  final int sunrise;

  const HourlyCard({
    super.key,
    required this.hour,
    required this.temperature,
    required this.rainChance,
    required this.wmoCode,
    required this.sunset,
    required this.sunrise,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "${hour.toString().padLeft(2, '0')}:00",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Skeleton.shade(
            child: Image(
              image: AssetImage(
                'assets/images/${AppConstants.wmoToImageCode[wmoCode]}${hour > sunrise && hour < sunset ? 'd' : 'n'}.png',
              ),
              height: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("$temperature°C / $rainChance%"),
        ],
      ),
    );
  }
}
