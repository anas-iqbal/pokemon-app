import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class InitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  AuthenticatedState(this.isAuthenticated);
  final bool isAuthenticated;
  @override
  List<Object> get props => [isAuthenticated];
}
