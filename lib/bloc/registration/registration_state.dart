import 'package:equatable/equatable.dart';
import 'package:pokemon_app/utils/exception_handler.dart';

abstract class RegistrationState extends Equatable {}

class InitialState extends RegistrationState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RegistrationState {
  LoadingState(this.isLoading);
  final bool isLoading;
  @override
  List<Object> get props => [isLoading];
}

class RegistrationSuccessState extends RegistrationState {
  RegistrationSuccessState(this.isSuccessfullyRegistered);
  final bool isSuccessfullyRegistered;
  @override
  List<Object> get props => [isSuccessfullyRegistered];
}

class RegistrationFailedState extends RegistrationState {
  RegistrationFailedState(this.isRegistrationFailed, this.errorMsg);
  final bool isRegistrationFailed;
  final ExceptionData errorMsg;

  @override
  List<Object> get props => [isRegistrationFailed, errorMsg];
}
