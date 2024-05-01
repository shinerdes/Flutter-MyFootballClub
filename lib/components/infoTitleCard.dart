import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_football_club/theme/app_theme.dart';
import 'package:my_football_club/widget/task_group.dart';

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
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 4,
                    offset: const Offset(3, 6),
                  )
                ],
                gradient: AppColors.getDarkLinearGradient2(Colors.deepPurple),
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
                                    .copyWith(
                                        fontSize: 30, color: Colors.white),
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
