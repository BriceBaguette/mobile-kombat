import 'package:flutter/material.dart';
import 'package:mobile_kombat/controller_inventory.dart';
import 'package:provider/provider.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          toolbarHeight: 40,
          title: const Text("Credits"),
          leading: Row(children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).popAndPushNamed('menu');
              },
              tooltip: 'credits',
            ),
          ]),
        ),
        body: Consumer<ControllerInventory>(
          builder: (_, data, __) => Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Developpers:", textAlign: TextAlign.justify),
                      Text("Designer:")
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(" Victor Wéry\n François Grosjean\n Brice Baguette"),
                      Text("Magali Wéry")
                    ]),
              ])),
        ));
  }
}
