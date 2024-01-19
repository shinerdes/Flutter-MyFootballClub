import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

//import '../data/football_clubs.dart';
//import '../provider/clubProvider.dart';
import 'package:http/http.dart' as http;

import 'package:my_football_club/model/standing_info.dart';

class Standing extends StatefulWidget {
  const Standing({super.key});

  @override
  State<Standing> createState() {
    return _StandingState();
  }
}

class _StandingState extends State<Standing> {
  var headers = {
    'x-rapidapi-key': '1f2c00d514msha8c304bbfb55a67p136162jsn34e7b3d6f432',
    'x-rapidapi-host': 'api-football-v1.p.rapidapi.com/v3/'
  };

  Future<List<StandingInfo>> _getStanding() async {
    await Future.delayed(const Duration(seconds: 1));

    //var id = footballClubList[
    //   Provider.of<PickClub>(context, listen: false).selectIndex]['id']!;

    StandingInfo standingInfo = const StandingInfo(
        rank: 0, logo: '', name: '', played: 0, points: 0, goalsDiff: 0);

    List<StandingInfo> st = [];

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api-football-v1.p.rapidapi.com/v3/standings?league=39&season=2023'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var beforeData = await response.stream.bytesToString();

      var json2 = json.decode(beforeData)["response"][0]["league"]["standings"]
          [0]; // 마지막 부분이 순위

      for (int i = 0; i < 20; i++) {
        standingInfo = StandingInfo(
            rank: json2[i]["rank"],
            logo: json2[i]["team"]["logo"],
            name: json2[i]["team"]["name"],
            played: json2[i]["all"]["played"],
            points: json2[i]["points"],
            goalsDiff: json2[i]["goalsDiff"]);

        st.add(standingInfo);
      }

      return st;
    } else {
      print(response.reasonPhrase);
      return st;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _onBackPressed(context);
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Standing',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  goToWebPage("https://www.premierleague.com/tables");
                },
                icon: const Icon(Icons.bar_chart_outlined))
          ], // pl link
        ),
        body: SafeArea(
          child: Center(
            child: FutureBuilder(
              future: _getStanding(),
              builder: (context, AsyncSnapshot<List<StandingInfo>> snapshot) {
                if (snapshot.hasData == false) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: DataTable(
                        horizontalMargin: 10,
                        columnSpacing: 10,
                        border: TableBorder.symmetric(
                          outside: const BorderSide(width: 3),
                        ),
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                '클럽', // 순위
                                style: TextStyle(fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                '', // 클럽 이미지
                                style: TextStyle(fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                '', // 클럽 이름
                                style: TextStyle(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                '경기', // 경기
                                style: TextStyle(fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                '승점', // 승
                                style: TextStyle(fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                '득실', // 승
                                style: TextStyle(fontStyle: FontStyle.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],

                        // 경기수, 승, 무, 패, 골득실, 승점,/
                        //snapshot.data!.logo.toString()
                        rows: [
                          for (int i = 0; i < snapshot.data!.length; i++)
                            DataRow.byIndex(
                                color: MaterialStateColor.resolveWith((states) {
                                  return _setBackgroundColor(i);
                                }),
                                index: i,
                                cells: <DataCell>[
                                  DataCell(SizedBox(
                                    width: 30,
                                    child: Text(
                                      snapshot.data![i].rank.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                  DataCell(
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.network(
                                        snapshot.data![i].logo.toString(),
                                        width: 45,
                                        height: 45,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                      Text(snapshot.data![i].name.toString())),
                                  DataCell(SizedBox(
                                    width: 30,
                                    child: Text(
                                      snapshot.data![i].played.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                  DataCell(SizedBox(
                                    width: 30,
                                    child: Text(
                                      snapshot.data![i].points.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                  DataCell(SizedBox(
                                    width: 30,
                                    child: Text(
                                      snapshot.data![i].goalsDiff.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                ])
                        ]),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  Navigator.pop(context, false);
  return true;
}

Future<void> goToWebPage(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

_setBackgroundColor(int index) {
  if (index == 0) {
    return const Color.fromRGBO(156, 137, 89, 1);
  } else if (index == 1 || index == 2 || index == 3) {
    return const Color.fromRGBO(17, 59, 240, 1);
  } else if (index == 4 || index == 5) {
    return const Color.fromRGBO(236, 113, 46, 1);
  } else if (index == 6) {
    return const Color.fromRGBO(85, 186, 59, 1);
  } else if (index == 17 || index == 18 || index == 19) {
    return const Color.fromRGBO(240, 0, 95, 1);
  } else {
    return Colors.white;
  }
}
