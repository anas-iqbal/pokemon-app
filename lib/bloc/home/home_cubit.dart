import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/home/home_states.dart';
import 'package:pokemon_app/models/pokemon_list_response_mode.dart';
import 'package:pokemon_app/services/fcm_service.dart';
import 'package:pokemon_app/services/pokemon_service.dart';

class HomeCubit extends Cubit<HomeState> {
  PokemonService _pokemonService = PokemonService();
  HomeCubit() : super(InitialState());
  void getPokemonList() async {
    emit(LoadingState((true)));
    PokemonListResponseModel res = await _pokemonService.getPokemonList();
    if (res != null) {
      emit(LoadingState((false)));
      emit(LoadedApiSuccessState(true, res));
    } else {
      emit(LoadingAPIFailState(true, "Failed to register"));
    }
  }
}
