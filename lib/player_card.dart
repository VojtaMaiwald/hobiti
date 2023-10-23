import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobiti/Entities/player_entity.dart';
import 'package:hobiti/constants.dart';
import 'package:hobiti/cubit/game_cubit.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({Key? key, required this.player}) : super(key: key);

  final PlayerEntity player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Constants.mainPadding,
        left: Constants.mainPadding,
      ),
      child: InkWell(
        highlightColor: Constants.transparentColor,
        splashColor: Constants.transparentColor,
        onTap: () {
          context.read<GameCubit>().selectPlayer(player.id);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: Constants.toggleAnimationDuration),
          curve: Curves.easeInOut,
          width: min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) - Constants.mainPadding * 2,
          decoration: BoxDecoration(
            color: player.selected ? Constants.primaryColor : Constants.secondaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Constants.borderRadius),
            border: Border.all(
              color: player.selected ? Constants.secondaryColor : Constants.primaryColor,
              width: Constants.borderWidth,
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Constants.mainPadding),
                  child: Text(
                    player.name,
                    style: TextStyle(
                      fontSize: Constants.nameFontSize,
                      fontWeight: FontWeight.bold,
                      color: player.selected ? Constants.backgoundColor : Constants.onBackgoundColor,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  color: player.selected ? Constants.secondaryColor : Constants.primaryColor,
                  width: Constants.borderWidth,
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.all(Constants.innerPadding),
                  child: SizedBox(
                    width: Constants.pointSectionWidth,
                    child: Center(
                      child: Text(
                        player.points.toString(),
                        style: TextStyle(
                          fontSize: Constants.pointsFontSize,
                          fontWeight: FontWeight.bold,
                          color: player.selected ? Constants.backgoundColor : Constants.onBackgoundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
