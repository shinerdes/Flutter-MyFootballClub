import 'package:flutter/material.dart';
import 'package:my_football_club/theme/app_theme.dart';
import 'package:my_football_club/widget/task_group.dart';

class InfoPlayedGoalsCard extends StatelessWidget {
  const InfoPlayedGoalsCard({
    Key? key,
    this.played = "played",
    this.win = "win",
    this.draw = "draw",
    this.lose = "lose",
    this.goals = "goals",
    this.forGoals = "forGoals",
    this.againstGoals = "againstGoals",
  }) : super(key: key);

  final String played;
  final String win;
  final String draw;
  final String lose;
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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 20,
                    spreadRadius: 4,
                    offset: const Offset(3, 6),
                  )
                ],
                gradient: AppColors.getDarkLinearGradient3(Colors.deepPurple),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.flag_circle_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                            Text(
                              "$played Played",
                              style: AppTheme.of(context)
                                  .styles
                                  .title!
                                  .copyWith(fontSize: 25, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$win Win ",
                              style: AppTheme.of(context)
                                  .styles
                                  .title!
                                  .copyWith(fontSize: 25, color: Colors.white),
                            ),
                            const Text("  /  "),
                            Text(
                              "$draw Draw ",
                              style: AppTheme.of(context)
                                  .styles
                                  .title!
                                  .copyWith(fontSize: 25, color: Colors.white),
                            ),
                            const Text("  /  "),
                            Flexible(
                              child: Text(
                                "$lose Lose ",
                                style: AppTheme.of(context)
                                    .styles
                                    .title!
                                    .copyWith(
                                        fontSize: 25, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.sports_soccer_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                            Text(
                              "$goals Goal Difference",
                              style: AppTheme.of(context)
                                  .styles
                                  .title!
                                  .copyWith(fontSize: 25, color: Colors.white),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$forGoals Score",
                              style: AppTheme.of(context)
                                  .styles
                                  .title!
                                  .copyWith(fontSize: 25, color: Colors.white),
                            ),
                            const Text("  /  "),
                            Flexible(
                              child: Text(
                                "$againstGoals Conceded",
                                style: AppTheme.of(context)
                                    .styles
                                    .title!
                                    .copyWith(
                                        fontSize: 25, color: Colors.white),
                              ),
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
