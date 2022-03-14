import 'package:flutter/material.dart';
import 'package:flutter_api/bloc/auth_bloc.dart';

import 'package:flutter_api/bloc/bloc_provider.dart';
import 'package:flutter_api/bloc/book_bloc.dart';
import 'package:flutter_api/ui/book_screen.dart';
import 'package:flutter_api/ui/create_user.dart';
import 'package:flutter_api/ui/login_screen.dart';

class MainScaffold extends StatelessWidget {
  final String title;

  const MainScaffold({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'MesCompétences.dev',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            ElevatedButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BlocProvider<AuthBloc>(
                      bloc: AuthBloc(), child: const LoginScreen());
                }))
              },
              child: const Text("Se connecter"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.blue)),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            ElevatedButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BlocProvider<AuthBloc>(
                      bloc: AuthBloc(), child: const CreateUserScreen());
                }))
              },
              child: const Text("S'inscrire"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
