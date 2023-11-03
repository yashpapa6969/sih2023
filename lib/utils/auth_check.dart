
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:sih2023/provider/auth_provider.dart';
import 'package:sih2023/provider/employee.dart';
import 'package:sih2023/screens/main_class.dart';
import 'package:sih2023/screens/slider.dart';
import 'package:sih2023/screens/splash.dart';



class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return MultiProvider(
        providers: [

          ChangeNotifierProvider.value(
            value: AuthProvider(''),
          ),

          ChangeNotifierProxyProvider<AuthProvider, EmployeeProvider>(
            create: (ctx) => EmployeeProvider(),
            update: (ctx, auth, _) => EmployeeProvider(),
          ),

        ],
        child: Consumer<AuthProvider>(
            builder: (ctx, auth, _) =>
                MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'MyShop',
                  theme: ThemeData(
                    brightness: Brightness.light,
                    fontFamily: 'medium',
                  ),
                  home: FutureBuilder(
                    future: auth.tryAutoLogin(), // Await the result here
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SplashScreen();
                      } else {
                        if (snapshot.data == true) {
                          return const MainScreen();
                        } else {
                          return slider();
                        }
                      }
                    },
                  ),

                )
        )
    );
  }}