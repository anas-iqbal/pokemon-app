import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/home/home_states.dart';
import 'package:pokemon_app/models/pokemon_list_response_mode.dart';
import 'package:pokemon_app/services/fcm_service.dart';
import 'package:pokemon_app/services/pokemon_service.dart';
import 'package:pokemon_app/utils/exception_handler.dart';
import 'package:pokemon_app/utils/shared_pref_helder.dart';

class HomeCubit extends Cubit<HomeState> {
  PokemonService _pokemonService = PokemonService();
  List<Pokemon> favouriteList = [];

  HomeCubit() : super(InitialState());

  void getUserFavouriteList() async {
    favouriteList = await SharedPreferenceHelper.getUserFavourites();
  }

  void logoutUser() async {
    try {
      emit(LoadingState((true)));
      var res = await FCMService.logout();
      emit(LoadingState((false)));
      emit(LogoutSuccessState(true));
    } catch (e) {
      emit(LoadingState((false)));
      var exceptionData = await ExceptionHandler().handleException(e);
      emit(LoadingAPIFailState(true, exceptionData));
    }
  }

  void getPokemonList() async {
    emit(LoadingState((true)));
    try {
      PokemonListResponseModel res = await _pokemonService.getPokemonList();
      emit(LoadingState((false)));
      emit(LoadedApiSuccessState(true, res.results));
    } catch (e) {
      emit(LoadingState((false)));
      var exceptionData = await ExceptionHandler().handleException(e);
      emit(LoadingAPIFailState(true, exceptionData));
    }
  }

  bool isFavourite(Pokemon currentPokemon) {
    if (favouriteList != null) {
      var alreadyExist = favouriteList.firstWhere(
          (x) => x.name.contains(currentPokemon.name),
          orElse: () => null);
      if (alreadyExist != null) {
        return true;
      }
    }
    return false;
  }

  changeFavouriteStatus(Pokemon item, bool status) async {
    print("**************************");
    updateSavedList(item, status);

    // favouriteList.forEach((element) {
    //   if (element.name == item.name) {
    //     element.isFavourite = !element.isFavourite;
    //     updateSavedList(item, element.isFavourite);
    //   }
    // });
  }

  updateSavedList(Pokemon selectedItem, bool updateFavStatus) async {
    var abc = favouriteList;
    var alreadyExist = favouriteList
        .firstWhere((x) => x.name == selectedItem.name, orElse: () => null);
    if (alreadyExist == null && updateFavStatus) {
      favouriteList.add(selectedItem);
    } else {
      if (!updateFavStatus) {
        favouriteList.removeWhere((item) => item.name == selectedItem.name);
      }
    }
    SharedPreferenceHelper.saveFavourites(jsonEncode(favouriteList));
  }
}
