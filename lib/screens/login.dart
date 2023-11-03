import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sih2023/provider/employee.dart';
import 'package:sih2023/screens/main_class.dart';

import '../provider/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
  static const routeName = '/login';
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool loading = false;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    var auth = Provider.of<AuthProvider>(context);
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('FandB!'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                fixedSize:
                    MaterialStateProperty.all(const Size.fromHeight(40.0)),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    var employee = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20),
              height: 60,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image(
                          image: Image.asset('assets/icons/goback.png').image,
                          height: 20.0,
                          width: 20.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Let’s Sign you in.",
                style: TextStyle(
                  color: Color(0xff1f1d1d),
                  fontSize: 28,
                  fontFamily: "Playfair Display",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "Welcome back. You’ve been missed!",
                style: TextStyle(
                  color: Color(0xb21f1d1d),
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "Email Address",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff1f1d1d),
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: width,
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                autofocus: true,
                controller: auth.emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                "Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff1f1d1d),
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: width,
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                autofocus: true,
                controller: auth.passwordController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
        Container(
            width: width * 0.75,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0x19000000),
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0x19000000),

                ), onPressed: ()  async {
              if (auth.emailController.text.isEmpty &&
                  auth.passwordController.text.isEmpty) {
                auth.mobileError;
              } else {
                //  employee.fetchData(auth.emailController.text);
                // final employee1 = employee.employeeData[0];

                await auth.login();
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreen()));                    }},
                child: Container(
              width: 71.13,
              child: const Text(
                "Submit",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),),
        ),
            SizedBox(
              height: height / 3,
            ),
          ]),
        ),
      ),
    );
  }
}
