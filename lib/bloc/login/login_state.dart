import 'package:equatable/equatable.dart';

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
  LoginFailState(this.isLoginFailed, this.errorMsg);
  final bool isLoginFailed;
  final String errorMsg;

  @override
  List<Object> get props => [isLoginFailed, errorMsg];
}
