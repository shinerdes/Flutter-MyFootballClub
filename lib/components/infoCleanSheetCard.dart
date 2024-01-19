import 'package:flutter/material.dart';
import 'package:my_football_club/theme/app_theme.dart';
import 'package:my_football_club/widget/task_group.dart';

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
