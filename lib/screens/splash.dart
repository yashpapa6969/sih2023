import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sih2023/utils/auth_check.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        fontFamily: ('FututraBold'),
        primarySwatch: Colors.green,
      ),
      home: const Splash2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash2 extends StatefulWidget {
  const Splash2({Key? key}) : super(key: key);

  @override
  _Splash2 createState() => _Splash2();
}

class _Splash2 extends State<Splash2> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    _timer = Timer(
        const Duration(seconds: 4),
            () => Navigator.of(context, rootNavigator: true).pushReplacement(
            (MaterialPageRoute(
                builder: (BuildContext ctx) => const AuthCheck()))));
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color black = Color(0xFF000000);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                margin: EdgeInsets.only(
                    top: height * 0.10,
                    left: 10,
                    right: 10,
                    bottom: height * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child:   Image(
                              image: Image.asset('assets/logo.png').image,
                              height: height * 0.45,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Text(
                            'SpeakOut',
                            style: TextStyle(
                              color: Color(0xFF002094),
                              fontSize: 40,
                              fontFamily: 'Prosto One',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )),
        ));
  }
}
