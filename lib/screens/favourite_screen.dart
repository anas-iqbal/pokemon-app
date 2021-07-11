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
import 'package:pokemon_app/widgets/favourite_tile.dart';
import 'package:pokemon_app/widgets/list_tile.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  HomeCubit homeCubit;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: AppBarWidget(
            title: 'Favourites',
            showBasket: false,
          )),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.02,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: homeCubit.favouriteList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FavouriteTile(
                      pokemon: homeCubit.favouriteList[index],
                      removeClick: (selectedPokemon, status) {
                        var x =
                            BlocProvider.of<HomeCubit>(context, listen: false);
                        x.changeFavouriteStatus(selectedPokemon, status);
                        setState(() {});
                      },
                    );
                  })),
        ),
      ),
    );
  }
}
