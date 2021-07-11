import 'dart:convert';

import 'package:pokemon_app/models/pokemon_list_response_mode.dart';
import 'package:pokemon_app/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences localStorage;

  static Future<List<Pokemon>> getUserFavourites() async {
    var localStorage = await SharedPreferences.getInstance();
    var savedMapList = localStorage.getString(cache.userEmail);
    if (savedMapList != null) {
      var favouriteMap = jsonDecode(savedMapList);
      List<Pokemon> pokemonList = [];
      favouriteMap.forEach((v) {
        pokemonList.add(new Pokemon.fromJson(v));
      });
      return pokemonList;
    } else {
      List<Pokemon> pokemonList = [];
      return pokemonList;
    }
  }

  static saveFavourites(String pokemonList) async {
    var localStorage = await SharedPreferences.getInstance();
    localStorage.setString(cache.userEmail, pokemonList);
  }

  static clearData() async {
    var localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
  }
}
