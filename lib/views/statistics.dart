import 'package:flutter/material.dart';
import 'package:mobile_kombat/controller_inventory.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/database.dart';

class Statistics extends StatelessWidget {
  Statistics({super.key});

  String convertDoubleToHour(double time) {
    double r1 = time % 3600;
    double r2 = r1 % 60;
    double r3 = r2 % 60;
    int timeHour = (time - r1) ~/ 3600;
    int timeMin = (time - 3600 * timeHour - r2) ~/ 60;
    int timeSec = r3 ~/ 1;
    return "$timeHour h $timeMin m $timeSec s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[800],
          toolbarHeight: 40,
          title: const Text("Statistics"),
          leading: Row(children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).popAndPushNamed('menu');
              },
              tooltip: 'Statistics',
            ),
          ]),
        ),
        body: Consumer<ControllerInventory>(
          builder: (_, data, __) => Center(
              child:
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Total time played:", textAlign: TextAlign.justify),
                          Text("Total time played as Character 1:"),
                          Text("Total time played as Character 2:"),
                          Text("Total gold earned:"),
                          Text("Number of cosmetics possessed:"),
                          Text("Number of characters possessed:"),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(convertDoubleToHour(data.getTotTime())),
                          Text(convertDoubleToHour(data.getTimeChar1())),
                          Text(convertDoubleToHour(data.getTimeChar2())),
                          Text(" ${data.getTotGold()} gold"),
                          Text(" ${data.getNumCosm()}"),
                          Text(" ${data.getNumChar()}"),
                        ]),
                  ])),)
    );
  }
}
