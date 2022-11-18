import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/views/main_menu.dart';
import 'package:provider/provider.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Loader loader, _) {
      if (loader.ready) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, 'menu');
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
