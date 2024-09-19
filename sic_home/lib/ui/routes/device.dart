import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/device.dart';
import 'package:sic_home/models/device_args.dart';
import 'package:sic_home/ui/routes/blocs/device_bloc.dart';

class DevicePage extends StatelessWidget {
  final DeviceArgs deviceArgs;

  const DevicePage(this.deviceArgs, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeviceBloc(deviceArgs.device, deviceArgs.user),
      child: DeviceContent(deviceArgs.device),
    );
  }
}

class DeviceContent extends StatelessWidget {
  final Device device;
  final dataPoints = <FlSpot>[];
  int totalPointsCount = 0;

  DeviceContent(this.device, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
      ),
      body: BlocConsumer<DeviceBloc, DeviceState>(
        listener: (context, state) {
          log('Device state: ${state.data}');

          if (state.state != DeviceStates.initial && state.data.isNotEmpty) {
            totalPointsCount++;
            if (dataPoints.length > 10) {
              dataPoints.removeAt(0);
            }
            dataPoints.add(
              FlSpot(
                double.parse(totalPointsCount.toString()),
                double.parse(state.data),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
              child: LineChart(
                curve: Curves.easeInOut,
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 1,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        // color: AppColors.mainGridLineColor,
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return const FlLine(
                        // color: AppColors.mainGridLineColor,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: const FlTitlesData(
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
                        // getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        // getTitlesWidget: leftTitleWidgets,
                        reservedSize: 42,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d)),
                  ),
                  minY: 0,
                  maxY: 10,
                  lineBarsData: [
                    LineChartBarData(
                      spots: dataPoints,
                      isCurved: true,
                      // gradient: LinearGradient(
                      //   colors: gradientColors,
                      // ),
                      barWidth: 5,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        // gradient: LinearGradient(
                        //   colors: gradientColors
                        //       .map((color) => color.withOpacity(0.3))
                        //       .toList(),
                        // ),
                      ),
                    ),
                  ],
                ),
                // LineChartData(
                //   lineBarsData: [
                //     LineChartBarData(
                //       spots: dataPoints,
                //       isCurved: true,
                //       color: Colors.green,
                //       barWidth: 3,
                //       belowBarData: BarAreaData(show: false),
                //     )
                //   ],
                //   titlesData: const FlTitlesData(
                //     bottomTitles: AxisTitles(
                //       sideTitles: SideTitles(showTitles: true),
                //     ),
                //     leftTitles: AxisTitles(
                //       sideTitles: SideTitles(showTitles: true),
                //     ),
                //   ),
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
