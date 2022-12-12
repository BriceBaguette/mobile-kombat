import 'package:flutter/material.dart';
import 'package:mobile_kombat/controller_inventory.dart';
import 'package:mobile_kombat/models/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    Auth auth = Auth();
    if (auth.currentUser != null) {
      auth.initializeUser();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.popAndPushNamed(context, 'menu');
      });
    }
    return Align(
        child: SizedBox(
            width: 600,
            height: 300,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  onChanged: (value) => email = value,
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? null
                        : 'Insert a valid email adress';
                  },
                ),
                TextFormField(
                    decoration: const InputDecoration(
                      labelText: "password",
                    ),
                    obscureText: true,
                    onChanged: (value) => password = value,
                    validator: (String? value) {
                      return (null);
                    }),
                const SizedBox(
                  width: double.infinity,
                  height: 20,
                ),
                Consumer<ControllerInventory>(
                    builder: (_, data, __) => ElevatedButton(
                        child: (const Text('Sign in')),
                        onPressed: () => {
                              FutureBuilder(
                                future: auth.signIn(email, password).then((_) =>
                                    data.init().then((_) =>
                                        Navigator.of(context)
                                            .popAndPushNamed('menu'))),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return const CircularProgressIndicator();
                                },
                              )
                            })),
                const SizedBox(
                  width: double.infinity,
                  height: 20,
                ),
                ElevatedButton(
                  child: (const Text('Go to register')),
                  onPressed: () =>
                      Navigator.of(context).popAndPushNamed('register'),
                )
              ],
            ))));
  }
}
