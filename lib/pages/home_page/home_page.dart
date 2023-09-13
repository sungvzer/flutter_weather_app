import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:weather_app/pages/home_page/components/date_text.dart';
import 'package:weather_app/pages/home_page/components/line_chart.dart';
import 'package:weather_app/pages/home_page/components/overview_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: ListView(
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
            const CustomLineChart(
              spots: [
                FlSpot(0.0, 6.2),
                FlSpot(1.0, 6.8),
                FlSpot(2.0, 6.9),
                FlSpot(3.0, 6.7),
                FlSpot(4.0, 7.2),
                FlSpot(5.0, 8.0),
                FlSpot(6.0, 8.4),
                FlSpot(7.0, 9.5),
                FlSpot(8.0, 10.0),
                FlSpot(9.0, 11.9),
                FlSpot(10.0, 11.5),
                FlSpot(11.0, 12.0),
                FlSpot(12.0, 11.8),
                FlSpot(13.0, 11.6),
                FlSpot(14.0, 11.3),
                FlSpot(15.0, 11.0),
                FlSpot(16.0, 10.6),
                FlSpot(17.0, 10.2),
                FlSpot(18.0, 9.8),
                FlSpot(19.0, 9.4),
                FlSpot(20.0, 9.0),
                FlSpot(21.0, 8.6),
                FlSpot(22.0, 8.2),
                FlSpot(23.0, 7.8),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemCount: 24,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => HourlyCard(
          hour: index,
          temperature: index,
          rainChance: index + 10,
          wmoCode: 10,
          sunset: 19,
          sunrise: 7,
        ),
        separatorBuilder: (context, index) => const Divider(),
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

  static final association = {
    0: "01",
    1: "01",
    2: "02",
    3: "03",
    45: "50",
    48: "50",
    51: "09",
    53: "09",
    55: "09",
    56: "09",
    57: "09",
    61: "10",
    63: "10",
    65: "10",
    66: "10",
    67: "10",
    71: "13",
    73: "13",
    75: "13",
    77: "13",
    80: "09",
    81: "09",
    82: "09",
    85: "13",
    86: "13",
    95: "11",
    96: "11",
    99: "11"
  };

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
              'assets/images/${association[61]}${hour > sunrise && hour < sunset ? 'd' : 'n'}.png',
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
