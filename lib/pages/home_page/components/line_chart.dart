import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomLineChart extends StatefulWidget {
  final List<FlSpot> spots;
  const CustomLineChart({super.key, required this.spots});

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  List<Color> gradientColors = [
    Colors.blue.shade800,
    Colors.blue.shade200,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.8,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    final firstSpot = widget.spots.first;
    var maxY = widget.spots.fold(firstSpot.y, (value, spot) {
      if (spot.y > value) return spot.y;
      return value;
    });
    maxY = ((maxY + 1) / 10).ceilToDouble() * 10;

    var maxX = widget.spots.fold(firstSpot.x, (value, spot) {
      if (spot.x > value) return spot.x;
      return value;
    });

    var minY = widget.spots.fold(firstSpot.y, (value, spot) {
      if (spot.y < value) return spot.y;
      return value;
    });
    var minX = widget.spots.fold(firstSpot.x, (value, spot) {
      if (spot.x < value) return spot.x;
      return value;
    });
    minY = ((minY - 1) / 10).floorToDouble() * 10;
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 5,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: const FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 3,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 5,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          top: BorderSide.none,
          bottom: BorderSide(
            color: Color(0x7737434d),
          ),
          left: BorderSide(
            color: Color(0x7737434d),
          ),
          right: BorderSide.none,
        ),
      ),
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineTouchData: const LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.transparent,
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: widget.spots,
          isCurved: true,
          curveSmoothness: 0.2,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          // color: Theme.of(context).primaryColor,
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
