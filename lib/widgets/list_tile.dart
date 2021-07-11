import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokemon_app/bloc/home/home_cubit.dart';
import 'package:pokemon_app/models/pokemon_list_response_mode.dart';
import 'package:pokemon_app/utils/app_theme.dart';

class PokemonListTile extends StatelessWidget {
  final Pokemon pokemon;
  final Function(Pokemon selectedPokemon) onFavouriteClick;
  final HomeCubit homeCubit;
  PokemonListTile(
      {Key key,
      @required this.pokemon,
      @required this.onFavouriteClick,
      this.homeCubit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: double.infinity,
          height: 100,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  child: Image(
                    image: AssetImage('assets/pokemon_ball.png'),
                    height: 70,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        pokemon.name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          homeCubit.isFavourite(pokemon)
                              ? GestureDetector(
                                  onTap: () {
                                    onFavouriteClick(pokemon);
                                  },
                                  child: Row(
                                    children: [
                                      Text("Favourite",
                                          style: TextStyle(
                                              color: AppTheme.colorPrimary,
                                              fontWeight: FontWeight.bold)),
                                      Icon(
                                        Icons.star_border_outlined,
                                        color: AppTheme.colorPrimary,
                                        size: 20.0,
                                      ),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    onFavouriteClick(pokemon);
                                  },
                                  child: Row(
                                    children: [
                                      Text("Favourite",
                                          style: TextStyle(
                                              color: AppTheme.colorPrimary,
                                              fontWeight: FontWeight.bold)),
                                      Icon(
                                        Icons.star,
                                        color: AppTheme.colorPrimary,
                                        size: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
