import 'dart:math';

import 'package:dashboard/src/classes/constents.class.dart';

/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Renders the spline chart sample with dynamically updated data points.
class AnimationSplineChart extends StatefulWidget {
  /// Renders the spline chart sample with dynamically updated data points.
  const AnimationSplineChart({super.key});

  @override
  State<AnimationSplineChart> createState() => _AnimationSplineChartState();
}

class _AnimationSplineChartState extends State<AnimationSplineChart> {
  List<_ChartData>? _chartData;
  List<_ChartData>? _chartData2;

  @override
  Widget build(BuildContext context) {
    _getChartData();

    return _buildAnimationSplineChart();
  }

  /// get the spline chart sample with dynamically updated data points.
  SfCartesianChart _buildAnimationSplineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis:
            NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            majorTickLines: const MajorTickLines(color: Colors.transparent),
            axisLine: const AxisLine(width: 0),
            minimum: 0,
            maximum: 100),
        series: _getDefaultSplineSeries());
  }

  /// get the spline series sample with dynamically updated data points.
  List<SplineSeries<_ChartData, num>> _getDefaultSplineSeries() {
    return <SplineSeries<_ChartData, num>>[
      SplineSeries<_ChartData, num>(
        dataSource: _chartData!,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        color: primaryColor,
        width: 4,
        markerSettings: const MarkerSettings(
          isVisible: true,
          borderWidth: 5,
        ),
      ),
      SplineSeries<_ChartData, num>(
        dataSource: _chartData2!,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        color: Colors.purple,
        width: 4,
        markerSettings: const MarkerSettings(
          isVisible: true,
          borderWidth: 5,
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _chartData!.clear();
    _chartData2!.clear();
    super.dispose();
  }

  /// get the random value
  int _getRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  //Get the random data points
  void _getChartData() {
    _chartData = <_ChartData>[];
    _chartData2 = <_ChartData>[];
    for (int i = 0; i < 5; i++) {
      _chartData!.add(_ChartData(i, _getRandomInt(15, 85)));
      _chartData2!.add(_ChartData(i, _getRandomInt(15, 85)));
    }
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final int x;
  final int y;
}
