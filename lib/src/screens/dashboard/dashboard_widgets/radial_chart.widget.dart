/// Package imports
import 'package:dashboard/src/classes/constents.class.dart';
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Render the radial bar customization.
class AnimationRadialChart extends StatefulWidget {
  /// Cretaes customised  radial bar series.
  const AnimationRadialChart({super.key});

  @override
  State<AnimationRadialChart> createState() => _AnimationRadialChartState();
}

class _AnimationRadialChartState extends State<AnimationRadialChart> {
  TooltipBehavior? _tooltipBehavior;
  List<_ChartData>? dataSources;
  List<Color>? colors;
  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, format: 'point.x : point.y%');
    dataSources = <_ChartData>[
      _ChartData(
          x: 'Vehicle',
          y: 62.70,
          text: '10%',
          pointColor: const Color.fromRGBO(69, 186, 161, 1.0)),
      _ChartData(
          x: 'Education',
          y: 29.20,
          text: '10%',
          pointColor: const Color.fromRGBO(230, 135, 111, 1.0)),
      _ChartData(
          x: 'Home',
          y: 85.20,
          text: '100%',
          pointColor: const Color.fromRGBO(145, 132, 202, 1.0)),
      _ChartData(
          x: 'Personal',
          y: 45.70,
          text: '100%',
          pointColor: const Color.fromRGBO(235, 96, 143, 1.0))
    ];

    colors = const <Color>[
      Color.fromRGBO(69, 186, 161, 1.0),
      Color.fromRGBO(230, 135, 111, 1.0),
      Color.fromRGBO(145, 132, 202, 1.0),
      Color.fromRGBO(235, 96, 143, 1.0)
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCustomizedRadialBarChart();
  }

  /// Return the circular chart with radial customization.
  SfCircularChart _buildCustomizedRadialBarChart() {
    return SfCircularChart(
      title: ChartTitle(text: ''),
      series: _getRadialBarCustomizedSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  /// Returns radial bar which need to be customized.
  List<RadialBarSeries<_ChartData, String>> _getRadialBarCustomizedSeries() {
    return <RadialBarSeries<_ChartData, String>>[
      RadialBarSeries<_ChartData, String>(
        animationDuration: 0,
        maximumValue: 100,
        gap: '10%',
        radius: '100%',
        dataSource: <_ChartData>[
          _ChartData(
            x: 'Vehicle',
            y: 62.70,
            text: '100%',
            pointColor: Colors.redAccent,
          ),
          _ChartData(
            x: 'Education',
            y: 29.20,
            text: '100%',
            pointColor: Colors.orange,
          ),
          _ChartData(
            x: 'Home',
            y: 85.20,
            text: '100%',
            pointColor: Colors.indigoAccent,
          ),
          _ChartData(
            x: 'Personal',
            y: 45.70,
            text: '100%',
            pointColor: primaryColor,
          )
        ],
        cornerStyle: CornerStyle.bothCurve,
        innerRadius: '50%',
        xValueMapper: (_ChartData data, _) => data.x,
        yValueMapper: (_ChartData data, _) => data.y,
        pointRadiusMapper: (_ChartData data, _) => data.text,

        /// Color mapper for each bar in radial bar series,
        /// which is get from datasource.
        pointColorMapper: (_ChartData data, _) => data.pointColor,
        legendIconType: LegendIconType.circle,
      ),
    ];
  }

  @override
  void dispose() {
    dataSources!.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData({
    required this.x,
    required this.y,
    required this.text,
    required this.pointColor,
  });

  final String x;
  final double y;
  final String text;
  final Color pointColor;
}
