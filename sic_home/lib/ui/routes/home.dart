import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sic_home/models/create_place_model.dart';
import 'package:sic_home/models/place_args.dart';
import 'package:sic_home/repositories/authentication_repository.dart';
import 'package:sic_home/repositories/places_repository.dart';
import 'package:sic_home/repositories/users_repository.dart';
import 'package:sic_home/ui/routes/blocs/home_bloc.dart';
import 'package:sic_home/ui/routes/dashboard.dart';
import 'package:sic_home/ui/routes/live_feed.dart';
import 'package:sic_home/ui/routes/route_generator.dart';
import 'package:sic_home/ui/styles/text_styles.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UsersRepository(),
        ),
        RepositoryProvider(
          create: (context) => PlacesRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<UsersRepository>(context),
          RepositoryProvider.of<PlacesRepository>(context),
        )..add(LoadEvent()),
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.state == HomeStates.loading) {
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

            if (state.state == HomeStates.loaded ||
                state.state == HomeStates.error) {
              RouteGenerator.mainNavigatorkey.currentState?.pop();
            }

            if (state.state == HomeStates.error) {
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
          child: const HomeContent(),
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome 👋',
                style: TextStyles.greetingSubtitleStyle,
              ),
              Text(
                AuthenticationRepository()
                    .authenticationService
                    .currentUser()!
                    .userName,
                style: TextStyles.greetingTitleStyle,
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return TabBarView(
            controller: tabController,
            children: [
              const Dashboard(),
              Scaffold(
                body: SafeArea(
                  child: state.user.places.isNotEmpty
                      ? GridView.builder(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: BorderSide.strokeAlignCenter,
                            mainAxisSpacing: BorderSide.strokeAlignCenter,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => RouteGenerator
                                .mainNavigatorkey.currentState!
                                .pushNamed(RouteGenerator.placePage,
                                    arguments: PlaceArgs(
                                        state.user, state.user.places[index])),
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
                                      state.user.places[index].name,
                                      style: TextStyles.titleStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          itemCount: state.user.places.length,
                        )
                      : Center(
                          child: Text(
                            'No places yet',
                            style: TextStyles.subtitleStyle,
                          ),
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
                          title: const Text("Add Place"),
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
                                RouteGenerator.mainNavigatorkey.currentState
                                    ?.pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<HomeBloc>(context).add(
                                  AddPlaceEvent(
                                    CreatePlaceModel(
                                      name: textController.text,
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
              ),
              VideoStreamPage(),
            ],
          );
        },
      ),
      bottomNavigationBar: TabBar(
        controller: tabController,
        tabs: const [
          Tab(
            icon: Icon(Icons.dashboard),
          ),
          Tab(
            icon: Icon(Icons.home),
          ),
          Tab(
            icon: Icon(Icons.camera_outdoor_rounded),
          )
        ],
      ),
    );
  }
}
