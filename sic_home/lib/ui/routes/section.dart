import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/create_device_model.dart';
import 'package:sic_home/models/device.dart';
import 'package:sic_home/models/device_args.dart';
import 'package:sic_home/models/section.dart';
import 'package:sic_home/models/section_args.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/repositories/devices_repository.dart';
import 'package:sic_home/repositories/users_repository.dart';
import 'package:sic_home/ui/routes/blocs/section_bloc.dart';
import 'package:sic_home/ui/routes/route_generator.dart';
import 'package:sic_home/ui/styles/text_styles.dart';

class SectionPage extends StatelessWidget {
  final SectionArgs sectionArgs;

  const SectionPage(this.sectionArgs, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UsersRepository(),
        ),
        RepositoryProvider(
          create: (context) => DevicesRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => SectionBloc(
          RepositoryProvider.of<UsersRepository>(context),
          RepositoryProvider.of<DevicesRepository>(context),
          sectionArgs.user,
        )..add(LoadEvent()),
        child: BlocListener<SectionBloc, SectionState>(
          listener: (context, state) {
            if (state.state == SectionStates.loading) {
              showDialog(
                barrierColor: const Color.fromRGBO(255, 255, 255, 0.05),
                barrierDismissible: false,
                context: context,
                builder: (context) => PopScope(
                  canPop: false,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              );
            }

            if (state.state == SectionStates.loaded ||
                state.state == SectionStates.error) {
              RouteGenerator.mainNavigatorkey.currentState?.pop();
            }

            if (state.state == SectionStates.error) {
              showDialog(
                barrierColor: const Color.fromRGBO(255, 255, 255, 0.05),
                context: context,
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: AlertDialog(
                    title: const Text("Error"),
                    content: Text(state.error!),
                  ),
                ),
              );
            }
          },
          child: SectionContent(sectionArgs.section),
        ),
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final Section section;

  const SectionContent(this.section, {super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final dropdownController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          section.name,
          style: TextStyles.greetingTitleStyle,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SectionBloc, SectionState>(
          builder: (context, state) {
            return state.user.places
                    .where((element) => element.sections
                        .any((element) => element.id == section.id))
                    .first
                    .sections
                    .where((element) => element.id == section.id)
                    .first
                    .devices
                    .isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: BorderSide.strokeAlignCenter,
                      mainAxisSpacing: BorderSide.strokeAlignCenter,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => RouteGenerator.mainNavigatorkey.currentState!
                          .pushNamed(RouteGenerator.devicePage,
                              arguments: DeviceArgs(
                                  state.user,
                                  state.user.places
                                      .where((element) => element.sections.any(
                                          (element) =>
                                              element.id == section.id))
                                      .first
                                      .sections
                                      .where(
                                          (element) => element.id == section.id)
                                      .first
                                      .devices[index])),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(20),
                        child: Stack(
                          children: [
                            Image.asset(
                              'lib/assets/bgs/cardbg1.png',
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: Text(
                                state.user.places
                                    .where((element) => element.sections.any(
                                        (element) => element.id == section.id))
                                    .first
                                    .sections
                                    .where(
                                        (element) => element.id == section.id)
                                    .first
                                    .devices[index]
                                    .name,
                                style: TextStyles.titleStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: state.user.places
                        .where((element) => element.sections
                            .any((element) => element.id == section.id))
                        .first
                        .sections
                        .where((element) => element.id == section.id)
                        .first
                        .devices
                        .length,
                  )
                : Center(
                    child: Text(
                      'No Devices',
                      style: TextStyles.subtitleStyle,
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierColor: const Color.fromRGBO(255, 255, 255, 0.05),
            context: context,
            builder: (_) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                title: const Text("Add Device"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        filled: true,
                        fillColor: Color.fromRGBO(80, 80, 80, 0.3),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownMenu(
                      onSelected: (value) {
                        log(dropdownController.text);
                      },
                      expandedInsets: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        top: 10,
                        bottom: 10,
                      ),
                      hintText: 'Device Data Type',
                      controller: dropdownController,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: DeviceDataType.integer,
                          label: 'On/Off',
                        ),
                        DropdownMenuEntry(
                          value: DeviceDataType.float,
                          label: 'Numerical Data',
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      RouteGenerator.mainNavigatorkey.currentState?.pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      log(dropdownController.text);
                      BlocProvider.of<SectionBloc>(context).add(
                        AddDeviceEvent(
                          CreateDeviceModel(
                            name: textController.text,
                            deviceType: dropdownController.text == 'On/Off'
                                ? DeviceType.onoff
                                : DeviceType.analog,
                            placeId: section.placeId,
                            sectionId: section.id,
                            userId: AuthenticationRepository()
                                .authenticationService
                                .currentUser()!
                                .id,
                          ),
                          (pin) {
                            showDialog(
                              barrierColor:
                                  const Color.fromRGBO(255, 255, 255, 0.05),
                              context: context,
                              builder: (_) => BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: AlertDialog(
                                  title: const Text("Assigned Pin"),
                                  content: Text(pin.toString()),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
