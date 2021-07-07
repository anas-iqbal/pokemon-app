import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/registration/registration_state.dart';
import 'package:pokemon_app/services/fcm_service.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(InitialState());
  void register(String email, String password) async {
    emit(LoadingState((true)));
    var res = await FCMService.registerUser(email, password);
    if (res) {
      emit(RegistrationSuccessState(true));
    } else {
      emit(RegistrationFailedState(true, "Failed to register"));
    }
    emit(LoadingState((true)));
  }
}
