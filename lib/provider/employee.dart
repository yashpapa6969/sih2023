import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sih2023/models/employee.dart'; // Import your Employee class
import 'package:sih2023/models/conversation.dart';
import 'dart:convert';

import 'package:sih2023/repo/home_repo.dart';

class EmployeeProvider with ChangeNotifier {
  EmployeeData? _employeeData;

  EmployeeData? get employeeData => _employeeData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final HomeRepository _homeRepo = HomeRepository();
  HomeRepository get homeRepo => _homeRepo;

  List<Conversation> _conversations = [];
  List<bool> isPlayingList = [];

  List<Conversation> get conversations => _conversations;
  List<String> correct_sentiment = [ "Positive", "Negative", "Neutral"];
  String selectedTag = "generic";
  String selectedcorrect_sentiment = "Positive";

  List<String> tags = [
    "generic",
    "hotel_booking",
    "car_rental",
    "event_ticketing",
    "cruise_booking",
    "train_ticketing",
    "bus_reservation",
    "vacation_rentals",
    "tour_booking",
    "reservation",
    "booking",
    "adventure_tours",
    "travel_package",
    "sightseeing_tours",
    "vacation_planning",
    "theme_park_tickets"
  ];
  void updateTag(String value) {
    selectedTag = value;
    notifyListeners();
  }

  void updateSentiment(String value) {
    selectedcorrect_sentiment = value;
    notifyListeners();
  }

  fetchConversations() async {
    try {
      final jsonResponse = await _homeRepo.getAllConversations();
      print(jsonResponse);

      if (jsonResponse != null) {
        final Map<String, dynamic> responseMap = json.decode(jsonResponse);
        print('$responseMap+null?');

        if (responseMap.containsKey('conversations')) {
          final List<Map<String, dynamic>> conversationList =
              List<Map<String, dynamic>>.from(responseMap['conversations']);

          // Map each conversation object inside the list
          _conversations = conversationList
              .map((json) => Conversation.fromJson(json))
              .toList();
          isPlayingList =
              List.generate(_conversations.length, (index) => false);
        } else {
          // Handle the case where 'conversations' key is not present in JSON
          print("'conversations' key is not present in JSON");
        }
      } else {
        // Handle the case where jsonResponse is null
        print("JSON response is null");
      }
    } catch (e) {
      // Handle any exceptions that may occur during the fetch operation
      print("Error fetching conversations: $e");
    }

    notifyListeners();
  }

  fetchData() async {
    _isLoading = true;

    final response = await _homeRepo.getEmployeeDetails();

    final Map<String, dynamic> responseData = json.decode(response);
    _employeeData = EmployeeData.fromJson(responseData['employee']);

    _isLoading = false;
    notifyListeners();
  }



  label(String summary, String sentiment, String tag) async {
    try {
      final response = await _homeRepo.label(summary, sentiment, tag);
      final responseData = json.decode(response);

      print(responseData);

      Fluttertoast.showToast(
        msg: responseData.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );
    } catch (error) {
      print("Error: $error");
      Fluttertoast.showToast(
        msg: "An error occurred",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );
    }

    notifyListeners();
  }


}
