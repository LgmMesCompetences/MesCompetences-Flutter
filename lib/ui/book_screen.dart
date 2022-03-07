import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api/bloc/bloc_provider.dart';
import 'package:flutter_api/bloc/book_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookScreen extends StatelessWidget {
  BookScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  late String _valeurSaisie;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BookBloc>(context);
    final storage = FlutterSecureStorage();

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Numéro ISBN :',
                      ),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (valeur) {
                          if (valeur == null ||
                              valeur.isEmpty) {
                            return 'Please enter a valid String';
                          } else {
                            _valeurSaisie = valeur;
                          }
                        },
                      ),
                      ElevatedButton(
                        child: const Text('fetch'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            /*
                            await bloc.fetchBook(_valeurSaisie);
                            executeAfterFetch(context, bloc);
                            */

                            if (await storage.containsKey(key: 'isbn')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          (await storage.read(key: 'isbn'))!)));
                            } else {
                              storage.write(key: 'isbn', value: _valeurSaisie);
                            }
                          }
                        },
                      ),
                    ],
                  )));
        },
      ),
    );
  }

  void executeAfterFetch(BuildContext context, BookBloc bloc) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(bloc.book != null ? bloc.book!.title : 'non trouver'),
    ));
  }
}
