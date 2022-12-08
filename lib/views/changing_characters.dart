import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile_kombat/controller_inventory.dart';
import '../models/character.dart';

class ChangingCharacters extends StatelessWidget {
  const ChangingCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          toolbarHeight: 40,
          leading: Row(children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: 'changingcharacters',
            ),
          ]),
          actions: const [],
          title: const Text("Characters owned"),
          centerTitle: true,
        ),
        body: Consumer<ControllerInventory>(
            builder: (_, data, __) => Center(
                child: Column(children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width - 10,
                      child: ListView.builder(
                          itemCount: data.getItemsInvChar().length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Center(
                                                child: Text(data
                                                    .getItemsInvChar()[index]
                                                    .getName())),
                                            content: PopUpChar(
                                                c: data
                                                    .getItemsInvChar()[index]),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  data.equipChar(
                                                      data.getItemsInvChar()[
                                                      index]);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Equip'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ));
                                },
                                child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blueGrey.shade300,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          CharacterWidget(
                                              c: data.getItemsInvChar()[index]),
                                          //Make widget for character
                                          ElevatedButton(
                                            onPressed: () {
                                              data.equipChar(data
                                                  .getItemsInvChar()[index]);
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Equip'),
                                          ),
                                        ],
                                      ),
                                    )));
                          }))
                ]))));
  }
}
