import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helmsman/Frontend/Src/splash_sscr.dart';

/// The main entry point of the application.
///
/// Initializes Flutter bindings and `GetStorage` for local storage,
/// then runs the `MyApp` widget.
///
/// - `WidgetsFlutterBinding.ensureInitialized()`: Prepares the framework.
/// - `GetStorage.init()`: Initializes persistent storage.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScr(),
    );
  }
}

