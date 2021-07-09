import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon_list_response_mode.dart';
import 'package:pokemon_app/utils/app_theme.dart';

class PokemonListTile extends StatelessWidget {
  final Pokemon pokemon;
  PokemonListTile({Key key, @required this.pokemon}) : super(key: key);
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
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pokemon.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
