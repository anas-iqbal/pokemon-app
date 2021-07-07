import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/registration/registration_cubit.dart';
import 'package:pokemon_app/screens/register_screen.dart';
import 'package:pokemon_app/utils/app_theme.dart';
import 'package:pokemon_app/utils/validators.dart';
import 'package:pokemon_app/widgets/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.12,
                ),
                Image(
                  image: AssetImage('assets/ic_pokemon.png'),
                  width: 280.0,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Gotta Catch 'Em All",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: loginForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm(BuildContext context) {
    // if (!Foundation.kReleaseMode) {
    // controllerUsername.text = "spostam";
    // controllerPassword.text = "password";
    //}

    return Container(
      width: width * 0.80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: Column(
          children: [
            TextFieldWidget(
              hintValue: "Username",
              inputFormatters: <TextInputFormatter>[],
              validator: (username) => Validators().validUsername(username),
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldWidget(
                hintValue: "Password", inputFormatters: <TextInputFormatter>[]),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            loginButton(context),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return BlocProvider<RegistrationCubit>(
                    create: (context) => RegistrationCubit(),
                    child: RegisterScreen(),
                  );
                }));
              },
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: AppTheme.colorPrimary,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: RaisedButton(
          color: AppTheme.colorPrimary,
          child: Text(
            "SIGN IN",
            style: TextStyle(
                color: AppTheme.colorButtonText, fontWeight: FontWeight.w900),
          ),
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          )),
    );
  }
}
