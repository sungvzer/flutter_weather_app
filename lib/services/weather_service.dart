import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/models/weather_forecast.dart';

final weatherServiceProvider =
    Provider<WeatherService>((ref) => WeatherService());

class WeatherService {
  Future<AsyncValue<WeatherForecast>> getForecast() async {
    try {
      var dio = Dio();
      Response response = await dio.get(
        '${AppConstants.apiUrl}/',
        queryParameters: {
          'latitude': '40.8762',
          'longitude': '14.5195',
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

      WeatherForecast forecast = WeatherForecast.fromJson(data);

      return AsyncData(forecast);
    } catch (e, stackTrace) {
      return AsyncError(e, stackTrace);
    }
  }
}
