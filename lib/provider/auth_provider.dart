import 'dart:convert';
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih2023/repo/home_repo.dart';
import 'package:sih2023/utils/shared_preference.dart';
import 'package:sih2023/utils/url.dart';
final HomeRepository _homeRepo = HomeRepository();
HomeRepository get homeRepo => _homeRepo;


class AuthProvider with ChangeNotifier {
  String token = '';
  String _id = '';
  String student_id = '';
  String institute_id = '';
  String course = '';


  String type = '';
  String phone = '';
  String email = '';
  String langId = '';
  String catId = '';
  String message = '';
  String name = '';
  String otp = '';
  String studentName = '';
  String selected_country_code = '+91';
  String image = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String verificationid = '';



 // final HomeRepository _homeRepo = HomeRepository();
  //   HomeRepository get homeRepo => _homeRepo;
  int status = 0;
  bool mobileError = false;
  bool loading = false;
  bool otpError = false;
  bool nameError = false;


  AuthProvider(this._access_token);




  String _access_token;

  String get access_token => _access_token;






  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  final SharedPrefrence _saveData = SharedPrefrence();

  SharedPrefrence get saveData => _saveData;



  String get _token {
    if (token.isNotEmpty) {
      return token;
    }
    return '';
  }


  String get userId {
    return _id;
  }
  void updatePhone(String value)
{
  phone = value;
}
  void updatevid(String value)
  {
    verificationid = value;
  }
  void updateLoginStatus(int value, BuildContext context) {
    if (value == 0) {
      // Navigator.popAndPushNamed(
      //   context,
      //   Login.routeName,
      // );
    } else {
      // Navigator.popAndPushNamed(
      //   context,
      //   Otp.routeName,
      // );
    }

    // notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final saveData = await SharedPreferences.getInstance();
    if (!saveData.containsKey('access_token')) {
      return false;
    }
    _access_token = saveData.getString("access_token")!;

    return true;
  }



  Future<String> login() async {
    final url = Uri.parse(URL.url + '/public/employee/login');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "employee_email": emailController.text,
          "password": passwordController.text
        }),
      );

      print(url);
      print(response.body);

      // Check if the response contains an access token
      final jsonResponse = json.decode(response.body);
      final accessToken = jsonResponse['access_token'];

      if (accessToken != null) {
        // Save the access token to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);

      }

      return response.body;
    } catch (error) {
      throw (error);
    }
  }

  //
  // Fluttertoast.showToast(
  // msg: responseBody,
  // toastLength: Toast.LENGTH_SHORT,
  // gravity: ToastGravity.CENTER,
  // timeInSecForIosWeb: 1,
  // backgroundColor: Colors.red,
  // textColor: Colors.black,
  // fontSize: 16.0
  //


  // Future<void> retrieveDataFromSharedPreferences() async {
  //   // Retrieve the value of 'course_id' from SharedPreferences
  //   final prefs = await SharedPreferences.getInstance();
  //   _public_key = prefs.getString('public_key')!;
  //   _private_key = prefs.getString('private_key')!;
  //
  //   // Notify listeners that the value(s) have changed
  //   notifyListeners();
  // }





  String gender = "Select Gender";

  final TextEditingController _nameController = TextEditingController();


  TextEditingController get nameController => _nameController;

  final TextEditingController _stateController = TextEditingController();
  TextEditingController get stateController => _stateController;

  final TextEditingController _cityController = TextEditingController();
  TextEditingController get cityController => _cityController;


  final TextEditingController _occupationController = TextEditingController();
  TextEditingController get occupationController => _occupationController;

  final TextEditingController _incomeController = TextEditingController();
  TextEditingController get incomeController => _incomeController;

  final TextEditingController _educationController = TextEditingController();
  TextEditingController get educationController => _educationController;

  final TextEditingController _adadharController = TextEditingController();
  TextEditingController get adadharController => _adadharController;

  final TextEditingController _panController = TextEditingController();
  TextEditingController get panController => _panController;

  final TextEditingController _claimController = TextEditingController();
  TextEditingController get claimController => _claimController;



  String profileImage = '';
  String user = 'Teacher';
  String city_id = "0";
  bool emailError = false;
  bool cityNameError = false;
  bool passwordError = false;


  // getCity() async {
  //      _CityItems = [];
  //      _CityItems.add(cityModel(id: "0", name: "Select City"));
  //      await _homeRepo.fetchAndSetCity().then((response) {
  //        final responseData = json.decode(response);
  //        responseData['cities'].forEach((prodData) {
  //          _CityItems.add(cityModel(id: prodData['city_id'], name: prodData['name']));
  //        });
  //      });
  //
  //      notifyListeners();
  //    }


  }



// Modal class









