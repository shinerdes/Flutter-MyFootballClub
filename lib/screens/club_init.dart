import 'package:flutter/material.dart';
import 'package:my_football_club/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/football_clubs.dart';

import '../theme/app_theme.dart';

class ClubInit extends StatefulWidget {
  const ClubInit({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClubInit();
  }
}

class _ClubInit extends State<ClubInit> {
  int selectedCard = 0;

  static void setIndex(int input) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('index', input);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Pick Your Club",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                    builder: ((context) {
                      return AlertDialog(
                        title:
                            Text(footballClubList[selectedCard]['clubname']!),
                        content: const Text("팀을 정하겠습니까?"),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          side: BorderSide(width: 2.0),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                setIndex(selectedCard);
                              });
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.7),
                            ),
                            child: const Text("네"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); //창 닫기
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.7),
                            ),
                            child: const Text("아니요"),
                          ),
                        ],
                      );
                    }),
                  );
                },
                icon: const Icon(
                  Icons.check_circle_outline_outlined,
                  color: Colors.black,
                )),
          ],
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
                setState(
                  () {
                    selectedCard = index;
                  },
                );
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
                        colors: selectedCard == index
                            ? [
                                Colors.black.withOpacity(0.8),
                                Colors.deepPurple.withOpacity(1),
                              ]
                            : [
                                Colors.white.withOpacity(0.5),
                                Colors.red.withOpacity(0.7),
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
        ));
  }
}
