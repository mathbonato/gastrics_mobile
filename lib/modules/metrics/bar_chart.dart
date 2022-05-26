import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample4 extends StatefulWidget {
  const BarChartSample4({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample4State();
}

class BarChartSample4State extends State<BarChartSample4> {
  final Color dark = Colors.green;
  final Color light = Colors.red;

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
            padding:
                const EdgeInsets.only(right: 0, left: 15, top: 15, bottom: 15),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(
                  enabled: true,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: false,
                  checkToShowHorizontalLine: (value) => value % 10 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: const Color(0xffe7e8ec),
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: true,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: 8,
                barGroups: getData(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 8,
        barRods: [
          BarChartRodData(
              toY: 20000,
              rodStackItems: [
                BarChartRodStackItem(0, 20000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 17000,
              rodStackItems: [
                BarChartRodStackItem(0, 17000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 31000,
              rodStackItems: [
                BarChartRodStackItem(0, 31000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 10000,
              rodStackItems: [
                BarChartRodStackItem(0, 17000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 34000,
              rodStackItems: [
                BarChartRodStackItem(0, 34000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 29000,
              rodStackItems: [
                BarChartRodStackItem(0, 29000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 15000,
              rodStackItems: [
                BarChartRodStackItem(0, 15000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 20000,
              rodStackItems: [
                BarChartRodStackItem(0, 20000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 30000,
              rodStackItems: [
                BarChartRodStackItem(0, 30000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 24000,
              rodStackItems: [
                BarChartRodStackItem(0, 24000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 25000,
              rodStackItems: [
                BarChartRodStackItem(0, 25000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 17000,
              rodStackItems: [
                BarChartRodStackItem(0, 17000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 8,
        barRods: [
          BarChartRodData(
              toY: 17000,
              rodStackItems: [
                BarChartRodStackItem(0, 17000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 35000,
              rodStackItems: [
                BarChartRodStackItem(0, 35000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 7,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 31000,
              rodStackItems: [
                BarChartRodStackItem(0, 31000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 19000,
              rodStackItems: [
                BarChartRodStackItem(0, 19000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 8,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 34000,
              rodStackItems: [
                BarChartRodStackItem(0, 34000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 17000,
              rodStackItems: [
                BarChartRodStackItem(0, 17000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 9,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 15000,
              rodStackItems: [
                BarChartRodStackItem(0, 15000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 16000,
              rodStackItems: [
                BarChartRodStackItem(0, 16000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 10,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 30000,
              rodStackItems: [
                BarChartRodStackItem(0, 30000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 10000,
              rodStackItems: [
                BarChartRodStackItem(0, 10000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
      BarChartGroupData(
        x: 11,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
              toY: 25000,
              rodStackItems: [
                BarChartRodStackItem(0, 25000, light),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              toY: 23000,
              rodStackItems: [
                BarChartRodStackItem(0, 23000, dark),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
        ],
      ),
    ];
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'JAN';
        break;
      case 1:
        text = 'FEV';
        break;
      case 2:
        text = 'MAR';
        break;
      case 3:
        text = 'ABR';
        break;
      case 4:
        text = 'MAI';
        break;
      case 5:
        text = 'JUN';
        break;
      case 6:
        text = 'JUL';
        break;
      case 7:
        text = 'AGO';
        break;
      case 8:
        text = 'SET';
        break;
      case 9:
        text = 'OUT';
        break;
      case 10:
        text = 'NOV';
        break;
      case 11:
        text = 'DEZ';
        break;
      default:
        text = '';
        break;
    }
    return Text(text, style: style);
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      color: Colors.white,
      fontSize: 12,
    );
    return Text(
      '${meta.formattedValue}',
      style: style,
    );
  }
}
