import 'package:flutter/material.dart';
import 'package:my_football_club/screens/club_init.dart';
import 'package:my_football_club/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:my_football_club/provider/clubProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<PickClub>(create: (_) => PickClub()),
    ],
    child: MaterialApp(
      // darkTheme: ThemeData.dark().copyWith(),
      // theme: ThemeData().copyWith(),
      //themeMode: ThemeMode.system,
      home: const Home(),
      theme: ThemeData(primaryColor: Colors.white),
    ),
  ));
}

_callData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getInt('index') != null) {
    return const Home();
  } else {
    return const ClubInit();
  }
}
