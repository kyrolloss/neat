import 'package:flutter/material.dart';
import 'package:neat/Models/task%20Model.dart';
import 'package:neat/components/Text.dart';
import 'package:neat/components/color.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;

class PerformanceScreen extends StatefulWidget {
  final double toDoTask;
  final double completeTask;
  final List<Tasks> tasksList;

  const PerformanceScreen(
      {super.key,
      required this.toDoTask,
      required this.completeTask,
      required this.tasksList});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  LegendPosition? _legendPosition = LegendPosition.bottom;
  int taskNum=0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final dataMap = <String, double>{
      "Completed after Deadline": widget.toDoTask,
      "Completed before Deadline": widget.completeTask,
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 65),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.primeColor,
                      size: 35,
                    ),
                  ),
                  BuildText(
                    text: 'Performance',
                    size: 35,
                    bold: true,
                    letterSpacing: 1.5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Container(
                height: height * .45,
                width: width * .9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(17.50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildText(
                        text: 'Delivery Of Tasks',
                        size: 17.5,
                        bold: true,
                      ),
                      PieChart(
                        dataMap: dataMap,
                        ringStrokeWidth: 50,
                        colorList: [AppColor.secondColor, AppColor.primeColor],
                        formatChartValues: (value) {
                          return value.toStringAsFixed(0);
                        },
                        chartRadius: 250,
                        chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                            chartValueStyle: TextStyle(
                              color: AppColor.primeColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                        legendOptions: LegendOptions(
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              color: AppColor.primeColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            legendShape: BoxShape.rectangle,
                            legendPosition: _legendPosition!,
                            showLegendsInRow: true),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 15
              ),
              child: Container(
                  height: height * .45,
                  width: width * .9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: widget.tasksList.length,
                      itemBuilder: (BuildContext context, int index) {

                        return Container(
                          height: height*.15,
                          width: width*.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildText(
                                  text: '#${index+1} ${widget.tasksList[index].name}',
                                  size: 15,
                                  bold: true,
                                ),
                                BuildText(
                                  text: 'deadline : ${widget.tasksList[index].year}-${widget.tasksList[index].month}-${widget.tasksList[index].day}',
                                  size: 15,
                                  bold: true,
                                  color: Colors.grey,
                                ),
                                BuildText(
                                  text: 'Time Of Delivery : ${widget.tasksList[index].yearCompleted}-${widget.tasksList[index].monthCompleted}-${widget.tasksList[index].dayCompleted}',
                                  size: 15,
                                  bold: true,
                                  color: Colors.grey,

                                ),
                                Row(
                                  children: [
                                    BuildText(
                                      text: 'status : ',
                                      size: 15,
                                      bold: true,
                                      color: Colors.grey,

                                    ),
                                    SizedBox(
                                      width: width*.01,
                                    ),
                                    Icon(Icons.circle,color: (widget.tasksList[index].year>=widget.tasksList[index].yearCompleted!&&widget.tasksList[index].month>=widget.tasksList[index].monthCompleted!) || (widget.tasksList[index].month==widget.tasksList[index].monthCompleted! && widget.tasksList[index].day>=widget.tasksList[index].dayCompleted!)?Colors.green:Colors.red,)
                                  ],
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
