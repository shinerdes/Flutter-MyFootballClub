import 'package:flutter/material.dart';
import 'package:my_football_club/screens/club_info.dart';
import 'package:my_football_club/screens/club_squads.dart';
import 'package:my_football_club/screens/standing.dart';
import 'package:my_football_club/theme/app_theme.dart';
import 'package:my_football_club/widget/task_group.dart';

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
                    color: const Color.fromARGB(255, 1, 1, 1).withOpacity(0.5),
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
