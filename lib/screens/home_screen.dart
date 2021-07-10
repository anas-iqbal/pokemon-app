import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/home/home_cubit.dart';
import 'package:pokemon_app/bloc/home/home_states.dart';
import 'package:pokemon_app/bloc/login/login_cubit.dart';
import 'package:pokemon_app/screens/home_screen.dart';
import 'package:pokemon_app/screens/login_screen.dart';
import 'package:pokemon_app/utils/app_theme.dart';
import 'package:pokemon_app/utils/loader_widget.dart';
import 'package:pokemon_app/widgets/appbar_widget.dart';
import 'package:pokemon_app/widgets/list_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeCubit;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeCubit = BlocProvider.of<HomeCubit>(context, listen: false);
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is LoadedApiSuccessState) {
        var abc = state.pokemonList;
      }
    }, builder: (context, state) {
      if (state is InitialState || state is LoadingAPIFailState) {
        return Container();
      } else {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: AppBarWidget(
                title: 'Pokemons',
                showBasket: true,
              )),
          body: LoaderWidget(
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
                          itemCount: state.pokemonList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PokemonListTile(
                              pokemon: state.pokemonList[index],
                              onFavouriteClick: (selectedPokemon) {
                                homeCubit.markPokemonFavourite(selectedPokemon);
                              },
                              homeCubit: homeCubit,
                            );
                          })
                      : Container(),
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
