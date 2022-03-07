import 'package:flutter/material.dart';

import 'package:flutter_api/bloc/bloc_provider.dart';
import 'package:flutter_api/bloc/book_bloc.dart';
import 'package:flutter_api/ui/book_screen.dart';

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
              child: const Text('Articles'),
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return BlocProvider<BookBloc>(
                      bloc: BookBloc(), child: BookScreen());
                }))
              },
            ),
          ],
        ),
      ),
    );
  }
}
