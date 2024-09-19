import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/create_section_model.dart';
import 'package:sic_home/models/place.dart';
import 'package:sic_home/models/place_args.dart';
import 'package:sic_home/models/section_args.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/repositories/sections_repository.dart';
import 'package:sic_home/repositories/users_repository.dart';
import 'package:sic_home/ui/routes/blocs/place_bloc.dart';
import 'package:sic_home/ui/routes/route_generator.dart';
import 'package:sic_home/ui/styles/text_styles.dart';

class PlacePage extends StatelessWidget {
  final PlaceArgs placeArgs;

  const PlacePage(this.placeArgs, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UsersRepository(),
        ),
        RepositoryProvider(
          create: (context) => SectionsRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => PlaceBloc(
          RepositoryProvider.of<UsersRepository>(context),
          RepositoryProvider.of<SectionsRepository>(context),
          placeArgs.user,
        )..add(LoadEvent()),
        child: BlocListener<PlaceBloc, PlaceState>(
          listener: (context, state) {
            if (state.state == PlaceStates.loading) {
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

            if (state.state == PlaceStates.loaded ||
                state.state == PlaceStates.error) {
              RouteGenerator.mainNavigatorkey.currentState?.pop();
            }

            if (state.state == PlaceStates.error) {
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
          child: PlaceContent(placeArgs.place),
        ),
      ),
    );
  }
}

class PlaceContent extends StatelessWidget {
  final Place place;

  const PlaceContent(this.place, {super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.name,
          style: TextStyles.greetingTitleStyle,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            log(state.user.places
                .where((element) => element.id == place.id)
                .first
                .sections
                .isNotEmpty
                .toString());
            log("Sections Length: ${state.user.places.where((element) => element.id == place.id).first.sections.length}");
            return state.user.places
                    .where((element) => element.id == place.id)
                    .first
                    .sections
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
                      onTap: () {
                        RouteGenerator.mainNavigatorkey.currentState?.pushNamed(
                          RouteGenerator.sectionPage,
                          arguments: SectionArgs(
                              state.user,
                              state.user.places
                                  .where((element) => element.id == place.id)
                                  .first
                                  .sections[index]),
                        );
                      },
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
                                    .where((element) => element.id == place.id)
                                    .first
                                    .sections[index]
                                    .name,
                                style: TextStyles.titleStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: state.user.places
                        .where((element) => element.id == place.id)
                        .first
                        .sections
                        .length,
                  )
                : Center(
                    child: Text(
                      'No Sections',
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
                title: const Text("Add Section"),
                content: TextField(
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
                actions: [
                  TextButton(
                    onPressed: () {
                      RouteGenerator.mainNavigatorkey.currentState?.pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<PlaceBloc>(context).add(
                        AddSectionEvent(
                          CreateSectionModel(
                            name: textController.text,
                            placeId: place.id,
                            userId: AuthenticationRepository()
                                .authenticationService
                                .currentUser()!
                                .id,
                          ),
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
