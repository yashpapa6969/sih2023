import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih2023/models/employee.dart';
import 'package:sih2023/provider/employee.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch employee data when the screen is initialized
    Provider.of<EmployeeProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: employeeProvider.employeeData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Overall Score',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: gauges.SfRadialGauge(
                      axes: <gauges.RadialAxis>[
                        gauges.RadialAxis(
                          minimum: -1,
                          maximum:
                              1, // Assuming score is normalized between 0 and 1
                          pointers: <gauges.GaugePointer>[
                            gauges.RangePointer(
                              value: employeeProvider.employeeData!.score
                                  .toDouble(),
                              cornerStyle: gauges.CornerStyle.bothCurve,
                              width: 20,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Conversations',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 300,
                    child: SfCartesianChart(
                      title: ChartTitle(text: 'Sentiment Analysis'),
                      legend: Legend(isVisible: true),
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(),
                      series: <BarSeries<EmployeeData, String>>[
                        BarSeries<EmployeeData, String>(
                          xValueMapper: (EmployeeData data, _) => 'Positive',
                          yValueMapper: (EmployeeData data, _) =>
                          data.numPositiveConversations,
                          name: 'Positive Sentiment',
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          dataSource: [employeeProvider.employeeData!], // Provide the data source here
                        ),
                        BarSeries<EmployeeData, String>(
                          xValueMapper: (EmployeeData data, _) => 'Neutral',
                          yValueMapper: (EmployeeData data, _) =>
                          data.numNeutralConversations,
                          name: 'Neutral Sentiment',
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          dataSource: [employeeProvider.employeeData!], // Provide the data source here
                        ),
                        BarSeries<EmployeeData, String>(
                          xValueMapper: (EmployeeData data, _) => 'Negative',
                          yValueMapper: (EmployeeData data, _) =>
                          data.numNegativeConversations,
                          name: 'Negative Sentiment',
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          dataSource: [employeeProvider.employeeData!], // Provide the data source here
                        ),
                      ],
                    ),
                  ),


                  Container(
                    height: 300,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'No Of Conversation'),
                      series: <ChartSeries>[
                        BarSeries<EmployeeData, String>(
                            dataSource: [employeeProvider.employeeData!],
                            xValueMapper: (EmployeeData data, _) =>
                                'No of Conversation',
                            yValueMapper: (EmployeeData data, _) =>
                                data.numConversations.toDouble(),
                            name: 'Num Conversations',
                            color: Colors.indigo),
                      ],
                    ),
                  )
                ],
              ),
            ),
    )));
  }
}
