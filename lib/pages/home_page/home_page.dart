import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/pages/home_page/components/date_text.dart';
import 'package:weather_app/pages/home_page/components/hourly_forecast.dart';
import 'package:weather_app/pages/home_page/components/overview_grid.dart';
import 'package:weather_app/pages/home_page/components/overview_title.dart';
import 'package:weather_app/pages/home_page/components/temperature_chart.dart';
import 'package:weather_app/providers/weather_provider.dart';

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
                        onPressed: () async {
                          final service =
                              ref.read(weatherNotifierProvider.notifier);
                          service.getForecasts();
                        },
                        tooltip:
                            FlutterI18n.translate(context, 'general.refresh'),
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          FontAwesomeIcons.arrowsRotate,
                        ),
                        color: AppConstants.iconColor,
                      ),
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
              const OverviewTitle(),
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
