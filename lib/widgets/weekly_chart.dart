import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class WeeklyExpenseChart extends StatelessWidget {
  final Map<DateTime, double> weeklyExpenses;

  const WeeklyExpenseChart({
    super.key,
    required this.weeklyExpenses,
  });

  @override
  Widget build(BuildContext context) {
    if (weeklyExpenses.isEmpty) {
      return const Center(
        child: Text('No weekly data available'),
      );
    }

    // Sort dates
    final sortedDates = weeklyExpenses.keys.toList()
      ..sort((a, b) => a.compareTo(b));
    
    // Find max amount for scaling
    final maxAmount = weeklyExpenses.values.reduce(
      (max, value) => max > value ? max : value
    );

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxAmount * 1.2, // Add 20% padding at the top
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Theme.of(context).colorScheme.surface,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final date = sortedDates[groupIndex];
                final amount = weeklyExpenses[date]!;
                return BarTooltipItem(
                  '₺${amount.toStringAsFixed(2)}',
                  TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value < 0 || value >= sortedDates.length) {
                    return const SizedBox.shrink();
                  }
                  final date = sortedDates[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateFormat('E').format(date),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: _leftTitleWidgets,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          barGroups: List.generate(
            sortedDates.length,
            (index) {
              final date = sortedDates[index];
              final amount = weeklyExpenses[date] ?? 0;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: amount,
                    color: Theme.of(context).colorScheme.primary,
                    width: 20,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  static Widget _leftTitleWidgets(double value, TitleMeta meta) {
    if (value == 0) {
      return const SizedBox.shrink();
    }
    
    return Text(
      '₺${value.toInt()}',
      style: const TextStyle(fontSize: 10),
      textAlign: TextAlign.center,
    );
  }
}
