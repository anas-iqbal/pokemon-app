import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/home/home_states.dart';
import 'package:pokemon_app/models/pokemon_list_response_mode.dart';
import 'package:pokemon_app/services/fcm_service.dart';
import 'package:pokemon_app/services/pokemon_service.dart';
import 'package:pokemon_app/utils/shared_pref_helder.dart';

class HomeCubit extends Cubit<HomeState> {
  PokemonService _pokemonService = PokemonService();
  List<Pokemon> favouriteList = [];

  HomeCubit() : super(InitialState());

  void getUserFavouriteList() async {
    favouriteList = await SharedPreferenceHelper.getUserFavourites();
  }

  void getPokemonList() async {
    emit(LoadingState((true)));
    PokemonListResponseModel res = await _pokemonService.getPokemonList();
    if (res != null) {
      emit(LoadingState((false)));
      emit(LoadedApiSuccessState(true, res.results));
    } else {
      emit(LoadingAPIFailState(true, "Failed to register"));
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

  markPokemonFavourite(Pokemon item) async {
    print("**************************");
    item.isFavourite = !item.isFavourite;
    updateSavedList(item, true);

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
    if (alreadyExist == null && selectedItem.isFavourite) {
      favouriteList.add(selectedItem);
    } else {
      if (!selectedItem.isFavourite) {
        favouriteList.removeWhere((item) => item.name == selectedItem.name);
      }
    }

    SharedPreferenceHelper.saveFavourites(jsonEncode(favouriteList));
  }
}
