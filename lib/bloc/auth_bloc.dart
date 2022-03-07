import 'dart:async';
import 'bloc.dart';
import 'package:flutter_api/service/mes_competences_api.dart';
import 'package:flutter_api/modele/authenticate.dart';

class AuthBloc extends Bloc {
  late Authenticate _authenticate;

  //Stream Controller
  final _streamController = StreamController<Authenticate>();

  //Input
  Sink<Authenticate> get sink => _streamController.sink;

  //Output
  Stream<Authenticate> get stream => _streamController.stream;

  //Working logique
  doAuthenticate(String email, String password) async {
    _authenticate = await MesCompetencesApi().authenticate(email, password);
    sink.add(_authenticate);
  }

  Authenticate get authenticate => _authenticate;

  //Closing
  @override
  dispose() => _streamController.close();
}
