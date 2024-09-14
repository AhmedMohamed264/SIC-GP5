import 'package:flutter/material.dart';
import 'package:sic_home/ui/routes/route_generator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteGenerator.startup,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: RouteGenerator.mainNavigatorkey,
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorLight: Colors.white,
        primaryColorDark: const Color.fromRGBO(230, 230, 230, 1),
        indicatorColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Color.fromRGBO(230, 230, 230, 1),
          tertiary: Colors.grey,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            backgroundColor: WidgetStatePropertyAll(Colors.black),
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: const Color.fromRGBO(16, 16, 16, 1),
        primaryColorDark: Colors.black,
        primaryColorLight: const Color.fromRGBO(80, 80, 80, 0.3),
        indicatorColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          surface: Color.fromRGBO(20, 20, 20, 1),
          primary: Colors.white,
          secondary: Color.fromRGBO(80, 80, 80, 0.3),
          tertiary: Colors.grey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromRGBO(16, 16, 16, 1),
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromRGBO(16, 16, 16, 1)),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.black),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
      ),
    );
  }
}
