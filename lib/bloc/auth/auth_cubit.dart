import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialState());
  void checkUserLoggedIn() async {
    await Future.delayed(const Duration(seconds: 5));
    emit(AuthenticatedState(false));
  }
}
