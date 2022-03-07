import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api/bloc/bloc_provider.dart';
import 'package:flutter_api/bloc/auth_bloc.dart';
import 'package:flutter_api/bloc/book_bloc.dart';
import 'package:flutter_api/ui/book_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Entrez l\'adresse mail'),
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Entrez un mot de passe'),
            ),
            ElevatedButton(
              onPressed: 
            () async {
              
            }), child: child)
          ],
        ),
      ),
    );
  }
}
