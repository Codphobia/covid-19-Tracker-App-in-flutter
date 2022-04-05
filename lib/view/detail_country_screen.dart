// ignore_for_file: must_be_immutable, duplicate_ignore

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailCountriesScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailCountriesScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  }) : super(key: key);

  @override
  State<DetailCountriesScreen> createState() => _DetailCountriesScreenState();
}

class _DetailCountriesScreenState extends State<DetailCountriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                    ),
                    ReusableRow(
                      title: 'Total Cases',
                      value: widget.totalCases.toString(),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ReusableRow(
                      title: 'Recovered',
                      value: widget.totalRecovered.toString(),
                    ),
                    ReusableRow(
                      title: 'Total Death',
                      value: widget.totalDeaths.toString(),
                    ),
                    ReusableRow(
                      title: 'Critical',
                      value: widget.critical.toString(),
                    ),
                    ReusableRow(
                      title: 'Today Recovered',
                      value: widget.totalRecovered.toString(),
                    ),
                  ]),
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

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
        bottom: 12,
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
