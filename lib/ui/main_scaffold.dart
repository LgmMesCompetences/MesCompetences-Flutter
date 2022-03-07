import 'package:flutter/material.dart';
import 'package:flutter_api/bloc/auth_bloc.dart';

import 'package:flutter_api/bloc/bloc_provider.dart';
import 'package:flutter_api/bloc/book_bloc.dart';
import 'package:flutter_api/ui/book_screen.dart';
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
            const Text('Choisir votre page'),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            ElevatedButton(
              child: const Text('Articles'),
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BlocProvider<BookBloc>(
                      bloc: BookBloc(), child: BookScreen());
                }))
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            ElevatedButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BlocProvider<AuthBloc>(
                      bloc: AuthBloc(), child: LoginScreen());
                }))
              },
              child: const Text("Se connecter"),
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
