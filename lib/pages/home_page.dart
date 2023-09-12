import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              FlutterI18n.translate(context, "overview.header"),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 120,
              ),
              itemBuilder: (_, int index) {
                Widget child;
                switch (index) {
                  case 0:
                    child = OverviewCard(
                      icon: FontAwesomeIcons.wind,
                      title: FlutterI18n.translate(
                        context,
                        "overview.wind_speed",
                      ),
                      value: "51 km/h",
                    );
                    break;
                  case 1:
                    child = OverviewCard(
                      icon: FontAwesomeIcons.cloudRain,
                      title: FlutterI18n.translate(
                        context,
                        "overview.rain_chance",
                      ),
                      value: "18%",
                    );
                    break;
                  case 2:
                    child = OverviewCard(
                      icon: FontAwesomeIcons.temperatureEmpty,
                      title: FlutterI18n.translate(
                        context,
                        "overview.temperature",
                      ),
                      value: "18°C",
                    );
                    break;
                  case 3:
                    child = OverviewCard(
                      icon: FontAwesomeIcons.sun,
                      title: FlutterI18n.translate(
                        context,
                        "overview.uv_index",
                      ),
                      value: "2,3",
                    );
                    break;
                  default:
                    throw Error();
                }
                return GridTile(
                  child: child,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const OverviewCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: Colors.blue.shade500,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black.withAlpha(150),
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
    String locale = 'it_IT'; //Localizations.localeOf(context).languageCode;
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
