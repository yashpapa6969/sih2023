import 'dart:io';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/splash.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',

            home: const SplashScreen()
    );
  }
}
