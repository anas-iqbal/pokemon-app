import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/login/login_state.dart';
import 'package:pokemon_app/services/fcm_service.dart';
import 'package:pokemon_app/utils/exception_handler.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());
  void login(String email, String password) async {
    try {
      emit(LoadingState((true)));
      var res = await FCMService.loginUser(email, password);
      emit(LoginSuccessState(true));
    } catch (e) {
      emit(LoadingState(false));
      var exceptionData = await ExceptionHandler().handleException(e);
      emit(LoginFailState(true, exceptionData));
    }
  }
}
