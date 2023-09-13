import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/providers/weather_provider.dart';

class OverviewTitle extends ConsumerWidget {
  const OverviewTitle({
    super.key,
  });

  Widget getWidgetFromData(
    BuildContext context,
    WeatherForecast data,
  ) {
    return Row(
      children: [
        Skeleton.keep(
          child: Text(
            "${FlutterI18n.translate(context, "overview.header")} ",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Text(
          data.town,
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }

  @override
  Widget build(context, ref) {
    final location = ref.watch(weatherNotifierProvider);

    return Skeletonizer(
      enabled: location.isLoading,
      child: location.when(
        data: (data) => getWidgetFromData(
          context,
          data,
        ),
        error: (error, stackTrace) {
          Logger.root
              .severe('Could not get location $error', error, stackTrace);
          return Container();
        },
        loading: () => getWidgetFromData(
          context,
          mockedWeatherForecast,
        ),
      ),
    );
  }
}
