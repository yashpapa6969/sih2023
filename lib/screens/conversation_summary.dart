import 'dart:io';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sih2023/provider/employee.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import '../utils/colorConstants.dart';

class ConversationSummary extends StatefulWidget {
  final int index;

  ConversationSummary({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<ConversationSummary> createState() => _ConversationSummaryState();
}

class _ConversationSummaryState extends State<ConversationSummary> {
  @override
  void initState() {
    super.initState();

    Provider.of<EmployeeProvider>(context, listen: false).fetchConversations();
    // Download the audio file here
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<EmployeeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Conversation Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10, left: 5),
                    height: 40,
                    width: width * 0.50,
                    decoration: BoxDecoration(
                      color: Color(0x260081ff),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromRGBO(31, 29, 29, 1),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        alignment: Alignment.center,

                        //   borderRadius: BorderRadius.circular(12),
                        //   color: ConstantColors.mainColor,
                        // ),
                        buttonHeight: 20,
                        buttonWidth: 60,
                        itemHeight: 35,

                        dropdownMaxHeight: height * 0.40,
                        value: data.selectedTag,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: ConstantColors.disabledBtn,
                        ),
                        onChanged: (newValue) {
                          data.updateTag(newValue!);
                        },
                        items: data.tags.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(value,
                                    style: const TextStyle(
                                      fontFamily: "Lato",
                                      color: Colors.black,
                                      fontSize: 14,
                                    ))
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 10, left: 5),
                    height: 40,
                    width: width * 0.35,
                    decoration: BoxDecoration(
                      color: Color(0x260081ff),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromRGBO(31, 29, 29, 1),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        alignment: Alignment.center,

                        //   borderRadius: BorderRadius.circular(12),
                        //   color: ConstantColors.mainColor,
                        // ),
                        buttonHeight: 20,
                        buttonWidth: 60,
                        itemHeight: 35,

                        dropdownMaxHeight: height * 0.30,
                        value: data.selectedcorrect_sentiment,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        onChanged: (newValue) {
                          data.updateSentiment(newValue!);
                        },
                        items: data.correct_sentiment.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(value,
                                    style: const TextStyle(
                                      fontFamily: "Lato",
                                      color: ConstantColors.primaryColor,
                                      fontSize: 14,
                                    ))
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              const Text(
                'Summary of the Conversation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(10),
                width: width,
                height: height / 3,
                decoration: BoxDecoration(
                  color: const Color(
                      0xFFDCEBFF), // Adjusted color to make it darker
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(
                        0xFFDCEBFF), // Adjusted color to make it darker
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    data.conversations[widget.index].inference.summary,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                new CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: data.conversations[widget.index].inference.score,
                  center: new Text(
                    data.conversations[widget.index].inference.score
                        .toStringAsPrecision(1),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: const Text(
                    "Score",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: width / 3,
                  height: height / 5,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(
                        0xFFDCEBFF), // Adjusted color to make it darker
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFEBEBEB)),
                      borderRadius:
                          BorderRadius.circular(5), // Adding border radius
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the text vertically
                    children: [
                      Container(
                        width: 60,
                        child: data.conversations[widget.index].inference
                                    .sentiment ==
                                "Positive"
                            ? Lottie.network(
                                "https://fonts.gstatic.com/s/e/notoemoji/latest/1f603/lottie.json")
                            : data.conversations[widget.index].inference
                                        .sentiment ==
                                    "Neutral"
                                ? Lottie.network(
                                    "https://fonts.gstatic.com/s/e/notoemoji/latest/1f611/lottie.json")
                                : Lottie.network(
                                    "https://fonts.gstatic.com/s/e/notoemoji/latest/1f624/lottie.json"),
                      ), // Change the URL for the negative sentiment

                      const Text(
                        'Overall Score',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        data.conversations[widget.index].inference.score
                            .toStringAsPrecision(1),
                        style: const TextStyle(
                          color: Color(0xFF163172),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        data.conversations[widget.index].inference.sentiment,
                        style: const TextStyle(
                          color: Color(0xFF928686),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Container(
                width: width * 90,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0x19000000),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    data.label(
                        data.conversations[widget.index].inference.summary,
                        data.selectedcorrect_sentiment,
                        data.selectedTag);
                  },
                  child: Container(
                    width: 71.13,
                    child: const Text(
                      "Submit Label",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
