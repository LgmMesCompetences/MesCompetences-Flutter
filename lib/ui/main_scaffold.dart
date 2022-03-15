import 'package:flutter/material.dart';

import 'package:mes_competences/bloc/bloc_provider.dart';
import 'package:mes_competences/bloc/auth_bloc.dart';
import 'package:mes_competences/ui/auth_screen.dart';

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
            const Text('Choose your app'),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BlocProvider<AuthBloc>(
                      bloc: AuthBloc(), child: const AuthScreen());
                }))
              },
            ),
          ],
        ),
      ),
    );
  }
}
