import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api/bloc/bloc.dart';
import 'package:flutter_api/bloc/bloc_provider.dart';
import 'package:flutter_api/bloc/auth_bloc.dart';
import 'package:flutter_api/bloc/book_bloc.dart';
import 'package:flutter_api/ui/book_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);
    final email = TextEditingController();
    final password = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Inscription',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            TextField(
              controller: email,
              decoration:
                  const InputDecoration(hintText: 'Entrez l\'adresse mail'),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            TextField(
              controller: password,
              decoration:
                  const InputDecoration(hintText: 'Entrez un mot de passe'),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            ElevatedButton(
              onPressed: () async {
                await bloc.doCreateUser(email.text, password.text);
                //continue here to create a user
              },
              child: const Text('Créer l\'utilisateur'),
            )
          ],
        ),
      ),
    );
  }
}
