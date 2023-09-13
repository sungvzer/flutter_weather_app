class WeatherForecast {
  final double latitude;
  final double longitude;

  final List<double> temperatures;
  final List<double> windSpeed;
  final List<int> precipitation;
  final List<int> wmoCodes;

  final int sunriseHour;
  final int sunsetHour;

  final double uvIndex;

  const WeatherForecast({
    required this.latitude,
    required this.longitude,
    required this.temperatures,
    required this.precipitation,
    required this.wmoCodes,
    required this.sunsetHour,
    required this.sunriseHour,
    required this.uvIndex,
    required this.windSpeed,
  });

  static WeatherForecast fromJson(Map<dynamic, dynamic> json) {
    final sunriseString = json['daily']['sunrise'][0] as String;
    DateTime sunriseDate = DateTime.parse(sunriseString);

    final sunsetString = json['daily']['sunset'][0] as String;
    DateTime sunsetDate = DateTime.parse(sunsetString);

    return WeatherForecast(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      temperatures: List<double>.from(json['hourly']['temperature_2m']),
      windSpeed: List<double>.from(json['hourly']['windspeed_10m']),
      precipitation:
          List<int>.from(json['hourly']['precipitation_probability']),
      wmoCodes: List<int>.from(json['hourly']['weathercode']),
      sunsetHour: sunsetDate.hour,
      sunriseHour: sunriseDate.hour,
      uvIndex: json['daily']['uv_index_max'][0],
    );
  }
}

final mockedWeatherForecast = WeatherForecast(
  latitude: 40,
  longitude: 30,
  temperatures: List<double>.generate(24, (index) => 10),
  precipitation: List<int>.generate(24, (index) => 10),
  wmoCodes: List<int>.generate(24, (index) => 1),
  sunsetHour: 7,
  sunriseHour: 20,
  uvIndex: 3.5,
  windSpeed: List<double>.generate(24, (index) => 10),
);
