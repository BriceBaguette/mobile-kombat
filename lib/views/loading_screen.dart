import 'package:flutter/material.dart';
import 'package:mobile_kombat/controller_inventory.dart';
import 'package:mobile_kombat/models/auth.dart';
import 'package:mobile_kombat/models/database.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:provider/provider.dart';

class LoaderScreen extends StatelessWidget {
  LoaderScreen({super.key});
  final Database _database = Database();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Loader loader, _) {
      if (loader.ready) {
        if (Auth().currentUser != null) {
          return Consumer<ControllerInventory>(
              builder: (_, data, __) => FutureBuilder(
                  future: data.init().then(
                        (_) => _database
                            .getUserName(Auth().currentUser!.uid)
                            .then((value) => {
                                  Player().username = value,
                                  Navigator.of(context).popAndPushNamed('menu')
                                }),
                      ),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return const Center(child: CircularProgressIndicator());
                  }));
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.popAndPushNamed(context, 'login');
        });
      }
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ]));
    });
  }
}
