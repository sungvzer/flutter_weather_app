import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/pages/home_page/components/date_text.dart';
import 'package:weather_app/pages/home_page/components/line_chart.dart';
import 'package:weather_app/pages/home_page/components/overview_grid.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(context, ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const DateText(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.refresh))
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              FlutterI18n.translate(context, "overview.header"),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            const OverviewGrid(),
            const SizedBox(
              height: 30,
            ),
            Text(
              FlutterI18n.translate(context, "hourly.header"),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            const HourlyForecast(),
            const SizedBox(
              height: 30,
            ),
            Text(
              FlutterI18n.translate(context, "graph.header"),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            const TemperatureLineChart()
          ],
        ),
      ),
    );
  }
}

class TemperatureLineChart extends ConsumerWidget {
  const TemperatureLineChart({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final weather = ref.watch(weatherNotifierProvider);

    return weather.when(
      data: (data) {
        final temperatures = data.temperatures;

        return CustomLineChart(
          spots: temperatures.indexed.map(
            (pair) {
              return FlSpot(pair.$1.toDouble(), pair.$2);
            },
          ).toList(),
        );
      },
      error: ((error, stackTrace) => Container()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class HourlyForecast extends ConsumerWidget {
  const HourlyForecast({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final weather = ref.watch(weatherNotifierProvider);

    return weather.when(
      data: (WeatherForecast data) {
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
      },
      error: (Object error, StackTrace stackTrace) {
        Logger.root.severe('Error building HourlyForecast', error, stackTrace);
        throw error;
      },
      loading: () => const CircularProgressIndicator(),
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
          Image(
            image: AssetImage(
              'assets/images/${AppConstants.wmoToImageCode[wmoCode]}${hour > sunrise && hour < sunset ? 'd' : 'n'}.png',
            ),
            height: 30,
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
