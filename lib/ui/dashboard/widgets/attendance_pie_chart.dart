import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendancePieChart extends StatelessWidget {
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int excusedCount;
  final double height;

  const AttendancePieChart({
    super.key,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.excusedCount,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    final total = presentCount + absentCount + lateCount + excusedCount;

    if (total == 0) {
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
      child: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: _createSections(),
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildLegend(),
        ],
      ),
    );
  }

  List<PieChartSectionData> _createSections() {
    final total = presentCount + absentCount + lateCount + excusedCount;

    return [
      PieChartSectionData(
        color: Colors.green,
        value: presentCount.toDouble(),
        title: '${((presentCount / total) * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: absentCount.toDouble(),
        title: '${((absentCount / total) * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: lateCount.toDouble(),
        title: '${((lateCount / total) * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: excusedCount.toDouble(),
        title: '${((excusedCount / total) * 100).toStringAsFixed(1)}%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem('Present', Colors.green, presentCount),
        _buildLegendItem('Absent', Colors.red, absentCount),
        _buildLegendItem('Late', Colors.orange, lateCount),
        _buildLegendItem('Excused', Colors.blue, excusedCount),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          '$label ($count)',
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
