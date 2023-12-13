import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_football_club/model/team_info.dart';
import 'package:my_football_club/screens/club_info.dart';
import 'package:my_football_club/screens/club_init.dart';
import 'package:my_football_club/screens/club_settings.dart';
import 'package:my_football_club/screens/club_squads.dart';
import 'package:my_football_club/screens/standing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_flutter/widgets/icons.dart';

import '../data/football_clubs.dart';
import '../provider/clubProvider.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../theme/app_theme.dart';
import '../widget/task_group.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  late PickClub _selectClub;
  var id;
  var clubname;
  var instagram;
  var twitter;

  var headers = {
    'x-rapidapi-key': '1f2c00d514msha8c304bbfb55a67p136162jsn34e7b3d6f432',
    'x-rapidapi-host': 'api-football-v1.p.rapidapi.com/v3/'
  };

  Future<void> load() async {
    var request = http.Request('GET',
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/teams?id=33'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var beforeData = await response.stream.bytesToString();

      var json1 = json.decode(beforeData)["response"][0]["team"];
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<TeamInfo> _getData() async {
    await Future.delayed(const Duration(seconds: 1));

    Map<String, dynamic> jsonData =
        jsonDecode(Provider.of<PickClub>(context, listen: false).select);

    var id = jsonData['id'];

    TeamInfo teamInfo = const TeamInfo(
        id: 0, name: '', code: '', founded: 0, national: false, logo: '');

    var request = http.Request('GET',
        Uri.parse('https://api-football-v1.p.rapidapi.com/v3/teams?id=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var beforeData = await response.stream.bytesToString();

      var json1 = json.decode(beforeData)["response"][0]["team"];

      teamInfo = TeamInfo(
          id: json1["id"],
          name: json1["name"],
          code: json1["code"],
          founded: json1["founded"],
          national: json1["national"],
          logo: json1["logo"]);

      return teamInfo;
    } else {
      print(response.reasonPhrase);

      return teamInfo;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _callData();
      setState(() {});
    });
  }

  _callData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getInt('index') != null) {
        Provider.of<PickClub>(context, listen: false)
            .pickIndex(prefs.getInt('index')!);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ClubInit()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClubSetting()))
                    .then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(
                Icons.change_circle_outlined,
                color: Colors.black,
              )),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ClubTitleCard(
                  title: footballClubList[
                      Provider.of<PickClub>(context, listen: false)
                          .selectIndex]['clubname']!,
                  image: footballClubList[
                      Provider.of<PickClub>(context, listen: false)
                          .selectIndex]['clubimage']!,
                ),
                const SizedBox(height: 10),
                buildGrid(context),
                const SizedBox(height: 10),
                Column(
                  children: const [
                    MenuCard(
                      iconData: Icons.info_outline_rounded,
                      title: "Team Info",
                    ),
                    MenuCard(
                      iconData: Icons.bar_chart_outlined,
                      title: "Standing",
                    ),
                    MenuCard(
                      iconData: Icons.people_outline_outlined,
                      title: "Team Squads",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

StaggeredGrid buildGrid(BuildContext context) {
  return StaggeredGrid.count(
    crossAxisCount: 2,
    mainAxisSpacing: 15,
    crossAxisSpacing: 15,
    children: [
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1.3,
        child: SocialLinkTaskGroup(
          color: Colors.pink,
          icon: SocialIconsFlutter.instagram,
          taskGroup: "Instagram",
          url: footballClubLinkList[
                  Provider.of<PickClub>(context, listen: false).selectIndex]
              ['instagram']!,
        ),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1.2,
        child: SocialLinkTaskGroup(
          color: Colors.red,
          //isSmall: true,
          icon: SocialIconsFlutter.youtube,
          taskGroup: "Youtube",
          url: footballClubLinkList[
                  Provider.of<PickClub>(context, listen: false).selectIndex]
              ['youtube']!,
        ),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1.3,
        child: SocialLinkTaskGroup(
          color: Colors.lightBlue,
          icon: SocialIconsFlutter.twitter,
          taskGroup: "Twitter",
          url: footballClubLinkList[
                  Provider.of<PickClub>(context, listen: false).selectIndex]
              ['twitter']!,
        ),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 1.2,
        child: SocialLinkTaskGroup(
          color: Colors.indigo,
          //isSmall: true,
          icon: Icons.explore_rounded,
          taskGroup: "Website",
          url: footballClubLinkList[
                  Provider.of<PickClub>(context, listen: false).selectIndex]
              ['homepage']!,
        ),
      ),
    ],
  );
}

class ClubTitleCard extends StatelessWidget {
  const ClubTitleCard({
    Key? key,
    this.title = "Title",
    this.image = "",
  }) : super(key: key);
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                //color: Colors.pink, // added
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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/images/$image.png',
                            width: 100, height: 100, fit: BoxFit.fill),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: AutoSizeText(
                            title
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
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard(
      {Key? key, this.iconData = Icons.abc, this.title = "Title", this.onMore})
      : super(key: key);
  final String title;
  final IconData iconData;
  final Function()? onMore;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        onTap: () async {
          if (title == "Team Info") {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ClubInfo()))
                .then((value) {});
          } else if (title == "Standing") {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Standing()))
                .then((value) {});
          } else if (title == "Team Squads") {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ClubSquads()))
                .then((value) {});
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                //color: Colors.pink, // added
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
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              iconData,
                              size: 60,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            Text(
                              title,
                              style: AppTheme.of(context).styles.title3,
                            )
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
