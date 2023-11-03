
import 'package:elastic_drawer/elastic_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidden_drawer_menu/controllers/animated_drawer_controller.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';

import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih2023/screens/about_first.dart';
import 'package:sih2023/screens/conversations.dart';
import 'package:sih2023/screens/homescreen.dart';
import 'package:sih2023/screens/logout.dart';
import 'package:sih2023/screens/sendAudio.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  late ScrollController _scrollController;
  late final PageController _c = PageController(
    initialPage: 0,
  );

  double offset = 0.0;
  static final _isInit = true;
  static final _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  int _selectedIndex = 0;
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();


  }

  void _onItemTapped(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_c.hasClients) {
        _c.animateToPage(index,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut);

        setState(() {
          _selectedIndex = index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    List<String> headers = ["Home","Buy Policy","Your Policies"];

    List<Widget> _widgetOptions = <Widget>[
      EmployeeListScreen(),
      FilePickerDemo(),
      Conversations(),
    ];



          return Scaffold(


            key: _scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  _showLogoutAlert(context);
                 // controller.toggle();
                },
              ),
            ),


            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: PageView.builder(
                    itemCount: _widgetOptions.length,
                    controller: _c,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Center(child: _widgetOptions.elementAt(index));
                    }),
              ),
            ),
            bottomNavigationBar: Container(
              height: 70,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Theme(data: Theme.of(context).copyWith(
                  canvasColor: Color.fromRGBO(0, 13, 48, 1),
                ),

                  child: BottomNavigationBar(
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6.0,
                          children: [
                            _selectedIndex == 0
                                ? Column(
                              children: [
                                ImageIcon(
                                  Image
                                      .asset('assets/icons/home_active.png')
                                      .image,
                                  size: 24.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.only(top: 5),
                                  height: 2,
                                  width: 12.0,
                                ),
                              ],
                            )
                                : ImageIcon(
                              Image
                                  .asset('assets/icons/home_inactive.png')
                                  .image,
                              size: 24.0,
                            ),
                            _selectedIndex == 0
                                ? const Text(
                              '',
                              style: TextStyle(fontSize: 14.0),
                            )
                                : const Text(''),
                          ],
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6.0,
                          children: [
                            _selectedIndex == 1
                                ? Column(
                              children: [
                                ImageIcon(
                                  Image
                                      .asset('assets/policy.png')
                                      .image,
                                  size: 24.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  margin: const EdgeInsets.only(top: 5),
                                  height: 2,
                                  width: 12.0,
                                ),
                              ],
                            )
                            //background: rgba(246, 220, 220, 1);
                                : ImageIcon(
                              Image
                                  .asset('assets/policy.png')
                                  .image,
                              size: 24.0,
                            ),
                          ],
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6.0,
                          children: [
                            _selectedIndex == 2
                                ? Column(
                              children: [
                                ImageIcon(
                                  Image
                                      .asset('assets/claim.png')
                                      .image,
                                  size: 24.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.only(top: 5),
                                  height: 2,
                                  width: 12.0,
                                ),
                              ],
                            )
                                : ImageIcon(
                              Image
                                  .asset('assets/claim.png')
                                  .image,
                              size: 24.0,
                            ),
                            _selectedIndex == 2
                                ? const Text(
                              '',
                              style: TextStyle(fontSize: 14.0),
                            )
                                : const Text(''),
                          ],
                        ),
                        label: "",
                      ),


                    ],
                    currentIndex: _selectedIndex,
                    showUnselectedLabels: false,
                    selectedLabelStyle: const TextStyle(fontSize: 0.0),
                    unselectedLabelStyle: const TextStyle(fontSize: 0.0),
                    unselectedIconTheme:
                    const IconThemeData(color: Colors.white, size: 20.0),
                    selectedIconTheme: const IconThemeData(color: Colors.white),
                    onTap: _onItemTapped,
                    backgroundColor: Color.fromRGBO(0, 13, 48, 1),
                    // backgroundColor: Colors.black,
                    fixedColor: Color.fromRGBO(0, 13, 48, 1),
                  ),
                ),
              ),
            ),

          );
        }
  }

//
// class Menu extends StatefulWidget {
//   @override
//   _MenuState createState() => _MenuState();
// }
//
// class _MenuState extends State<Menu> with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late SimpleHiddenDrawerController _controller;
//
//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     _controller = SimpleHiddenDrawerController.of(context);
//     _controller.addListener(() {
//       if (_controller.state == MenuState.open) {
//         _animationController.forward();
//       }
//
//       if (_controller.state == MenuState.closing) {
//         _animationController.reverse();
//       }
//     });
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       height: double.maxFinite,
//       color: Colors.cyan,
//       child: Stack(
//         children: <Widget>[
//           Container(
//             width: double.maxFinite,
//             height: double.maxFinite,
//             child: Image.network(
//               'https://wallpaperaccess.com/full/529044.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//           FadeTransition(
//             opacity: _animationController,
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(
//                       width: 200.0,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                           MaterialStateProperty.all(Colors.blue),
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(
//                                   20.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           _controller.setSelectedMenuPosition(0);
//                         },
//                         child: Text(
//                           "Menu 1",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 200.0,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                           MaterialStateProperty.all(Colors.orange),
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(
//                                   20.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           _controller.setSelectedMenuPosition(1);
//
//                         },
//                         child: Text(
//                           "Logout",
//                           style: TextStyle(color: Colors.white),
//
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





void _showLogoutAlert(BuildContext context) {
  var alertStyle = AlertStyle(
    animationType: AnimationType.fromBottom,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle: const TextStyle(fontFamily: "regular", fontSize: 14),
    descTextAlign: TextAlign.start,
    animationDuration: const Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: const BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: const TextStyle(
        color: Colors.black, fontFamily: "medium", fontSize: 16),
    alertAlignment: Alignment.center,
  );
  Future.delayed(const Duration(milliseconds: 300), () {
    Alert(
      context: context,
      style: alertStyle,
      title: "SpeakOut!!",
      desc: "Are you sure ?",
      buttons: [
        DialogButton(
          border: const Border.fromBorderSide(
              BorderSide(color: Colors.black, width: 1)),
          color: Colors.transparent,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          width: 120,
          child: const Text(
            "Cancel",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: "lato"),
          ),
        ),
        DialogButton(
          color: Colors.transparent,
          border: const Border.fromBorderSide(
              BorderSide(color: Colors.red, width: 1)),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();

            // final profile = Provider.of<UserProvider>(context);
            //  profile.profileStatus(false);

            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.clear().then((value) {
              if (value) {
                Future.delayed(const Duration(milliseconds: 800), () {
                  Navigator.of(context).pushAndRemoveUntil(
                    // the new route
                    MaterialPageRoute(
                      builder: (BuildContext context) =>  About(),
                    ),

                    // this function should return true when we're done removing routes
                    // but because we want to remove all other screens, we make it
                    // always return false
                        (Route route) => false,
                  );
                });
              }
            });
          },
          width: 120,
          child: const Text(
            "LOGOUT",
            style: TextStyle(
                color: Colors.red, fontSize: 16, fontFamily: "medium"),
          ),
        )
      ],
    ).show();
  });
}
