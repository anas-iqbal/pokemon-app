import 'package:equatable/equatable.dart';
import 'package:pokemon_app/models/pokemon_list_response_mode.dart';

abstract class HomeState extends Equatable {}

class InitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {
  LoadingState(this.isLoading);
  final bool isLoading;
  @override
  List<Object> get props => [isLoading];
}

class LoadedApiSuccessState extends HomeState {
  LoadedApiSuccessState(this.isLoginSuccess, this.pokemonList);
  final bool isLoginSuccess;
  final List<Pokemon> pokemonList;
  @override
  List<Object> get props => [isLoginSuccess, pokemonList];
}

class LoadingAPIFailState extends HomeState {
  LoadingAPIFailState(this.isLoginFailed, this.errorMsg);
  final bool isLoginFailed;
  final String errorMsg;

  @override
  List<Object> get props => [isLoginFailed, errorMsg];
}
