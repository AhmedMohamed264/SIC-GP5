import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/device.dart';
import 'package:sic_home/ui/routes/blocs/device_bloc.dart';

class DevicePage extends StatelessWidget {
  final Device device;

  const DevicePage(this.device, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeviceBloc(device),
      child: DeviceContent(device),
    );
  }
}

class DeviceContent extends StatelessWidget {
  final Device device;

  const DeviceContent(this.device, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
      ),
      body: BlocBuilder<DeviceBloc, DeviceState>(
        builder: (context, state) {
          return Center(child: Text(state.data.toString()));
        },
      ),
    );
  }
}
