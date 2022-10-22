import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ffi';

import 'cosmetics.dart';
import 'characters.dart';
import 'inventory.dart';
import 'shop.dart';
//import 'game.dart';
//import 'stats.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Mobile Kombat',
    home: MainMenu(),
  ));
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('First Route'),
      ),*/
      body: Container(
          decoration: const BoxDecoration(
            /*image: DecorationImage(
                image: AssetImage("assets/images/919490.png"),
                fit: BoxFit.cover),*/
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 50,
                  height: 200,),
                Container(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  child: const Text('Inventory'),
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inventory()),
                  );
                },
              ),),
                Container(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                  child: const Text('Shop'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Shop()),
                    );
                  },
                ),),
                Container(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Stats'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Inventory()),
                      );},
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/images/10522.png', scale:2.5),
              ],
            ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height:275,),
                  Container(
                    width: 150,
                    height: 75,
                    child: ElevatedButton(
                      child: const Text('Play'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Inventory()),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
      ),
    );
  }
}