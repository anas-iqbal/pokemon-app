import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokemon_app/bloc/home/home_cubit.dart';
import 'package:pokemon_app/bloc/login/login_cubit.dart';
import 'package:pokemon_app/bloc/login/login_state.dart';
import 'package:pokemon_app/bloc/registration/registration_cubit.dart';
import 'package:pokemon_app/screens/home_screen.dart';
import 'package:pokemon_app/screens/register_screen.dart';
import 'package:pokemon_app/utils/app_theme.dart';
import 'package:pokemon_app/utils/validators.dart';
import 'package:pokemon_app/widgets/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  double width;
  double height;
  final _loginFormKey = GlobalKey<FormBuilderState>();
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.height;
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoginSuccessState) {
        if (state.isLoginSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(),
              child: HomeScreen(),
            );
          }));
        }
      }
    }, builder: (context, snapshot) {
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
                      width: height * 0.20),
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
    });
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
        child: FormBuilder(
            key: _loginFormKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                TextFieldWidget(
                  name: 'email',
                  hintValue: "Username",
                  inputFormatters: <TextInputFormatter>[],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  name: 'password',
                  obscureText: true,
                  hintValue: "Password",
                  inputFormatters: <TextInputFormatter>[],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 6)
                  ]),
                ),
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
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
          onPressed: () {
            if (_loginFormKey.currentState?.saveAndValidate() ?? false) {
              print('Valid');
              var loginCubit =
                  BlocProvider.of<LoginCubit>(context, listen: false);
              loginCubit.login(_loginFormKey.currentState?.value['email'],
                  _loginFormKey.currentState?.value['password']);
            } else {
              print('Invalid');
            }
            print(_loginFormKey.currentState?.value);
          },
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
