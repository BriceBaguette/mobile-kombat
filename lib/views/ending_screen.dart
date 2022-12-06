import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/models/character.dart';

import '../models/opponent.dart';


class EndingScreen extends StatelessWidget {
  late List<Character> characters;
  late Opponent op;
  EndingScreen({required this.characters, required this.op, super.key});

  bool checkHealth(){
    return characters[0].health > characters[1].health;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(child:checkHealth()? Winner(characters: characters, op: op,) : Loser(characters:characters, op: op,));
  }

}

class Winner extends StatelessWidget {
  late List<Character> characters;
  late Opponent op;

  Winner({required this.characters, required this.op, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Padding(
        padding: const EdgeInsets.all(30),
        child:SizedBox(child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Center(
                        child:SizedBox(
                            width:300,
                            height:280,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children:[
                                  const Text("Winner", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35, ),),
                                  Text(Player().getUsername()),
                                  Image.asset(characters[0].getImageDir(), height: 180),
                                  //Player1.cosmetics,
                                ]
                            ))
                    ),
                    Center(
                        child:SizedBox(
                            width:300,
                            height:280,
                            child:Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children:[
                                  const Text("Loser", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35, ),),
                                  Text("username2"),
                                  Image.asset(characters[1].getImageDir(), height: 180,color: Colors.blueGrey.withOpacity(0.5),
                          colorBlendMode: BlendMode.modulate),
                                  //Player2.cosmetics,
                                ]
                            ))
                    ),
                  ]
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    const SizedBox(width: 50),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          const Center(child: Text("Earned gold: 50     ")),
                          Image.asset("assets/images/Coins.png", width: 20,)
                        ]
                    ),

                    IconButton(iconSize: 50, icon: const Icon(Icons.play_arrow,size:75, color: Color(0xFFB71C1C)),
                      onPressed: (){
                        Navigator.of(context).popAndPushNamed('menu');
                      },
                    )
                  ])
            ]
        ))
    ));
  }

}

class Loser extends StatelessWidget {

  late List<Character> characters;
  late Opponent op;

  Loser({required this.characters, required this.op, super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Padding(
        padding: const EdgeInsets.all(30),
        child:SizedBox(child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Center(
                      child:SizedBox(
                          width:300,
                          height:280,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:[
                            const Text("Loser", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35, ),),
                            Text(Player().getUsername()),
                            Image.asset(characters[0].getImageDir(), height: 180,color: Colors.blueGrey.withOpacity(0.5),
                              colorBlendMode: BlendMode.modulate,),
                            //Player1.cosmetics,
                          ]
                      ))
                  ),
                  Center(
                      child:SizedBox(
                          width:300,
                          height:280,
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:[
                            const Text("Winner", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35, ),),
                            Text(op.username),
                            Image.asset(characters[1].getImageDir(), height: 180,),
                            //Player2.cosmetics,
                          ]
                      ))
                  ),
                ]
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    const SizedBox(width: 50),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        const Center(child: Text("Earned gold: 20     ")),
                        Image.asset("assets/images/Coins.png", width: 20,)
                      ]
                  ),

                    IconButton(iconSize: 50, icon: const Icon(Icons.play_arrow,size:75, color: Color(0xFFB71C1C)),
                        onPressed: (){
                          Navigator.of(context).popAndPushNamed('menu');
                        },
                    )
              ])
            ]
        ))
    ));
  }

}
