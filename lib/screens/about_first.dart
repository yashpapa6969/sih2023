import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sih2023/screens/login.dart';
import 'package:sih2023/screens/main_class.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);
  static const routeName = '/about';

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    const Color black = Color(0xFF000000);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: height * 0.05,
                  left: 20,
                  right: 20,
                  bottom: height * 0.1),
              child: Column(
                children: [
                  Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Center(
                        child: Container(
                          child: Image(
                            image: Image.asset('assets/logo.png').image,
                            height: height / 2,
                            width: width,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )),
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
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            child: const Text(
                              "Sign In",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff1f1d1d),
                                fontSize: 16,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//void openPDF(BuildContext context, File file,String url) {
//   Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFViewerPage(file: file,url: url,)));
// }
