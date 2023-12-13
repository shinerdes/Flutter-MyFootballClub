import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_football_club/data/football_clubs.dart';
import 'package:my_football_club/model/club_squads_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../provider/clubProvider.dart';
import '../widget/task_group.dart';

class ClubSquads extends StatefulWidget {
  const ClubSquads({super.key});

  @override
  State<ClubSquads> createState() {
    return _ClubSquads();
  }
}

class _ClubSquads extends State<ClubSquads> {
  var playersCount = 0;

  var headers = {
    'x-rapidapi-key': '1f2c00d514msha8c304bbfb55a67p136162jsn34e7b3d6f432',
    'x-rapidapi-host': 'api-football-v1.p.rapidapi.com/v3/'
  };

  Future<List<ClubSQ>> _getSquads() async {
    await Future.delayed(const Duration(seconds: 1));

    var id = footballClubList[
        Provider.of<PickClub>(context, listen: false).selectIndex]['id']!;

    ClubSQ clubSQ =
        const ClubSQ(name: "", age: 0, number: 0, position: "", photo: "");

    List<ClubSQ> st = [];

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api-football-v1.p.rapidapi.com/v3/players/squads?team=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      var beforeData = await response.stream.bytesToString();
      var json1 = json.decode(beforeData)["response"];
      var json2 = json.decode(beforeData)["response"][0]["players"];

      playersCount =
          (json.decode(beforeData)["response"][0]["players"] as List<dynamic>)
              .length;
      for (int i = 0; i < playersCount; i++) {
        clubSQ = ClubSQ(
            name: json2[i]["name"],
            age: json2[i]["age"],
            number: json2[i]["number"] ?? 0,
            position: json2[i]["position"],
            photo: json2[i]["photo"] ?? "");

        st.add(clubSQ);
      }
      return st;
    } else {
      return st;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Team Squads'),
          actions: [
            IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(footballClubLinkList[
                      Provider.of<PickClub>(context, listen: false)
                          .selectIndex]['detailSquads']!));
                },
                icon: const Icon(Icons.people_outline_outlined))
          ], // pl link
        ),
        body: SafeArea(
          bottom: true,
          child: Center(
            child: FutureBuilder(
              future: _getSquads(),
              builder: (context, AsyncSnapshot<List<ClubSQ>> snapshot) {
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
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 6,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: playersCount,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            side: const BorderSide(width: 3.0)),
                        margin: const EdgeInsets.all(8),
                        //elevation: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: const Offset(2, 6),
                              )
                            ],
                            gradient: AppColors.getDarkLinearGradient4(
                                _squadsBackgroundColor(
                                    snapshot.data![index].position)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GridTile(
                            header: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, top: 8.0),
                              child: Text(
                                "No.${snapshot.data![index].number.toString()}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 20,
                                  decorationColor: Colors.red,
                                ),
                              ),
                            ), // 번호 + 포지션 // 넘버
                            footer: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                snapshot.data![index].name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  decorationColor: Colors.red,
                                ),
                              ),
                            ), // 번호 + 포지션

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                snapshot.data![index].photo,
                                alignment: Alignment.center,
                              ),
                            ),
                          ), // 선수 사진
                        ),
                      ),
                    ),
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

_squadsBackgroundColor(String position) {
  switch (position) {
    case "Goalkeeper":
      return const Color.fromRGBO(237, 177, 70, 1);
    case "Defender":
      return const Color.fromRGBO(34, 100, 234, 1);
    case "Midfielder":
      return const Color.fromRGBO(28, 204, 121, 1);
    case "Attacker":
      return const Color.fromRGBO(240, 39, 77, 1);
    default:
      return const Color.fromRGBO(255, 255, 255, 0);
  }
}
