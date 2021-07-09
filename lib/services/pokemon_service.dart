import 'dart:convert';

import 'package:pokemon_app/api_manager/api_constants.dart';
import 'package:pokemon_app/api_manager/api_handler.dart';
import 'package:pokemon_app/models/pokemon_list_response_mode.dart';

class PokemonService {
  getPokemonList() async {
    var source = await ApiResponseInjector().httpDataSource(ApiType.DefaultApi);
    var res = await source.get(
      '${APIConstants.getPokemonListApiURL}',
    );
    return PokemonListResponseModel.fromJson(res);
  }
}
