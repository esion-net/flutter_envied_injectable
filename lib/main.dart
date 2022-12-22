import 'package:flutter/material.dart';
import 'package:flutter_envied_injectable/env/env.dart';
import 'di/injector.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(environment: kDebugMode ? dev : prod);
  print(getIt<Env>().title);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(getIt<Env>().title);
    print(getIt<Env>().notFromEnv);
    print(getIt<Env>().secret);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(getIt<Env>().title),
        ),
        body: Column(children: [
          Center(
            child: Text(getIt<Env>().title),
          ),
          Center(
            child: Text(getIt<Env>().notFromEnv),
          ),
          Center(
            child: Text(getIt<Env>().secret),
          )
        ]),
      ),
    );
  }
}
