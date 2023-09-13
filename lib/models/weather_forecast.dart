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
}
