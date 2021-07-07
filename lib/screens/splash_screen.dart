import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/auth/auth_cubit.dart';
import 'package:pokemon_app/bloc/auth/auth_state.dart';
import 'package:pokemon_app/screens/home_screen.dart';
import 'package:pokemon_app/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthenticatedState) {
        if (!state.isAuthenticated) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return LoginScreen();
          }));
        }
      }
    }, builder: (context, snapshot) {
      return Container(
        color: Colors.white,
        child: SizedBox.expand(
          child: Center(
              child: Image(
            image: AssetImage('assets/ic_pokemon.png'),
            height: height * 0.30,
          )),
        ),
      );
    });
  }
}
