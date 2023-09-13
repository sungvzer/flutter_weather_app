import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

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
              color: AppConstants.iconColor,
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
