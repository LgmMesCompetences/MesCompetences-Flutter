import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api/bloc/bloc_provider.dart';
import 'package:flutter_api/bloc/auth_bloc.dart';
import 'package:flutter_api/bloc/book_bloc.dart';
import 'package:flutter_api/ui/book_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePagePosseder extends StatelessWidget {
  const HomePagePosseder({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Vous êtes connectés',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
