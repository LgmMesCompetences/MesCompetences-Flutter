import 'package:flutter/material.dart';
import 'package:mes_competences/bloc/bloc_provider.dart';
import 'package:mes_competences/bloc/profile_bloc.dart';
import 'package:mes_competences/entity/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);

    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            User data = snapshot.data as User;
            List<Widget> widgets = List.empty(growable: true);
            widgets.add(Text(data.email));
            widgets.add(const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
              color: Colors.black,
            ));
            for (var posseder in data.posseder) {
              widgets.add(Text(posseder['competence']['libelle']));
            }
            return Scaffold(
              body: Center(child: Column(children: widgets)),
            );
          }
        }

        return Scaffold(
          body: Center(child: Column(children: const <Widget>[Text('No User')])),
        );
      },
    );
  }
}
