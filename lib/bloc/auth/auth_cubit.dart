import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/auth/auth_state.dart';
import 'package:pokemon_app/services/fcm_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialState());
  void checkUserLoggedIn() async {
    await Future.delayed(const Duration(seconds: 3));
    if (FCMService.isUserLoggedIn()) {
      emit(AuthenticatedState(true));
    } else
      emit(AuthenticatedState(false));
  }
}
