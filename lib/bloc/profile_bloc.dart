import 'dart:async';
import 'dart:developer';
import 'package:mes_competences/service/mescompetences_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mes_competences/entity/user.dart';
import 'bloc.dart';

class ProfileBloc extends Bloc {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  late User _user;

  ProfileBloc() {
    getUser();
  }

  //Stream Controller
  final _streamController = StreamController<User>();

  //Input
  Sink<User> get sink => _streamController.sink;

  //Output
  Stream<User> get stream => _streamController.stream;

  //Working logique
  getUser() async {
    int id = await getUserId();
    _user = await MesCompetencesApi().getUser(id: id);
    inspect(_user);
    sink.add(_user);
  }

  Future<int> getUserId() async {
    return int.parse((await storage.read(key: 'app.user.id'))!);
  }

  User get user => _user;

  //Closing
  @override
  dispose() => _streamController.close();
}
