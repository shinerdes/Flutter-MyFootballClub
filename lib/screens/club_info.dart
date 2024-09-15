import 'dart:convert';

//import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_football_club/components/infoDetailFormationCard.dart';
import 'package:my_football_club/components/infoFormCard.dart';

import 'package:my_football_club/components/infoPlayedGoalsCard.dart';
import 'package:my_football_club/components/infoTitleCard.dart';
import 'package:my_football_club/model/club_infomation.dart';
//import 'package:my_football_club/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/football_clubs.dart';
import '../provider/clubProvider.dart';
import 'package:http/http.dart' as http;

//import '../widget/task_group.dart';

class ClubInfo extends StatefulWidget {
  const ClubInfo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClubInfo();
  }
}

class _ClubInfo extends State<ClubInfo> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  var headers = {
    'x-rapidapi-key': '1f2c00d514msha8c304bbfb55a67p136162jsn34e7b3d6f432',
    'x-rapidapi-host': 'api-football-v1.p.rapidapi.com/v3/'
  };

  Future<ClubInfomation> _getStanding() async {
    await Future.delayed(const Duration(seconds: 1));
    //var id = jsonData['id']; // 그냥 아이디만 뽑아먹기
    var id = footballClubList[
        // ignore: use_build_context_synchronously
        Provider.of<PickClub>(context, listen: false).selectIndex]['id']!;

    ClubInfomation clubInfomation = const ClubInfomation(
        name: '',
        logo: '',
        league: '',
        recentFive: '',
        played: 0,
        win: 0,
        draw: 0,
        lose: 0,
        goals: 0,
        forGoals: 0,
        againstGoals: 0,
        cleanSheet: 0,
        failedToScore: 0,
        bestFormation: '',
        bestFormationplay: 0);

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api-football-v1.p.rapidapi.com/v3/teams/statistics?league=39&team=$id&season=2023'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var beforeData = await response.stream.bytesToString();

      // var json1 = json.decode(beforeData)["response"];

      // var json2 = json.decode(beforeData)["response"]["league"];

      // var json3 = json.decode(beforeData)["response"]["team"];

      clubInfomation = ClubInfomation(
        name: json.decode(beforeData)["response"]["team"]["name"],
        logo: json.decode(beforeData)["response"]["team"]["logo"],
        league: json.decode(beforeData)["response"]["league"]["logo"],
        recentFive: json.decode(beforeData)["response"]["form"],
        played: json.decode(beforeData)["response"]["fixtures"]["played"]
            ["total"],
        win: json.decode(beforeData)["response"]["fixtures"]["wins"]["total"],
        draw: json.decode(beforeData)["response"]["fixtures"]["draws"]["total"],
        lose: json.decode(beforeData)["response"]["fixtures"]["loses"]["total"],
        goals: json.decode(beforeData)["response"]["goals"]["for"]["total"]
                ["total"] -
            json.decode(beforeData)["response"]["goals"]["against"]["total"]
                ["total"],
        forGoals: json.decode(beforeData)["response"]["goals"]["for"]["total"]
            ["total"],
        againstGoals: json.decode(beforeData)["response"]["goals"]["against"]
            ["total"]["total"],
        cleanSheet: json.decode(beforeData)["response"]["clean_sheet"]["total"],
        failedToScore: json.decode(beforeData)["response"]["failed_to_score"]
            ["total"],
        bestFormation: json.decode(beforeData)["response"]["lineups"][0]
            ["formation"],
        bestFormationplay: json.decode(beforeData)["response"]["lineups"][0]
            ["played"],
      );

      return clubInfomation;
    } else {
      return clubInfomation;
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
            'Team Info',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(footballClubLinkList[
                      Provider.of<PickClub>(context, listen: false)
                          .selectIndex]['detailInfo']!));
                },
                icon: const Icon(Icons.info)),
          ], // pl link
        ),
        body: SafeArea(
          bottom: true,
          child: Center(
            child: FutureBuilder(
              future: _getStanding(),
              builder: (context, AsyncSnapshot<ClubInfomation> snapshot) {
                if (snapshot.hasData == false) {
                  return const CircularProgressIndicator();
                }
                //error가 발생하게 될 경우 반환하게 되는 부분
                else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                }

                // recent fire (icon 처리)
                // 경기수 - 승 - 무 - 패
                // 골득실 - 득점 - 실점
                // 클린시트 - 무득점 경기
                // 베스트 포메이션 - 횟수
                else {
                  return Column(
                    children: [
                      InfoTitleCard(
                        clubImage: snapshot.data!.logo.toString(),
                        clubName: snapshot.data!.name.toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Infoformcard(
                        form: snapshot.data!.recentFive.toString(),
                      ),
                      InfoPlayedGoalsCard(
                        played: snapshot.data!.played.toString(),
                        win: snapshot.data!.win.toString(),
                        draw: snapshot.data!.draw.toString(),
                        lose: snapshot.data!.lose.toString(),
                        goals: snapshot.data!.goals.toString(),
                        forGoals: snapshot.data!.forGoals.toString(),
                        againstGoals: snapshot.data!.againstGoals.toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InfoCleanFormationCard(
                        cleanSheet: snapshot.data!.cleanSheet.toString(),
                        failedToScore: snapshot.data!.failedToScore.toString(),
                        bestFormation: snapshot.data!.bestFormation.toString(),
                        bestFormationplay:
                            snapshot.data!.bestFormationplay.toString(),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    Navigator.pop(context, false);
    return true;
  }
}

// StaggeredGrid.count(
//   crossAxisCount: 2,
//   mainAxisSpacing: 5,
//   crossAxisSpacing: 5,
//   children: [
//     StaggeredGridTile.count(
//       crossAxisCellCount: 1,
//       mainAxisCellCount: 1.8,
//       child: InfoPlayedCard(
//         image: Image.asset(
//           'assets/images/football-icon.png',
//           width: 75,
//           height: 75,
//           fit: BoxFit.cover,
//           color: Colors.white,
//         ),
//         played: snapshot.data!.played.toString(),
//         win: snapshot.data!.win.toString(),
//         draw: snapshot.data!.draw.toString(),
//         lose: snapshot.data!.lose.toString(),
//       ),
//     ),
//     StaggeredGridTile.count(
//       crossAxisCellCount: 1,
//       mainAxisCellCount: 1.8,
//       child: InfoGoalCard(
//         image: Image.asset(
//           'assets/images/football-icon.png',
//           width: 75,
//           height: 75,
//           fit: BoxFit.cover,
//           color: Colors.white,
//         ),
//         goals: snapshot.data!.goals.toString(),
//         forGoals: snapshot.data!.forGoals.toString(),
//         againstGoals:
//             snapshot.data!.againstGoals.toString(),
//       ),
//     ),
//   ],
// ),
// InfoCleanSheetCard(
//   image: Image.asset(
//     'assets/images/goalkeeper-icon.png',
//     width: 75,
//     height: 75,
//     fit: BoxFit.cover,
//     color: Colors.white,
//   ),
//   cleanSheet: snapshot.data!.cleanSheet.toString(),
//   failedToScore: snapshot.data!.failedToScore.toString(),
// ),
// InfoFormationCard(
//   image: Image.asset(
//     'assets/images/formation-icon.png',
//     width: 75,
//     height: 75,
//     fit: BoxFit.cover,
//     color: Colors.white,
//   ),
//   bestFormation: snapshot.data!.bestFormation.toString(),
//   bestFormationplay:
//       snapshot.data!.bestFormationplay.toString(),
// )
