import 'dart:async';
import 'dart:developer';
import 'bloc.dart';
import 'package:flutter_api/service/mes_competences_api.dart';
import 'package:flutter_api/modele/authenticate.dart';
import 'package:flutter_api/modele/user.dart';

class AuthBloc extends Bloc {
  late Authenticate _authenticate;
  late User _createUser;

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
    inspect(_authenticate);
  }

  doCreateUser(String email, String password) async {
    _createUser = await MesCompetencesApi().createUser(email, password);
    inspect(createUser);
  }

  User get createUser => _createUser;
  Authenticate get authenticate => _authenticate;

  //Closing
  @override
  dispose() => _streamController.close();
}
