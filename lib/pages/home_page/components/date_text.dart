import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateText extends StatefulWidget {
  const DateText({super.key});

  @override
  State<DateText> createState() => _DateTextState();
}

class _DateTextState extends State<DateText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return FutureBuilder(
      future: initializeDateFormatting(locale, null),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        }
        DateTime now = DateTime.now();
        return Text(
          DateFormat('EEEE, dd MMMM yyyy', locale).format(now),
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    );
  }
}
