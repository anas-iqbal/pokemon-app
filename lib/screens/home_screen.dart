import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/home/home_cubit.dart';
import 'package:pokemon_app/bloc/home/home_states.dart';
import 'package:pokemon_app/bloc/login/login_cubit.dart';
import 'package:pokemon_app/screens/home_screen.dart';
import 'package:pokemon_app/screens/login_screen.dart';
import 'package:pokemon_app/utils/loader_widget.dart';
import 'package:pokemon_app/widgets/list_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is LoadedApiSuccessState) {
        var abc = state.pokemonList;
      }
    }, builder: (context, state) {
      if (state is InitialState || state is LoadingAPIFailState) {
        return Container();
      } else {
        return LoaderWidget(
          isTrue: state is LoadingState ? state.isLoading : false,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.02,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: state is LoadedApiSuccessState
                    ? ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.pokemonList.results.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PokemonListTile(
                              pokemon: state.pokemonList.results[index]);
                        })
                    : Container(
                        color: Colors.lightBlue,
                      ),
              ),
            ),
          ),
        );
      }
    });
  }
}
