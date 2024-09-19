import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/device_args.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/repositories/devices_repository.dart';
import 'package:sic_home/ui/routes/blocs/dashboard_bloc.dart';
import 'package:sic_home/ui/styles/text_styles.dart';
import 'package:sic_home/ui/widgets/device_widget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DevicesRepository(),
      child: BlocProvider(
        create: (context) =>
            DashboardBloc(RepositoryProvider.of<DevicesRepository>(context))
              ..add(LoadEvent()),
        child: const DashboardContent(),
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        // if (state.state == DashboardStates.loading) {
        //   showDialog(
        //     barrierColor: const Color.fromRGBO(255, 255, 255, 0.05),
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (context) => PopScope(
        //       canPop: false,
        //       child: BackdropFilter(
        //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        //         child: const Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       ),
        //     ),
        //   );
        // }

        // if (state.state == DashboardStates.loaded ||
        //     state.state == DashboardStates.error) {
        //   RouteGenerator.mainNavigatorkey.currentState?.pop();
        // }

        // if (state.state == DashboardStates.error) {
        //   showDialog(
        //     barrierColor: const Color.fromRGBO(255, 255, 255, 0.05),
        //     context: context,
        //     builder: (context) => PopScope(
        //       canPop: false,
        //       child: BackdropFilter(
        //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        //         child: AlertDialog(
        //           title: const Text('Error'),
        //           content:
        //               const Text('An error occurred while loading devices'),
        //           actions: [
        //             TextButton(
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: const Text('OK'),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   );
        // }
      },
      builder: (context, state) => Scaffold(
        body: state.devices.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DeviceWidget(
                    DeviceArgs(
                      AuthenticationRepository()
                          .authenticationService
                          .currentUser()!,
                      state.devices[index],
                    ),
                  ),
                ),
                itemCount: state.devices.length,
              )
            : Center(
                child: Text(
                  'No devices found',
                  style: TextStyles.subtitleStyle,
                ),
              ),
      ),
    );
  }
}
