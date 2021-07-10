import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/home/home_states.dart';
import 'package:pokemon_app/models/pokemon_list_response_mode.dart';
import 'package:pokemon_app/services/fcm_service.dart';
import 'package:pokemon_app/services/pokemon_service.dart';

class HomeCubit extends Cubit<HomeState> {
  PokemonService _pokemonService = PokemonService();
  List<Pokemon> favouriteList = [];

  HomeCubit() : super(InitialState());
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
      var alreadyExist = favouriteList
          .firstWhere((x) => x.name.contains(currentPokemon.name),
              orElse: () => null);
      if (alreadyExist != null) {
        return true;
      }
    }
    return false;
  }


  markPokemonFavourite(Pokemon item) async {
    favouriteList.forEach((element) {
      if (element.name == item.name) {
        element.isFavourite = !element.isFavourite;
        updateSavedList(item, element.isFavourite);
      }
    });
  }

  updateSavedList(Pokemon selectedItem, bool updateFavStatus) async {
    var alreadyExist = favouriteList
        .firstWhere((x) => x.name == selectedItem.name, orElse: () => null);
    if (alreadyExist == null && selectedItem.isFavourite) {
      favouriteList.add(selectedItem);
    } else {
      if (!updateFavStatus) {
        favouriteList.removeWhere((item) => item.name == selectedItem.name);
      }
    }
    // getStorage.write('favouriteItems', homeController.listFavourite);
    // favouriteList.refresh();
  }
}

