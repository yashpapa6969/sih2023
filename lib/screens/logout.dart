
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert'; // Import for JSON decoding
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih2023/screens/about_first.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {

              _showLogoutAlert(context);

            },
            child: const Text(
              "Logout",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xfff6e80b),
                fontSize: 12,
                fontFamily: "Lato",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ));
  }
}

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