import 'package:flutter/material.dart';
import 'package:my_football_club/widget/task_group.dart';

class Infoformcard extends StatelessWidget {
  const Infoformcard({super.key, this.form = ""});

  final String form;

  @override
  Widget build(BuildContext context) {
    if (form.length >= 5) {
      // 짤라하는 경우
      String result = form.substring(form.length - 5);
      List<String> parts = result.split("");

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 4,
                offset: const Offset(1, 6),
              )
            ],
            gradient: AppColors.getDarkLinearGradient3(Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Form ",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              for (int i = 0; i < 5; i++) ...[
                if (parts[i] == 'W')
                  Image.asset('assets/images/green.png',
                      width: 50, height: 50, fit: BoxFit.fill),
                if (parts[i] == 'D')
                  Image.asset('assets/images/grey.png',
                      width: 50, height: 50, fit: BoxFit.fill),
                if (parts[i] == 'L')
                  Image.asset('assets/images/red.png',
                      width: 50, height: 50, fit: BoxFit.fill),
              ]
            ],
          ),
        ),
      );
    } else {
      List<String> parts = form.split("");
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Text(
              "Form ",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            for (int i = 0; i < form.length; i++) ...[
              if (parts[i] == 'W')
                Image.asset('assets/images/green.png',
                    width: 50, height: 50, fit: BoxFit.fill),
              if (parts[i] == 'D')
                Image.asset('assets/images/grey.png',
                    width: 50, height: 50, fit: BoxFit.fill),
              if (parts[i] == 'L')
                Image.asset('assets/images/red.png',
                    width: 50, height: 50, fit: BoxFit.fill),
            ]
          ],
        ),
      );
    }
  }
}

/*
 Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Text(
                    "W",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  )),
              Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Text(
                    "W",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  )),
              Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Text(
                    "D",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Text(
                  "L",
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
*/
