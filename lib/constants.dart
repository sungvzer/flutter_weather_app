import 'package:flutter/material.dart';

class AppConstants {
  static Color iconColor = Colors.blue.shade500;
  static String apiUrl = 'https://api.open-meteo.com/v1/forecast';
  static String apiParams =
      '?latitude=40.8762&longitude=14.5195&hourly=temperature_2m,precipitation_probability,weathercode&daily=sunrise,sunset&timezone=auto&forecast_days=1';

  static final wmoToImageCode = {
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
}
