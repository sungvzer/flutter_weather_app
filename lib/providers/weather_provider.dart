import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/services/weather_service.dart';

final weatherNotifierProvider =
    StateNotifierProvider<WeatherNotifier, AsyncValue<WeatherForecast>>(
  (ref) {
    WeatherService service = ref.read(weatherServiceProvider);
    return WeatherNotifier(service);
  },
);

class WeatherNotifier extends StateNotifier<AsyncValue<WeatherForecast>> {
  WeatherNotifier(this._service) : super(const AsyncLoading()) {
    getForecasts();
  }
  final WeatherService _service;

  void getForecasts() async {
    state = await _service.getForecast();
  }
}
