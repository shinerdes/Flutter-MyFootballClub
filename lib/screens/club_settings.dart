import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_football_club/provider/clubProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/football_clubs.dart';
import '../theme/app_theme.dart';

class ClubSetting extends StatefulWidget {
  const ClubSetting({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClubSetting();
  }
}

class _ClubSetting extends State<ClubSetting> {
  int selectedCard = 0;

  late PickClub _selectIndex;

  static void setIndex(int input) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('index', input);
  }

  @override
  Widget build(BuildContext context) {
    _selectIndex = Provider.of<PickClub>(context, listen: false);

    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) {
        if (didPop) {

          return;
        }
        _onBackPressed(context);
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Pick Your Club", style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            bottom: true,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 6,
                childAspectRatio: 3 / 4,
              ),
              itemCount: footballClubList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectIndex.pickIndex(index);

                    selectedCard = index;

                    setIndex(index);
                  });
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        side: const BorderSide(width: 3.0)),
                    margin: const EdgeInsets.all(8),
                    //elevation: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: Provider.of<PickClub>(context).selectIndex ==
                                  index
                              ? [
                                  Colors.black.withOpacity(0.8),
                                  Colors.deepPurple.withOpacity(1),
                                ]
                              : [
                                  Colors.white.withOpacity(0.5),
                                  Colors.deepPurple.withOpacity(0.7),
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(children: [
                        const SizedBox(height: 20),
                        Image.asset(
                            'assets/images/${footballClubList[index]['clubimage']}.png',
                            width: 125,
                            height: 125,
                            fit: BoxFit.fill),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Container(
                            //color: Colors.lightGreenAccent,
                            alignment: Alignment.center,
                            child: Text(
                              footballClubList[index]['clubname']!,
                              textAlign: TextAlign.center,
                              style: AppTheme.of(context)
                                  .styles
                                  .title!
                                  .copyWith(fontSize: 23, color: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                    )),
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    Navigator.pop(context, false);
    return true;
  }
}
