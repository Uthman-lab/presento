import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendanceBarChart extends StatelessWidget {
  final List<AttendanceDataPoint> dataPoints;
  final double height;

  const AttendanceBarChart({
    super.key,
    required this.dataPoints,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (dataPoints.isEmpty) {
      return Container(
        height: height,
        child: const Center(
          child: Text(
            'No attendance data available',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxValue(),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final dataPoint = dataPoints[group.x.toInt()];
                return BarTooltipItem(
                  '${dataPoint.date}\nPresent: ${dataPoint.presentCount}\nAbsent: ${dataPoint.absentCount}',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= dataPoints.length) return const Text('');
                  final dataPoint = dataPoints[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      dataPoint.shortDate,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: _createBarGroups(),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
              );
            },
          ),
        ),
      ),
    );
  }

  double _getMaxValue() {
    if (dataPoints.isEmpty) return 10;

    double maxValue = 0;
    for (final dataPoint in dataPoints) {
      final total =
          dataPoint.presentCount +
          dataPoint.absentCount +
          dataPoint.lateCount +
          dataPoint.excusedCount;
      if (total > maxValue) {
        maxValue = total.toDouble();
      }
    }
    return maxValue + 2; // Add some padding
  }

  List<BarChartGroupData> _createBarGroups() {
    return dataPoints.asMap().entries.map((entry) {
      final index = entry.key;
      final dataPoint = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: dataPoint.presentCount.toDouble(),
            color: Colors.green,
            width: 8,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
          ),
          BarChartRodData(
            toY: dataPoint.absentCount.toDouble(),
            color: Colors.red,
            width: 8,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
          ),
          BarChartRodData(
            toY: dataPoint.lateCount.toDouble(),
            color: Colors.orange,
            width: 8,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
          ),
          BarChartRodData(
            toY: dataPoint.excusedCount.toDouble(),
            color: Colors.blue,
            width: 8,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
            ),
          ),
        ],
      );
    }).toList();
  }
}

class AttendanceDataPoint {
  final String date;
  final String shortDate;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;

  AttendanceDataPoint({
    required this.date,
    required this.shortDate,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.excusedCount,
  });
}
