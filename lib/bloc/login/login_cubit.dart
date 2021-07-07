import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/login/login_state.dart';
import 'package:pokemon_app/services/fcm_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());
  void login(String email, String password) async {
    emit(LoadingState((true)));
    var res = await FCMService.loginUser(email, password);
    if (res) {
      emit(LoginSuccessState(true));
    } else {
      emit(LoginFailState(true, "Failed to register"));
    }
    emit(LoadingState((true)));
  }
}
