import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_app/utils/app_theme.dart';
import 'package:pokemon_app/utils/validators.dart';
import 'package:pokemon_app/widgets/text_field_widget.dart';

class HomeScreen extends StatelessWidget {
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
                  image: AssetImage('assets/ic_logo.png'),
                  width: 280.0,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "10 Line Card",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Enjoy griping entertainment!",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                loginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
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
                  hintValue: "Password",
                  inputFormatters: <TextInputFormatter>[]),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                loginButton(),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
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

  Widget loginButton() {
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
            // FocusScope.of(context).requestFocus(new FocusNode());
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
