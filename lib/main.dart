import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:logging/logging.dart';
import 'package:weather_app/pages/home_page/home_page.dart';

void main() {
  // Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color.fromARGB(255, 0x14, 0x25, 0x44);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            useCountryCode: false,
            // Enable if testing other languages
            // forcedLocale: const Locale('it'),
          ),
          missingTranslationHandler: (key, locale) {
            Logger.root.warning("Missing Key: $key");
          },
        ),
      ],
      // debugShowMaterialGrid: true,
      title: 'Flutter Demo',

      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: color,
          ),
          headlineSmall: TextStyle(
            color: color,
          ),
          headlineLarge: TextStyle(
            color: color,
          ),
          displayMedium: TextStyle(
            color: color,
          ),
          displaySmall: TextStyle(
            color: color,
          ),
          displayLarge: TextStyle(
            color: color,
          ),
          labelMedium: TextStyle(
            color: color,
          ),
          labelSmall: TextStyle(
            color: color,
          ),
          labelLarge: TextStyle(
            color: color,
          ),
          titleMedium: TextStyle(
            color: color,
          ),
          titleSmall: TextStyle(
            color: color,
          ),
          titleLarge: TextStyle(
            color: color,
          ),
          bodyMedium: TextStyle(
            color: color,
          ),
          bodySmall: TextStyle(
            color: color,
          ),
          bodyLarge: TextStyle(
            color: color,
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
