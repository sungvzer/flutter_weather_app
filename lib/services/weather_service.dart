import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/providers/location.dart';

final weatherServiceProvider = Provider<WeatherService>(
  (ref) => WeatherService(ref: ref),
);

class WeatherService {
  final ProviderRef ref;

  WeatherService({required this.ref});

  Future<AsyncValue<WeatherForecast>> getForecast() async {
    final location = await ref.read(gpsLocationProvider.future);

    try {
      var dio = Dio();
      Response response = await dio.get(
        '${AppConstants.weatherApiUrl}/',
        queryParameters: {
          'latitude': location.latitude,
          'longitude': location.longitude,
          'hourly':
              'temperature_2m,precipitation_probability,weathercode,windspeed_10m',
          'daily': 'sunrise,sunset,uv_index_max',
          'timezone': 'auto',
          'forecast_days': '1'
        },
        options: Options(
          method: 'GET',
        ),
      );
      var data = (response.data as Map<dynamic, dynamic>);

      response = await dio.get(
        AppConstants.locationApiUrl,
        queryParameters: {
          'lat': location.latitude,
          'lon': location.longitude,
          'format': 'json',
        },
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode != 200) {
        data['town'] = '???';
      } else {
        data['town'] = response.data['address']['town'];
      }

      WeatherForecast forecast = WeatherForecast.fromJson(data);

      return AsyncData(forecast);
    } catch (e, stackTrace) {
      return AsyncError(e, stackTrace);
    }
  }
}
