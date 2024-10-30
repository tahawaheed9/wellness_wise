import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomBarChart extends StatefulWidget {
  final double maxHeight;
  final List<BarData> dataList;

  const CustomBarChart({
    super.key,
    required this.maxHeight,
    required this.dataList,
  });

  final shadowColor = const Color(0xFFCCCCCC);

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  BarChartGroupData generateBarGroup(
    int x,
    double value,
    Color color,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceEvenly,
                borderData: FlBorderData(
                  show: true,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    drawBelowEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          textAlign: TextAlign.left,
                        );
                      },
                    ),
                  ),
                  bottomTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.black.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                ),
                barGroups: widget.dataList.asMap().entries.map((element) {
                  final index = element.key;
                  final data = element.value;
                  return generateBarGroup(
                    index,
                    data.barData['value'] as double,
                    data.barData['color'] as Color,
                  );
                }).toList(),
                maxY: widget.maxHeight,
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.transparent,
                    tooltipMargin: 0,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.toY.toString(),
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    if (event.isInterestedForInteractions &&
                        response != null &&
                        response.spot != null) {
                      setState(() {
                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                      });
                    } else {
                      setState(() {
                        touchedGroupIndex = -1;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BarData {
  final Map<String, Object> barData;

  const BarData({
    required this.barData,
  });
}

class _Indicator extends StatefulWidget {
  final Color color;
  final bool isSelected;

  const _Indicator({
    required this.color,
    required this.isSelected,
  });

  @override
  State<_Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
            color: widget.color,
            width: 5,
          ),
        ),
      ),
    );
  }
}
