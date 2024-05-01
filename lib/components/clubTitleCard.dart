import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_football_club/theme/app_theme.dart';
import 'package:my_football_club/widget/task_group.dart';

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
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 4,
                    offset: const Offset(3, 6),
                  )
                ],
                gradient: AppColors.getDarkLinearGradient2(Colors.deepPurple),
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
                                .copyWith(fontSize: 30, color: Colors.white),
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
