import 'dart:io';
import 'dart:math';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sih2023/provider/employee.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:sih2023/screens/conversation_summary.dart';

import '../utils/colorConstants.dart';

class Conversations extends StatefulWidget {
  const Conversations({Key? key}) : super(key: key);

  @override
  State<Conversations> createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  late final PlayerController playerController;
  String? path;
  late Directory directory;

  void _requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      // Permission is granted, you can proceed with downloading and saving audio
    } else {
      // Permission denied, handle it accordingly
    }
  }

  void _getApplicationDocumentsDirectory(String audioUrl) async {
    try {
      directory = await getApplicationDocumentsDirectory();
      path = "${directory.path}/test_audio.mp3";

      await downloadAudioFile(audioUrl, path!);

      await playerController.preparePlayer(path: path!);
      // if (playerController.playerState == PlayerState.playing) {
      //   await playerController.pausePlayer();
      // } else {
      //   await playerController.startPlayer();
      // }
      setState(() {});
    } catch (error) {
      // Handle any errors that occur during the process
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _requestStoragePermission();

    Provider.of<EmployeeProvider>(context, listen: false).fetchConversations();
    _initialiseController();
    // Download the audio file here
  }

  Future<void> downloadAudioFile(String url, String savePath) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final file = File(savePath);
        await file.writeAsBytes(response.bodyBytes);
        print('Audio file downloaded to: $savePath');
      } else {
        throw Exception(
            'Failed to download audio file. HTTP Status Code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle download error here
      print('Error downloading audio: $error');
      // You can show an error message to the user here if needed
    }
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  void _initialiseController() {
    playerController = PlayerController();
  }

  void _playandPause() async {
    await playerController.startPlayer();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<EmployeeProvider>(context);
    //final Future<List<double>> waveformData = readWaveformData();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: data.isLoading
          ? const Center(
              child: SpinKitCircle(color: ConstantColors.primaryColor),
            )
          : data.conversations.isEmpty
              ? const Center(
                  child: Text(
                    'No Conversations Found!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: ConstantColors.primaryColor,
                      fontFamily: 'medium',
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: data.conversations.length,
                  itemBuilder: (ctx, i) {
                    final conversation = data.conversations[i];

                    // Extract waveform if not already extracted

                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x260081ff),
                            offset: Offset(0, 3),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConversationSummary(
                                                  index: i,
                                                )));
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: ConstantColors.disabledBtn,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12,
                                          color: ConstantColors.primaryColor,
                                          height: 2,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false,
                                        ),
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 5,
                          ),

                          AudioFileWaveforms(
                            size: Size(MediaQuery.of(context).size.width, 50.0),
                            playerController: playerController,
                            enableSeekGesture: true,
                            waveformType: WaveformType.long,
                            waveformData: [],
                            playerWaveStyle: const PlayerWaveStyle(
                              fixedWaveColor: Colors.black,
                              liveWaveColor: Colors.blueAccent,
                              spacing: 6,
                            ),
                          ),

// Example of custom audio player controls
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF002094),
                                  shape:
                                      CircleBorder(), // Use CircleBorder to make it circular
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () async {
                                      _getApplicationDocumentsDirectory(
                                          conversation.streamUrl);
                                      _playandPause();
                                    },
                                    icon: Icon(
                                      Icons.play_arrow,
                                      size: 30, // Adjust the size as needed
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 42,
                                height: 42,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF002094),
                                  shape:
                                      CircleBorder(), // Use CircleBorder to make it circular
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () async {
                                      await playerController.stopPlayer();
                                    },
                                    icon: Icon(
                                      Icons.stop,
                                      size: 30, // Adjust the size as needed
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //
                          //       ElevatedButton(
                          // onPressed: () async{
                          //   _getApplicationDocumentsDirectory(conversation.streamUrl);
                          // },
                          // child: const Text('play'),
                          // ),
                          // ElevatedButton(
                          // onPressed: () async{
                          //   await playerController.pausePlayer();
                          // },
                          // child: const Text('stop'),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
