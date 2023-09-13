import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/pages/home_page/components/date_text.dart';
import 'package:weather_app/pages/home_page/components/hourly_forecast.dart';
import 'package:weather_app/pages/home_page/components/overview_grid.dart';
import 'package:weather_app/pages/home_page/components/temperature_chart.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(context, ref) {
    return Container(
      color: const Color(0xfff0f4fa),
      child: SafeArea(
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
              const TemperatureChart()
            ],
          ),
        ),
      ),
    );
  }
}
