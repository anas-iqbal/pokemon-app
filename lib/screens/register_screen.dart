import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokemon_app/bloc/auth/auth_cubit.dart';
import 'package:pokemon_app/bloc/home/home_cubit.dart';
import 'package:pokemon_app/bloc/registration/registration_cubit.dart';
import 'package:pokemon_app/bloc/registration/registration_state.dart';
import 'package:pokemon_app/screens/home_screen.dart';
import 'package:pokemon_app/utils/app_theme.dart';
import 'package:pokemon_app/utils/loader_widget.dart';
import 'package:pokemon_app/utils/validators.dart';
import 'package:pokemon_app/widgets/dialogs.dart';
import 'package:pokemon_app/widgets/text_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  double width;
  double height;
  final _registrationFormKey = GlobalKey<FormBuilderState>();
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.height;
    return BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
      if (state is RegistrationFailedState) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(message: state.errorMsg.message);
            });
      } else if (state is RegistrationSuccessState) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider<HomeCubit>(
                create: (context) => HomeCubit()
                  ..getPokemonList()
                  ..getUserFavouriteList(),
                child: HomeScreen(),
              );
            },
          ),
          (Route<dynamic> route) => false,
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppTheme.colorBackground,
        body: LoaderWidget(
          isTrue: state is LoadingState ? state.isLoading : false,
          child: SafeArea(
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
                      width: height * 0.18,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      "Gotta Catch 'Em All",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: registrationForm(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget registrationForm(BuildContext context) {
    return FormBuilder(
      key: _registrationFormKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Container(
        width: width * 0.80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: AppTheme.colorDarkGrey,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.email(context),
                ]),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                obscureText: true,
                name: 'password',
                decoration: InputDecoration(
                  hintText: "Password",
                  filled: true,
                  fillColor: AppTheme.colorDarkGrey,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.minLength(context, 6),
                ]),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                obscureText: true,
                name: 'confirmPassword',
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  filled: true,
                  fillColor: AppTheme.colorDarkGrey,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                // valueTransformer: (text) => num.tryParse(text),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.minLength(context, 6),
                  (val) {
                    if (val !=
                        _registrationFormKey
                            .currentState?.fields['password']?.value) {
                      return 'Passwords do not match';
                    }
                    return null;
                  }
                ]),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return Container(
      width: double.infinity,
      height: 45,
      child: RaisedButton(
          color: AppTheme.colorPrimary,
          child: Text(
            "Register",
            style: TextStyle(
                color: AppTheme.colorButtonText, fontWeight: FontWeight.w900),
          ),
          onPressed: () {
            if (_registrationFormKey.currentState?.saveAndValidate() ?? false) {
              print('Valid');
              var regCubit =
                  BlocProvider.of<RegistrationCubit>(context, listen: false);
              regCubit.register(
                  _registrationFormKey.currentState?.value['email'],
                  _registrationFormKey.currentState?.value['password']);
            }
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
