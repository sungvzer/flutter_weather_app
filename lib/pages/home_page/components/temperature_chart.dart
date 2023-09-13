import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/pages/home_page/components/line_chart.dart';
import 'package:weather_app/providers/weather_provider.dart';

class TemperatureChart extends ConsumerWidget {
  const TemperatureChart({
    super.key,
  });

  Widget getLineChartFromData(BuildContext context, WeatherForecast data) {
    final temperatures = data.temperatures;

    return Skeleton.replace(
      replacement: const Skeleton.shade(
        child: Icon(
          FontAwesomeIcons.chartLine,
          size: 200,
        ),
      ),
      child: CustomLineChart(
        spots: temperatures.indexed.map(
          (pair) {
            return FlSpot(pair.$1.toDouble(), pair.$2);
          },
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final weather = ref.watch(weatherNotifierProvider);

    return Skeletonizer(
      enabled: weather.isLoading,
      child: weather.when(
        data: (data) => getLineChartFromData(context, data),
        error: ((error, stackTrace) => Container()),
        loading: () => getLineChartFromData(context, mockedWeatherForecast),
      ),
    );
  }
}
