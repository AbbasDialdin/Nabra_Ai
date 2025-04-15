import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../models/emotion_type.dart';

class EmotionChart extends StatelessWidget {
  final Map<String, int> emotionCounts;

  const EmotionChart({super.key, required this.emotionCounts});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = emotionCounts.map(
      (key, value) => MapEntry(key, value.toDouble()),
    );

    final List<Color> colorList =
        emotionCounts.keys
            .map((key) => EmotionTypes.getByName(key).color)
            .toList();

    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartRadius: MediaQuery.of(context).size.width * 0.7,
      colorList: colorList,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValueBackground: false,
      ),
    );
  }
}
