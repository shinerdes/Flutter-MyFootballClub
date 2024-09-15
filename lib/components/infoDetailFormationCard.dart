import 'package:flutter/material.dart';
import 'package:my_football_club/theme/app_theme.dart';
import 'package:my_football_club/widget/task_group.dart';

class InfoCleanFormationCard extends StatelessWidget {
  const InfoCleanFormationCard({
    Key? key,
    this.cleanSheet = "cleanSheet",
    this.failedToScore = "forGoals",
    this.bestFormation = "bestFormation",
    this.bestFormationplay = "bestFormationplay",
  }) : super(key: key);

  final String cleanSheet;
  final String failedToScore;
  final String bestFormation;
  final String bestFormationplay;

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
                            Image.asset(
                              'assets/images/goalkeeper-icon.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "$cleanSheet CleanSheet",
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
                            const Icon(
                              Icons.cancel,
                              size: 35,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                "$failedToScore FailedToScore",
                                style: AppTheme.of(context)
                                    .styles
                                    .title!
                                    .copyWith(
                                        fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/formation-icon.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "$bestFormation Formation",
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
                            const Icon(
                              Icons.sports_soccer_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                "$bestFormationplay played",
                                style: AppTheme.of(context)
                                    .styles
                                    .title!
                                    .copyWith(
                                        fontSize: 25, color: Colors.white),
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
