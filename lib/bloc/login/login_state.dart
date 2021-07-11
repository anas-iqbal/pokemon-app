import 'package:equatable/equatable.dart';
import 'package:pokemon_app/utils/exception_handler.dart';

abstract class LoginState extends Equatable {}

class InitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  LoadingState(this.isLoading);
  final bool isLoading;
  @override
  List<Object> get props => [isLoading];
}

class LoginSuccessState extends LoginState {
  LoginSuccessState(this.isLoginSuccess);
  final bool isLoginSuccess;
  @override
  List<Object> get props => [isLoginSuccess];
}

class LoginFailState extends LoginState {
  LoginFailState(this.isLoginFailed, this.errorData);
  final bool isLoginFailed;
  final ExceptionData errorData;

  @override
  List<Object> get props => [isLoginFailed, errorData];
}
