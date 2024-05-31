import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGraph extends StatefulWidget {
  const MyGraph({super.key});

  @override
  State<MyGraph> createState() => _MyGraphState();
}

class _MyGraphState extends State<MyGraph> {
  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
        reservedSize: 40,
        getTitlesWidget: getTiles,
      )),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    )));
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text('01', style: style);
        break;
      case 1:
        text = const Text('02', style: style);
        break;
      case 2:
        text = const Text('03', style: style);
        break;
      case 3:
        text = const Text('04', style: style);
        break;
      case 4:
        text = const Text('05', style: style);
        break;
      case 5:
        text = const Text('06', style: style);
        break;
      case 6:
        text = const Text('07', style: style);
        break;
      case 7:
        text = const Text('08', style: style);
        break;
      case 8:
        text = const Text('09', style: style);
        break;

      default:
        text = const Text('', style: style);
    }
    return SideTitleWidget(axisSide: meta.axisSide, space: 10, child: text);
  }

  Widget leftTiles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text('1k', style: style);
        break;
      case 1:
        text = const Text('2k', style: style);
        break;
      case 2:
        text = const Text('3k', style: style);
        break;
      case 3:
        text = const Text('4k', style: style);
        break;
      case 4:
        text = const Text('5k', style: style);
        break;
      case 5:
        text = const Text('6k', style: style);
        break;
      case 6:
        text = const Text('7k', style: style);
        break;
      case 7:
        text = const Text('8k', style: style);
        break;
      case 8:
        text = const Text('9k', style: style);
        break;
      case 9:
        text = const Text('10k', style: style);
        break;

      default:
        return Container();
    }

    return SideTitleWidget(axisSide: meta.axisSide, space: 0, child: text);
  }
}
