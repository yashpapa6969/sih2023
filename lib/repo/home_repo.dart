import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih2023/utils/url.dart';

class HomeRepository {
  getEmployeeDetails() async {
    final url = Uri.parse('${URL.url}/private/get_emp_by_email');
    print(url);

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        // Handle the case where the access token is not available, e.g., by redirecting to login.
        throw Exception('Access token not available');
      }
      print(accessToken);

      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$accessToken', // Add the access token to the header
        },
      );

      print(response.body);

      return response.body;
    } catch (error) {
      throw (error);
    }
  }

  getAllConversations() async {
    final url = Uri.parse('${URL.url}/private/get_conv_by_email');
    print(url);

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        // Handle the case where the access token is not available, e.g., by redirecting to login.
        throw Exception('Access token not available');
      }
      print(accessToken);

      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$accessToken', // Add the access token to the header
        },
      );

      print(response.body);

      return response.body;
    } catch (error) {
      throw (error);
    }
  }

  uploadFile(File file) async {
    final Uri uploadUri = Uri.parse('${URL.url}/private/send_conversation');
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        // Handle the case where the access token is not available, e.g., by redirecting to login.
        throw Exception('Access token not available');
      }
      print(accessToken);
      final request = http.MultipartRequest('POST', uploadUri)
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          file.path,
        ))
        ..headers['Authorization'] =
            '$accessToken'; // Replace with your header key and value

      final response = await request.send();
      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('Error uploading file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<String> label(String summary, String sentiment, String tag) async {
    final url = Uri.parse(URL.url + '/private/send_finetune_data');
    print(url);
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        // Handle the case where the access token is not available, e.g., by redirecting to login.
        throw Exception('Access token not available');
      }
      print(accessToken);

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$accessToken', // Add the access token to the header
        },
        body: jsonEncode(<String, dynamic>{
          "conversation_summary": summary,
          "corrected_sentiment": sentiment,
          "tags": [tag]
        }),
      );

      print(url);
      print(response.body);
      return response.body;
    } catch (error) {
      throw (error);
    }
  }
}
