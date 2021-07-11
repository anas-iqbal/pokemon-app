import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/home/home_cubit.dart';
import 'package:pokemon_app/bloc/home/home_states.dart';
import 'package:pokemon_app/bloc/login/login_cubit.dart';
import 'package:pokemon_app/screens/favourite_screen.dart';
import 'package:pokemon_app/screens/login_screen.dart';
import 'package:pokemon_app/utils/app_theme.dart';
import 'package:pokemon_app/utils/loader_widget.dart';
import 'package:pokemon_app/widgets/dialogs.dart';
import 'package:pokemon_app/widgets/list_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit homeCubit;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context, listen: false);
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is LoadingAPIFailState) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(message: state.exceptionData.message);
            });
      } else if (state is LogoutSuccessState) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider<LoginCubit>(
                create: (context) => LoginCubit(),
                child: LoginScreen(),
              );
            },
          ),
          (Route<dynamic> route) => false,
        );
      }
    }, builder: (context, state) {
      // if (state is InitialState || state is LoadingAPIFailState) {
      //   return Container();
      // } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colorPrimary,
          title: Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            SizedBox(
              width: 3,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                                  value: homeCubit,
                                  child: FavouriteScreen(),
                                )),
                      );
                      setState(() {});
                    },
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                homeCubit.logoutUser();
              },
              child: Icon(
                Icons.logout,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            SizedBox(
              width: 3,
            )
          ],
        ),
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
                            onFavouriteClick: (selectedPokemon, status) {
                              var x = BlocProvider.of<HomeCubit>(context,
                                  listen: false);
                              x.changeFavouriteStatus(selectedPokemon, status);
                              setState(() {});
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
      // }
    });
  }
}
