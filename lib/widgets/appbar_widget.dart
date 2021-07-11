import 'package:flutter/material.dart';
import 'package:pokemon_app/utils/app_theme.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final showBasket;
  AppBarWidget({@required this.title, this.showBasket = true});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: AppTheme.colorPrimary,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: width * 0.05),
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
