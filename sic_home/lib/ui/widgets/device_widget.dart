import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/device.dart';
import 'package:sic_home/models/device_args.dart';
import 'package:sic_home/ui/routes/blocs/device_bloc.dart';
import 'package:sic_home/ui/styles/text_styles.dart';

class DeviceWidget extends StatelessWidget {
  final DeviceArgs deviceArgs;

  const DeviceWidget(this.deviceArgs, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeviceBloc(deviceArgs.device, deviceArgs.user),
      child: deviceArgs.device.deviceType == DeviceType.analog
          ? AnalogDeviceWidget(deviceArgs.device)
          : OnOffDeviceWidget(deviceArgs.device),
    );
  }
}

class OnOffDeviceWidget extends StatelessWidget {
  final Device device;

  const OnOffDeviceWidget(this.device, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              device.name,
              style: TextStyles.titleStyleDark,
            ),
          ),
          BlocBuilder<DeviceBloc, DeviceState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () => BlocProvider.of<DeviceBloc>(context).add(
                  const DeviceEvent('1'),
                ),
                child: const Text(
                  'On / Off',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AnalogDeviceWidget extends StatelessWidget {
  final Device device;
  final dataPoints = <FlSpot>[];
  int totalPointsCount = 0;

  AnalogDeviceWidget(this.device, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              device.name,
              style: TextStyles.titleStyleDark,
            ),
          ),
          BlocConsumer<DeviceBloc, DeviceState>(
            listener: (context, state) {
              log('Device state: ${state.data}');

              if (state.state != DeviceStates.initial &&
                  state.data.isNotEmpty) {
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
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 0, right: 10, left: 0),
                  child: SizedBox(
                    height: 200,
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
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: const AxisTitles(
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
                              interval: state.maxData / 10 == 0
                                  ? 1
                                  : state.maxData / 10,
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
                        maxY: state.maxData,
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
