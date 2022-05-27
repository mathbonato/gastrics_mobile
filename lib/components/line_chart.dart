import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChart1 extends StatefulWidget {
  const LineChart1({Key? key}) : super(key: key);

  @override
  State<LineChart1> createState() => _LineChart1State();
}

class _LineChart1State extends State<LineChart1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1.70,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color(0xff232d37)),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: LineChart(mainData()),
          ),
        ),
      ),
    );
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('1', style: style);
      break;
    case 1:
      text = const Text('6', style: style);
      break;
    case 2:
      text = const Text('11', style: style);
      break;
    case 3:
      text = const Text('16', style: style);
      break;
    case 4:
      text = const Text('21', style: style);
      break;
    case 5:
      text = const Text('26', style: style);
      break;
    case 6:
      text = const Text('31', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff67727d),
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 2:
      text = '200';
      break;
    case 4:
      text = '400';
      break;
    case 6:
      text = '600';
      break;
    case 8:
      text = '800';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

LineChartData mainData() {
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
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
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
        ),
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 6,
    minY: 0,
    maxY: 8,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 6),
          FlSpot(1, 5),
          FlSpot(2, 5.5),
          FlSpot(3, 5.5),
          FlSpot(4, 6),
          FlSpot(5, 5),
          FlSpot(6, 5),
          //   FlSpot(12, 5.5),
        ],
        isCurved: false,
        color: Colors.red,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: const [
          FlSpot(0, 5),
          FlSpot(1, 4),
          FlSpot(2, 5),
          FlSpot(3, 4.7),
          FlSpot(4, 5),
          FlSpot(5, 4.5),
          FlSpot(6, 4),
        ],
        isCurved: false,
        color: Colors.blue,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: const [
          FlSpot(0, 2.9),
          FlSpot(1, 3),
          FlSpot(2, 3.4),
          FlSpot(3, 3),
          FlSpot(4, 3),
          FlSpot(5, 3.9),
          FlSpot(6, 3.5),
        ],
        isCurved: false,
        color: Colors.green,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
    ],
  );
}
