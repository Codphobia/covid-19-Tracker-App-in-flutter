import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../view model/state_serivces.dart';
import 'detail_country_screen.dart';

class CounterisList extends StatefulWidget {
  const CounterisList({Key? key}) : super(key: key);

  @override
  State<CounterisList> createState() => _CounterisListState();
}

class _CounterisListState extends State<CounterisList> {
  TextEditingController searchEditingCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchEditingCont,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: WorldStateServices().getData(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    // this is a shimmer listviewbuilder part
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        // var counterisData = snapshot.data![index];
                        return Shimmer.fromColors(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    width: 90,
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    width: 89,
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100);
                      },
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];

                        if (searchEditingCont.text.isEmpty) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                    width: 50,
                                    height: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailCountriesScreen(
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            name: snapshot.data![index]
                                                ['country'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            totalRecovered: snapshot.data![index]
                                                ['recovered'],
                                            totalDeaths: snapshot.data![index]
                                                ['deaths'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            critical: snapshot.data![index]
                                                ['critical']),
                                      ));
                                },
                              ),
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchEditingCont.text.toLowerCase())) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  width: 50,
                                  height: 50,
                                  image: NetworkImage(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailCountriesScreen(
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            name: snapshot.data![index]
                                                ['country'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            totalRecovered: snapshot.data![index]
                                                ['recovered'],
                                            totalDeaths: snapshot.data![index]
                                                ['deaths'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            critical: snapshot.data![index]
                                                ['critical']),
                                      ));
                                },
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
