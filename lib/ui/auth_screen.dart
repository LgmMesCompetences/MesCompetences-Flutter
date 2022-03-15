import 'package:flutter/material.dart';
import 'package:mes_competences/bloc/auth_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mes_competences/bloc/bloc_provider.dart';
import 'package:mes_competences/entity/authenticate.dart';
import 'package:mes_competences/bloc/profile_bloc.dart';
import 'package:mes_competences/ui/profile_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = BlocProvider.of<AuthBloc>(context);
    final bloc = AuthBloc();
    final _formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Form(
              key: _formKey,
              //autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your email',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid email";
                      } else {
                        return EmailValidator.validate(value)
                            ? null
                            : "Please enter a valid email";
                      }
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Enter your password',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  StreamBuilder(
                    stream: bloc.stream,
                    builder: (ctx, snapshot) {
                      if (snapshot.data != null) {
                        if (snapshot.hasData) {
                          Authenticate data = snapshot.data as Authenticate;
                          if (data.message != null) {
                            return Text(
                              data.message.toString(),
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                      return const Text('');
                    },
                  ),
                  ElevatedButton(
                    child: const Text('login'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await bloc.doAuthentication(
                            emailController.text, passwordController.text);
                        Authenticate result = bloc.auth;
                        if (result.token != null) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                              return BlocProvider<ProfileBloc>(bloc: ProfileBloc(), child: const ProfileScreen());
                            }));
                        }
                      }
                    },
                  ),
                ],
              ))),
    );
  }
}
