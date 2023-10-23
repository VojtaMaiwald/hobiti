import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobiti/constants.dart';
import 'package:hobiti/cubit/game_cubit.dart';
import 'package:hobiti/player_card.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget _getPointButton(BuildContext context, bool positive, int points) {
    //TODO fix splash animation
    return InkWell(
      onTap: () {
        context.read<GameCubit>().addPoints(points);
      },
      child: Container(
        width: Constants.pointsButtonWidth,
        height: Constants.pointsButtonHeight,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Constants.borderRadiusSecondary),
          color: positive ? Constants.positiveColor : Constants.negativeColor,
        ),
        child: Center(
          child: Text(
            "${positive ? "+" : ""}$points",
            style: const TextStyle(
              fontSize: Constants.nameFontSize,
              fontWeight: FontWeight.bold,
              color: Constants.onBackgoundColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPointButtons(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(
          top: Constants.mainPadding,
          left: Constants.mainPadding,
        ),
        child: Wrap(
          verticalDirection: VerticalDirection.up,
          direction: MediaQuery.of(context).orientation == Orientation.portrait ? Axis.horizontal : Axis.vertical,
          children: [
            _getPointButton(context, false, -1),
            _getPointButton(context, false, -5),
            _getPointButton(context, true, 1),
            _getPointButton(context, true, 5),
            _getPointButton(context, true, 10),
            FloatingActionButton(
              elevation: 0,
              backgroundColor: Constants.secondaryColor,
              onPressed: () {
                //TODO add player
              },
              child: const Icon(
                Icons.edit,
                color: Constants.primaryColor,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _getPlayers() {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Wrap(
          children: state.players
              .map(
                (player) => PlayerCard(
                  player: player,
                ),
              )
              .toList(),
        );
      },
    );
  }

  ThemeData _getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        background: Constants.backgoundColor,
        primary: Constants.primaryColor,
        secondary: Constants.secondaryColor,
        onPrimary: Constants.onPrimaryColor,
        onSecondary: Constants.onSecondaryColor,
        onBackground: Constants.onBackgoundColor,
        error: Constants.errorColor,
        onError: Constants.onErrorColor,
        brightness: Brightness.dark,
        surface: Constants.backgoundColor,
        onSurface: Constants.onBackgoundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(),
      child: MaterialApp(
        theme: _getTheme(),
        home: Scaffold(
          body: SafeArea(
            child: Wrap(
              children: [
                _getPlayers(),
                _getPointButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
