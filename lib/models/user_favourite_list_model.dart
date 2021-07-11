import 'package:pokemon_app/models/pokemon_list_response_mode.dart';

class UserFavouriteListModel {
  String userID;
  List<Pokemon> results;

  UserFavouriteListModel.fromJson(Map<String, dynamic> json) {
    userID = json['userid'];
    if (json['results'] != null) {
      results = new List<Pokemon>();
      json['results'].forEach((v) {
        results.add(new Pokemon.fromJson(v));
      });
    }
  }
}
