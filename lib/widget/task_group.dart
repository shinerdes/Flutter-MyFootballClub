import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinkTaskGroup extends StatelessWidget {
  final MaterialColor color;
  final bool? isSmall;
  final IconData icon;
  final String taskGroup;
  final String url;

  const SocialLinkTaskGroup(
      {Key? key,
      required this.color,
      this.isSmall = false,
      required this.icon,
      required this.taskGroup,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color[400],
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 4,
              offset: const Offset(2, 6),
            )
          ],
          gradient: AppColors.getDarkLinearGradient(color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: isSmall! ? Alignment.centerLeft : Alignment.center,
              child: Icon(
                icon,
                size: isSmall! ? 60 : 120,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Text(
              taskGroup,
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class AppColors {
  static bool isDarkMode = false;

  static Color get primaryColor => Colors.pink[400]!;
  static MaterialColor get primarySwatch => Colors.pink;
  static Color get accentColor => isDarkMode ? primaryColor : Colors.grey[600]!;
  static Color get bgColor => isDarkMode ? Colors.black : Colors.grey[50]!;

  static ThemeData get getTheme => ThemeData(
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: bgColor,
          iconTheme: IconThemeData(
            color: Colors.grey[500],
          ),
          elevation: 0,
          foregroundColor: Colors.grey[600],
        ),
        textTheme: TextTheme(
          displayMedium: TextStyle(
            color: Colors.blueGrey[800],
            fontWeight: FontWeight.w800,
            fontSize: 28,
          ),
          displaySmall: TextStyle(
            color: Colors.blueGrey[800],
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          labelMedium: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        scaffoldBackgroundColor: bgColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        ),
      );

  static LinearGradient getLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        color[300]!,
        color[200]!,
        color[100]!,
      ],
      stops: const [
        0.4,
        0.7,
        0.9,
      ],
    );
  }

  static LinearGradient getDarkLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        color[400]!,
        color[300]!,
        color[200]!,
      ],
      stops: const [
        0.4,
        0.6,
        1,
      ],
    );
  }

  static LinearGradient getDarkLinearGradient2(Color getColor) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        getColor.withOpacity(0.9),
        getColor.withOpacity(0.6),
        getColor.withOpacity(0.3),
      ],
      stops: const [
        0.4,
        0.6,
        1,
      ],
    );
  }

  static LinearGradient getDarkLinearGradient3(Color getColor) {
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        getColor.withOpacity(0.9),
        getColor.withOpacity(0.6),
        getColor.withOpacity(0.3),
      ],
      stops: const [
        0.3,
        0.6,
        1,
      ],
    );
  }

  static LinearGradient getDarkLinearGradient4(Color getColor) {
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        getColor.withOpacity(0.9),
        getColor.withOpacity(0.6),
        Colors.white,
      ],
      stops: const [
        0.3,
        0.6,
        1,
      ],
    );
  }
}
