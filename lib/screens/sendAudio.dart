import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih2023/repo/home_repo.dart';
import 'package:sih2023/utils/url.dart';

uploadFile(File file) async {
  final Uri uploadUri = Uri.parse('${URL.url}/private/send_conversation');
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');


    if (accessToken == null) {
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

Future<void> _requestExternalStoragePermission() async {
  final status = await Permission.storage.request();
  if (status.isGranted) {
    // Permission granted, you can proceed with file selection
  } else {
    print('External storage permission denied');
  }
}

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final _defaultFileNameController = TextEditingController();
  final _dialogTitleController = TextEditingController();
  final _initialDirectoryController = TextEditingController();
  final _fileExtensionController = TextEditingController();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  @override
  void initState() {
    super.initState();
    _requestExternalStoragePermission();
    _fileExtensionController
        .addListener(() => _extension = _fileExtensionController.text);
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      final result = await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        dialogTitle: _dialogTitleController.text,
        initialDirectory: _initialDirectoryController.text,
      );

      if (result != null && result.count != 0) {
        _paths = result.files;
        uploadFile(File(_paths![0].path!));
      }
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = _paths != null ? _paths![0].name : '...';
    });
  }

  void _logException(String message) {
    print(message);
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
    });
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Choose a File',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _pickFiles(),
              child: const Text('Pick a File'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Selected File:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(
              _fileName ?? 'No file selected',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
