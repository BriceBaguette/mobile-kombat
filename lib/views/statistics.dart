import 'package:flutter/material.dart';
class Statistics extends StatelessWidget {

  Statistics({super.key});

  // Get statistics from Firebase (don't forget to update when a match finishes!!!!)

  double _totalTimePlayed = 3722;
  double _timePlayedAsChar1 = 0.0;
  double _timePlayedAsChar2 = 0.0;
  int _totalGold = 0;
  int _numberCosmetic = 0;
  int _numberCharacter = 0;

  String convertDoubleToHour(double time){
    double r1 = time%3600;
    double r2 = r1%60;
    double r3 = r2%60;
    int timeHour = (time-r1)~/3600;
    int timeMin = (time-3600*timeHour-r2)~/60;
    int timeSec = r3~/1;
    return "$timeHour h $timeMin m $timeSec s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text("Statistics"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:const [
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
              children:[
                Text(convertDoubleToHour(_totalTimePlayed)),
                Text(convertDoubleToHour(_timePlayedAsChar1)),
                Text(convertDoubleToHour(_timePlayedAsChar2)),
                Text(" $_totalGold gold" ),
                Text(" $_numberCosmetic"),
                Text(" $_numberCharacter"),
              ]
            ),

          ]
        )
      ),
    );
  }

}
