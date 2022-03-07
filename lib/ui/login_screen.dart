import 'package:flutter/material.dart';
import 'home_page_posseder.dart';
import 'package:flutter_api/bloc/bloc_provider.dart';
import 'package:flutter_api/bloc/auth_bloc.dart';
import 'package:flutter_api/ui/home_page_posseder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);
    final storage = FlutterSecureStorage();
    final email = TextEditingController();
    final password = TextEditingController();

    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Connexion',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              TextField(
                controller: email,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              ElevatedButton(
                onPressed: () async {
                  await bloc.doAuthenticate(email.text, password.text);

                  if (bloc.authenticate.message == null) {
                    storage.write(key: "email", value: email.text);
                    storage.write(key: "password", value: password.text);
                    storage.write(key: "token", value: bloc.authenticate.token);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePagePosseder()));
                  }
                },
                child: const Text("Se connecter"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blue)),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
            ],
          ),
        ));
  }
}
