import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/registration/registration_state.dart';
import 'package:pokemon_app/services/fcm_service.dart';
import 'package:pokemon_app/utils/exception_handler.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(InitialState());
  void register(String email, String password) async {
    try {
      emit(LoadingState((true)));
      var res = await FCMService.registerUser(email, password);
      emit(LoadingState((false)));
      emit(RegistrationSuccessState(true));
    } catch (e) {
      emit(LoadingState(false));
      var exceptionData = await ExceptionHandler().handleException(e);
      emit(RegistrationFailedState(true, exceptionData));
    }
  }
}
