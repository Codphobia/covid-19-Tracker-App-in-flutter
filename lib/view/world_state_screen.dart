import 'package:covid_19_app/models/world_state_model.dart';
import 'package:covid_19_app/view%20model/state_serivces.dart';

import 'package:covid_19_app/view/counteris_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../view model/state_serivces.dart';
import 'package:pie_chart/pie_chart.dart';

import '../view model/utills/constants.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  // ignore: prefer_typing_uninitialized_variables
  var _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                future: WorldStateServices().getWorldState(),
                builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.deepOrange,
                        size: 67,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total Cases':
                                double.parse(snapshot.data!.cases.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Today Cases': double.parse(
                                snapshot.data!.todayCases.toString()),
                            'Today Deaths': double.parse(
                                snapshot.data!.todayDeaths.toString()),
                            'Today active':
                                double.parse(snapshot.data!.active.toString()),
                          },
                          chartType: ChartType.disc,
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: MyConst.colorList,
                          animationDuration: const Duration(milliseconds: 9000),
                          initialAngleInDegree: 0,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Column(children: [
                            ReusableRow(
                                title: 'Total Cases',
                                value: snapshot.data!.cases.toString()),
                            const Divider(
                              color: Colors.white,
                            ),
                            ReusableRow(
                                title: 'Deaths',
                                value: snapshot.data!.deaths.toString()),
                            ReusableRow(
                                title: 'Recovered',
                                value: snapshot.data!.recovered.toString()),
                            ReusableRow(
                                title: 'Today Deaths',
                                value: snapshot.data!.todayDeaths.toString()),
                            ReusableRow(
                                title: 'Active',
                                value: snapshot.data!.active.toString()),
                          ]),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CounterisList(),
                                ));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 192, 55, 75),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text('Take  Countries List'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}
