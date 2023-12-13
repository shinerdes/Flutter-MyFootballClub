import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_football_club/model/club_infomation.dart';
import 'package:my_football_club/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/football_clubs.dart';
import '../provider/clubProvider.dart';
import 'package:http/http.dart' as http;

import '../widget/task_group.dart';

class ClubInfo extends StatefulWidget {
  const ClubInfo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClubInfo();
  }
}

class _ClubInfo extends State<ClubInfo> {
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

      var json1 = json.decode(beforeData)["response"];

      var json2 = json.decode(beforeData)["response"]["league"];

      var json3 = json.decode(beforeData)["response"]["team"];

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
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,

          title: const Text('Team Info'),
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
                  return SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/pl-logo.png'),
                        ),
                      ),
                      child: Column(children: [
                        InfoTitleCard(
                          clubImage: snapshot.data!.logo.toString(),
                          clubName: snapshot.data!.name.toString(),
                        ),
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          children: [
                            StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: 1.8,
                              child: InfoPlayedCard(
                                image: Image.asset(
                                  'assets/images/football-icon.png',
                                  width: 75,
                                  height: 75,
                                  fit: BoxFit.cover,
                                  color: Colors.white,
                                ),
                                played: snapshot.data!.played.toString(),
                                win: snapshot.data!.win.toString(),
                                draw: snapshot.data!.draw.toString(),
                                lose: snapshot.data!.lose.toString(),
                              ),
                            ),
                            StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: 1.8,
                              child: InfoGoalCard(
                                image: Image.asset(
                                  'assets/images/football-icon.png',
                                  width: 75,
                                  height: 75,
                                  fit: BoxFit.cover,
                                  color: Colors.white,
                                ),
                                goals: snapshot.data!.goals.toString(),
                                forGoals: snapshot.data!.forGoals.toString(),
                                againstGoals:
                                    snapshot.data!.againstGoals.toString(),
                              ),
                            ),
                          ],
                        ),
                        InfoCleanSheetCard(
                          image: Image.asset(
                            'assets/images/goalkeeper-icon.png',
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                          cleanSheet: snapshot.data!.cleanSheet.toString(),
                          failedToScore:
                              snapshot.data!.failedToScore.toString(),
                        ),
                        InfoFormationCard(
                          image: Image.asset(
                            'assets/images/formation-icon.png',
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                          bestFormation:
                              snapshot.data!.bestFormation.toString(),
                          bestFormationplay:
                              snapshot.data!.bestFormationplay.toString(),
                        )
                      ]),
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

class InfoPlayedCard extends StatelessWidget {
  const InfoPlayedCard({
    Key? key,
    this.played = "played",
    this.win = "win",
    this.draw = "draw",
    this.lose = "lose",
    required this.image,
  }) : super(key: key);

  final Image image;
  final String played;
  final String win;
  final String draw;
  final String lose;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: const Offset(2, 6),
                  )
                ],
                gradient: AppColors.getDarkLinearGradient3(Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [image],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "$played Played",
                              style: AppTheme.of(context).styles.title3,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "$win Win",
                              style: AppTheme.of(context).styles.title3,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "$draw Draw",
                              style: AppTheme.of(context).styles.title3,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "$lose Lose",
                                style: AppTheme.of(context).styles.title3,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class InfoGoalCard extends StatelessWidget {
  const InfoGoalCard({
    Key? key,
    this.goals = "goals",
    this.forGoals = "forGoals",
    this.againstGoals = "againstGoals",
    required this.image,
  }) : super(key: key);

  final Image image;
  final String goals;
  final String forGoals;
  final String againstGoals;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: const Offset(2, 6),
                  )
                ],
                gradient: AppColors.getDarkLinearGradient3(Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [image],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "$goals GD",
                              style: AppTheme.of(context).styles.title3,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "$forGoals Score",
                              style: AppTheme.of(context).styles.title3,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "$againstGoals \nConceded",
                                style: AppTheme.of(context).styles.title3,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class InfoCleanSheetCard extends StatelessWidget {
  const InfoCleanSheetCard({
    Key? key,
    this.cleanSheet = "cleanSheet",
    this.failedToScore = "forGoals",
    required this.image,
  }) : super(key: key);

  final String cleanSheet;
  final String failedToScore;

  final Image image;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: const Offset(2, 6),
                  )
                ],
                gradient: AppColors.getDarkLinearGradient3(Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            image,
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "$cleanSheet CleanSheet",
                              style: AppTheme.of(context).styles.title3,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "$failedToScore FailedToScore",
                                style: AppTheme.of(context).styles.title3,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class InfoFormationCard extends StatelessWidget {
  const InfoFormationCard({
    Key? key,
    this.bestFormation = "bestFormation",
    this.bestFormationplay = "bestFormationplay",
    required this.image,
  }) : super(key: key);

  final String bestFormation;
  final String bestFormationplay;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: const Offset(2, 6),
                  )
                ],
                gradient: AppColors.getDarkLinearGradient3(Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [image],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "$bestFormation Formation",
                              style: AppTheme.of(context).styles.title3,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "$bestFormationplay Play",
                                style: AppTheme.of(context).styles.title3,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class InfoTitleCard extends StatelessWidget {
  const InfoTitleCard({
    Key? key,
    this.clubImage = "clubImage",
    this.clubName = "clubName",
  }) : super(key: key);

  final String clubImage;
  final String clubName;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 4,
                    offset: const Offset(2, 6),
                  )
                ],
                gradient: AppColors.getDarkLinearGradient2(Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              clubImage,
                              width: 90,
                              height: 90,
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: AutoSizeText(
                                clubName
                                    .split('')
                                    .join('\ufeff')
                                    .replaceAll('\ufeff \ufeff', ' '),
                                style: AppTheme.of(context)
                                    .styles
                                    .title!
                                    .copyWith(fontSize: 30),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
