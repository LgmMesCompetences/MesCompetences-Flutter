import 'dart:async';
import 'package:mes_competences/service/mescompetences_api.dart';
import 'package:mes_competences/entity/authenticate.dart';
import 'bloc.dart';

class AuthBloc extends Bloc {
  late Authenticate _auth;

  //Stream Controller
  final _streamController = StreamController<Authenticate>();

  //Input
  Sink<Authenticate> get sink => _streamController.sink;

  //Output
  Stream<Authenticate> get stream => _streamController.stream;

  //Working logique
  doAuthentication(String email, String password) async {
    _auth = await MesCompetencesApi().doAuthenticate(email: email, password: password);
    sink.add(_auth);
  }

  Authenticate get auth => _auth;

  //Closing
  @override
  dispose() => _streamController.close();
}
